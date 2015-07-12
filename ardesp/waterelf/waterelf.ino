/////////////////////////////////////////////////////////////////////////////
// waterelf.ino
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <DNSServer.h>
#include <OneWire.h>

/////////////////////////////////////////////////////////////////////////////
// wifi management stuff
const byte DNS_PORT = 53;
IPAddress apIP(192, 168, 1, 1);
IPAddress netMsk(255, 255, 255, 0);
DNSServer dnsServer;
ESP8266WebServer server(80);
const char* ssid = "WaterElf";

/////////////////////////////////////////////////////////////////////////////
// page generation stuff
const char* pageTop =
  "<html><head><title>WaterElf Aquaponics Helper";
const char* pageTop2 = "</title>\n"
  "<style>body{background:#FFF;color: #000;font-family: sans-serif;}</style>"
  "</head><body>\n";
const char* pageDefault =
  "<h2>Welcome to WaterElf</h2>\n"
  "<h2>Control</h2>"
  "<p><ul>"
  "<li><a href='/wifi'>join a wifi network</a></li>"
  "<li><a href='/wifistatus'>wifi status</a></li>"
  "<li>TODO actuator links go here...</li>"
  "</ul></p>"
  "<h2>Monitor</h2>"
  "<p><ul>"
  "<li><a href='/data'>sensor data</a></li>"
  "</ul></p>\n";
const char* pageFooter =
  "\n<p><a href='/'>WaterElf</a>&nbsp;&nbsp;&nbsp;"
  "<a href='https://www.fish4tea.net/'>Fish4Tea</a></p></body></html>";

/////////////////////////////////////////////////////////////////////////////
// data monitoring stuff
const int MONITOR_POINTS = 60; // number of data points to store
struct monitor_t {
  unsigned long timestamp;
  float celsius;
  float fahrenheit;
};
monitor_t monitorData[MONITOR_POINTS];
int monitorCursor = 0;
int monitorSize = 0;
const int DATA_ENTRIES = 30; // size of /data report; must be <= MONITOR_POINTS
void updateSensorData(monitor_t *monitorData);
void getTemperature(float* celsius, float* fahrenheit);
void printMonitorEntry(monitor_t m, String* buf);

/////////////////////////////////////////////////////////////////////////////
// temperature sensor stuff
OneWire ds(2); // on pin 2 (a 4.7K resistor is necessary)

/////////////////////////////////////////////////////////////////////////////
// init and main loop ///////////////////////////////////////////////////////
void setup() {
  Serial.begin(115200);
  // Serial.setDebugOutput(true);

  WiFi.mode(WIFI_AP_STA);
  WiFi.softAPConfig(apIP, apIP, netMsk);
  WiFi.softAP(ssid);

  Serial.print("SSID: ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.softAPIP());

  dnsServer.setErrorReplyCode(DNSReplyCode::NoError);
  dnsServer.start(DNS_PORT, "*", apIP);

  Serial.println("DNS Server started");

  server.on("/", handle_root);
  server.on("/generate_204", handle_root); // Android support
  server.on("/L0", handle_root);
  server.on("/L2", handle_root);
  server.on("/ALL", handle_root);
  server.onNotFound(handleNotFound);

  server.on("/wifi", handle_wifi);
  server.on("/wifistatus", handle_wifistatus);
  server.on("/chz", handle_chz);
  server.on("/data", handle_data);
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  // TODO print resource usage data

// TODO better resource manageme: perhaps
/*
  int ticks = 0;
  const int MONITOR_FREQUENCY = 100; // once every 100 ticks
  ...
  if(++ticks % MONITOR_FREQUENCY == 0) {
    updateSensorData(monitorData);
    delay(100);
  }

*/

  dnsServer.processNextRequest();
  server.handleClient();
  delay(100);

  //int m = monitorCursor;
  updateSensorData(monitorData);
  // Serial.print("monitorData[monitorCursor].celsius:" );
  // Serial.println(monitorData[m].celsius);
  delay(100);
}

/////////////////////////////////////////////////////////////////////////////
// wifi management stuff ////////////////////////////////////////////////////
void handleNotFound() {
  Serial.print("URI Not Found: ");
  Serial.println(server.uri());
  // TODO send redirect to /? or just use handle_root?
  server.send(200, "text/plain", "URI Not Found");
}

void handle_root() {
  Serial.println("serving page notionally at /");
  String toSend = pageTop;
  toSend += pageTop2;
  toSend += pageDefault;
  toSend += pageFooter;
  server.send(200, "text/html", toSend);
  delay(100);
}

// TODO handle_actuator form

void handle_data() {
  Serial.println("serving page at /data");
  String toSend = pageTop;
  toSend += ": Sensor Data";
  toSend += pageTop2;
  toSend += "<pre>\n";

  Serial.print("monitorCursor="); Serial.print(monitorCursor);
  Serial.print(" monitorSize=");  Serial.println(monitorSize);
  int mSize = monitorSize;
  for(
    int i = monitorCursor - 1, j = 1;
    j <= DATA_ENTRIES && j <= monitorSize;
    i--, j++
  ) {
    Serial.print("printMonitorEntry(monitorData["); Serial.print(i); 
    Serial.println("], &toSend)");
    printMonitorEntry(monitorData[i], &toSend);
    toSend += "\n";
    if(i == 0)
      i = MONITOR_POINTS;
  }

  toSend += "</pre>\n";
  toSend += pageFooter;
  server.send(200, "text/html", toSend);
  delay(100);
}

String genAPForm() {
  String f = pageTop;
  f += ": Wifi Config";
  f += pageTop2;
  f += "<h2>Choose a wifi access point to join</h2><p>\n";

  const char *checked = " checked";

  int n = WiFi.scanNetworks();
  Serial.println("scan done");
  if(n == 0) {
    Serial.println("no networks found");
    f += "No wifi access points found :-( ";
    f += "<a href='/'>Back</a><br/><a href='/wifi'>Try again?</a></p>\n";
  } else {
    Serial.print(n);
    Serial.println(" networks found");
    f += "<form method='POST' action='chz'> ";
    for(int i = 0; i < n; ++i) {
      // print SSID and RSSI for each network found
      Serial.print(i + 1);
      Serial.print(": ");
      Serial.print(WiFi.SSID(i));
      Serial.print(" (");
      Serial.print(WiFi.RSSI(i));
      Serial.print(")");
      Serial.println((WiFi.encryptionType(i) == ENC_TYPE_NONE)?" ":"*");
      delay(10);

      f.concat("<input type='radio' name='ssid' value='");
      f.concat(WiFi.SSID(i));
      f.concat("'");
      f.concat(checked);
      f.concat(">");
      f.concat(WiFi.SSID(i));
      f.concat("<br/>\n");
      checked = "";
    }
    f += "<br/>Pass key: <input type='textarea' name='key'><br/><br/> ";
    f += "<input type='submit' value='Submit'></form></p>";
  }
  Serial.println("");

  f += pageFooter;
  return f;
}

void handle_wifi() {
  Serial.println("serving page at /wifi");
  String toSend = genAPForm();
  server.send(200, "text/html", toSend);
  delay(100);
}

void handle_wifistatus() {
  Serial.println("serving page at /wifistatus");

  String toSend = pageTop;
  toSend += ": Wifi Status";
  toSend += pageTop2;
  toSend += "<h2>Wifi Status</h2><p><ul>";

  toSend += "<li>SSID: ";
  toSend += WiFi.SSID();
  toSend += "</li>";
  toSend += "<li>Status: ";
  switch(WiFi.status()) {
    case WL_IDLE_STATUS:
      toSend += "WL_IDLE_STATUS</li>"; break;
    case WL_NO_SSID_AVAIL:
      toSend += "WL_NO_SSID_AVAIL</li>"; break;
    case WL_SCAN_COMPLETED:
      toSend += "WL_SCAN_COMPLETED</li>"; break;
    case WL_CONNECTED:
      toSend += "WL_CONNECTED</li>"; break;
    case WL_CONNECT_FAILED:
      toSend += "WL_CONNECT_FAILED</li>"; break;
    case WL_CONNECTION_LOST:
      toSend += "WL_CONNECTION_LOST</li>"; break;
    case WL_DISCONNECTED:
      toSend += "WL_DISCONNECTED</li>"; break;
    default:
       toSend += "unknown</li>";
  }
  toSend += "</ul></p>";

  toSend += pageFooter;
  server.send(200, "text/html", toSend);
  delay(100);
}

void handle_chz() {
  Serial.println("serving page at /chz");
  String toSend = pageTop;
  toSend += ": joining wifi network";
  toSend += pageTop2;
  String ssid = "";
  String key = "";

  for(uint8_t i = 0; i < server.args(); i++ ) {
    Serial.println(" " + server.argName(i) + ": " + server.arg(i) + "\n");
    if(server.argName(i) == "ssid")
      ssid = server.arg(i);
    else if(server.argName(i) == "key")
      key = server.arg(i);
  }

  if(ssid == "") {
    toSend += "<h2>Ooops, no SSID...?</h2>";
    toSend += "<p>Looks like a bug :-(</p>";
  } else {
    toSend += "<h2>Done! Joining...</h2>";
    toSend += "<p>Check <a href='/wifistatus'>wifi status here</a>.</p>";
    char ssidchars[sizeof(ssid)];
    char keychars[sizeof(key)];
    ssid.toCharArray(ssidchars, sizeof(ssid));
    key.toCharArray(keychars, sizeof(key));
    WiFi.begin(ssidchars, keychars);
  }

  toSend += pageFooter;
  server.send(200, "text/html", toSend);
  delay(100);
}

/////////////////////////////////////////////////////////////////////////////
// sensor stuff /////////////////////////////////////////////////////////////
void updateSensorData(monitor_t *monitorData) {
  // Serial.print("monitorCursor = "); Serial.print(monitorCursor);
  // Serial.print(" monitorSize = ");  Serial.println(monitorSize);

  monitor_t* now = &monitorData[monitorCursor];
  if(monitorSize < MONITOR_POINTS)
    monitorSize++;
  now->timestamp = millis();
  getTemperature(&now->celsius, &now->fahrenheit);

  if(++monitorCursor == MONITOR_POINTS)
    monitorCursor = 0;
}

void printMonitorEntry(monitor_t m, String* buf) {
  buf->concat("timestamp: ");
  buf->concat(m.timestamp);
  buf->concat(", celsius: ");
  buf->concat(m.celsius);
  buf->concat(", fahrenheit: ");
  buf->concat(m.fahrenheit);
}

void getTemperature(float* celsius, float* fahrenheit) {
  byte i;
  byte present = 0;
  byte type_s;
  byte data[12];
  byte addr[8];
  float _celsius = *celsius;
  float _fahrenheit = *fahrenheit;
  Serial.println("getTemperature()...");

  while(!ds.search(addr)) {
    Serial.println("  no more addresses; resetting...");
    ds.reset_search();
    delay(250);
  }

  if(OneWire::crc8(addr, 7) != addr[7]) {
      Serial.println("  CRC is not valid!");
      return;
  }

  // the first ROM byte indicates which chip
  switch(addr[0]) {
    case 0x10:
      Serial.print("  chip=DS18S20");  // or old DS1820
      type_s = 1;
      break;
    case 0x28:
      Serial.println("  chip=DS18B20");
      type_s = 0;
      break;
    case 0x22:
      Serial.println("  chip=DS1822");
      type_s = 0;
      break;
    default:
      Serial.println("  device is not a DS18x20 family device :-(");
      return;
  }

  ds.reset();
  ds.select(addr);
  ds.write(0x44, 1);    // start conversion, with parasite power on at the end

  delay(1000);          // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it

  present = ds.reset();
  ds.select(addr);
  ds.write(0xBE);       // read scratchpad

  Serial.print(" ; data=");
  Serial.print(present, HEX);
  Serial.print(" ");
  for(i = 0; i < 9; i++) { // we need 9 bytes
    data[i] = ds.read();
    Serial.print(data[i], HEX);
    Serial.print(" ");
  }
  Serial.print(" CRC=");
  Serial.print(OneWire::crc8(data, 8), HEX);
  Serial.println();

  // convert the data to actual temperature
  // because the result is a 16 bit signed integer, it should
  // be stored to an "int16_t" type, which is always 16 bits
  // even when compiled on a 32 bit processor
  int16_t raw = (data[1] << 8) | data[0];
  if(type_s) {
    raw = raw << 3;     // 9 bit resolution default
    if(data[7] == 0x10) {
      // "count remain" gives full 12 bit resolution
      raw = (raw & 0xFFF0) + 12 - data[6];
    }
  } else {
    byte cfg = (data[4] & 0x60);
    // at lower res, the low bits are undefined, so let's zero them
    if(cfg == 0x00) raw = raw & ~7;  // 9 bit resolution, 93.75 ms
    else if(cfg == 0x20) raw = raw & ~3; // 10 bit res, 187.5 ms
    else if(cfg == 0x40) raw = raw & ~1; // 11 bit res, 375 ms
    // default is 12 bit resolution, 750 ms conversion time
  }
  _celsius = (float) raw / 16.0;
  _fahrenheit = _celsius * 1.8 + 32.0;
  Serial.print("  temperature = ");
  Serial.print(_celsius);
  Serial.print(" celsius, ");
  Serial.print(_fahrenheit);
  Serial.println(" fahrenheit");

  *celsius = _celsius;
  *fahrenheit = _fahrenheit;
  return;
}

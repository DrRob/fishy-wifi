-- wegrow.lua: top level entry point for the WeGrow sensor/actuator board
w={}
local steps = { "bat", "sense", "talk" } -- processing sequence
local sleeptime = 3     -- deepsleep duration after each step (in seconds)
local stepf="step.txt"  -- persistence file for the next step index
w.datafile="memory.lua" -- general key/value persistence file
local function store(k, v)  -- remember a key/value pair
  file.open(w.datafile, "a")
  file.write(k .. "=" .. '"' .. v .. '", ')
  file.close()
end
function w.run()
  -- joinme is not a step coz we don't want to sleep if already got wifi config
  -- TODO make joinme a step, and add sleep=false to rtn, tested at end below
  print("starting wifi setup, heap= ", node.heap()) -- DEBUG
  if file.open("skipj.txt") then        -- we're already configured
    print("skipj exists")               -- DEBUG
    file.close()
  else
    j=require("j")
    return wifi.sta.getap(j.aplstn)     -- joinme entry point
  end
  print("wifi config finished, heap= ", node.heap()) -- DEBUG

  -- TODO setup timer to go to deep sleep, in case a step doesn't return
  step=1 -- index into the list of steps; 1 by default, or set from file
  if file.open(stepf, "r") then step = 0 + file.read(); file.close() end
  stepname = steps[step]
  print("taking a step: ", stepname)    -- DEBUG
  stepresults = require(stepname).run()
  for k,v in pairs(stepresults) do store(k, v) end

  if step == #steps then step = 0 end
  file.open(stepf, "w")
  file.write(step + 1)
  file.close()

  print("sleeping for ", sleeptime, " secs...") -- DEBUG
  node.dsleep(sleeptime * 1000000)
end
return w

EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:ESP8266
LIBS:1wire
LIBS:aquaponics system-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Aquaponics System"
Date "Fri 26 Jun 2015"
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R?
U 1 1 558D5924
P 7500 3100
F 0 "R?" V 7592 3098 50  0000 C CNN
F 1 "4.7K" V 7416 3104 50  0000 C CNN
F 2 "" V 7430 3100 30  0000 C CNN
F 3 "" H 7500 3100 30  0000 C CNN
	1    7500 3100
	-1   0    0    -1  
$EndComp
$Comp
L SPST SW?
U 1 1 558D593A
P 1700 5000
F 0 "SW?" H 1400 5050 50  0000 C CNN
F 1 "SPST" H 1700 4900 50  0001 C CNN
F 2 "" H 1700 5000 60  0000 C CNN
F 3 "" H 1700 5000 60  0000 C CNN
	1    1700 5000
	0    1    1    0   
$EndComp
$Comp
L SPST SW?
U 1 1 558D5941
P 2450 5300
F 0 "SW?" H 2150 5350 50  0000 C CNN
F 1 "SPST" H 2450 5200 50  0001 C CNN
F 2 "" H 2450 5300 60  0000 C CNN
F 3 "" H 2450 5300 60  0000 C CNN
	1    2450 5300
	0    1    1    0   
$EndComp
$Comp
L SPST SW?
U 1 1 558D5948
P 2700 5400
F 0 "SW?" H 2400 5450 50  0000 C CNN
F 1 "SPST" H 2700 5300 50  0001 C CNN
F 2 "~" H 2700 5400 60  0001 C CNN
F 3 "" H 2700 5400 60  0000 C CNN
	1    2700 5400
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 558D594F
P 3550 4200
F 0 "R?" V 3630 4200 50  0000 C CNN
F 1 "1.2K" V 3472 4204 50  0000 C CNN
F 2 "" V 3480 4200 30  0000 C CNN
F 3 "" H 3550 4200 30  0000 C CNN
	1    3550 4200
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 558D5956
P 3550 4450
F 0 "R?" V 3630 4450 50  0000 C CNN
F 1 "1.2K" V 3480 4450 50  0000 C CNN
F 2 "" V 3480 4450 30  0000 C CNN
F 3 "" H 3550 4450 30  0000 C CNN
	1    3550 4450
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 558D595D
P 3550 4700
F 0 "R?" V 3630 4700 50  0000 C CNN
F 1 "1.2K" V 3475 4703 50  0000 C CNN
F 2 "" V 3480 4700 30  0000 C CNN
F 3 "" H 3550 4700 30  0000 C CNN
	1    3550 4700
	0    1    1    0   
$EndComp
Text Notes 1300 3000 0    60   ~ 0
PH PROBE
Text Notes 9100 3950 2    60   ~ 0
TEMP PROBE
Text Notes 1200 5550 0    60   ~ 0
WATER\nLEVEL\nSWITCHES
$Comp
L GND #PWR?
U 1 1 558D59FE
P 3550 6450
F 0 "#PWR?" H 3550 6200 50  0001 C CNN
F 1 "GND" H 3550 6300 50  0000 C CNN
F 2 "" H 3550 6450 60  0000 C CNN
F 3 "" H 3550 6450 60  0000 C CNN
	1    3550 6450
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 558D44BB
P 3550 4950
F 0 "R?" V 3630 4950 50  0000 C CNN
F 1 "1.2K" V 3475 4953 50  0000 C CNN
F 2 "" V 3480 4950 30  0000 C CNN
F 3 "" H 3550 4950 30  0000 C CNN
	1    3550 4950
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 558D44FB
P 3550 5200
F 0 "R?" V 3630 5200 50  0000 C CNN
F 1 "1.2K" V 3475 5203 50  0000 C CNN
F 2 "" V 3480 5200 30  0000 C CNN
F 3 "" H 3550 5200 30  0000 C CNN
	1    3550 5200
	0    1    1    0   
$EndComp
$Comp
L SPST SW?
U 1 1 558D4A92
P 1950 5100
F 0 "SW?" H 1650 5150 50  0000 C CNN
F 1 "SPST" H 1950 5000 50  0001 C CNN
F 2 "" H 1950 5100 60  0000 C CNN
F 3 "" H 1950 5100 60  0000 C CNN
	1    1950 5100
	0    1    1    0   
$EndComp
$Comp
L SPST SW?
U 1 1 558D4BC2
P 2200 5200
F 0 "SW?" H 1900 5250 50  0000 C CNN
F 1 "SPST" H 2200 5100 50  0001 C CNN
F 2 "" H 2200 5200 60  0000 C CNN
F 3 "" H 2200 5200 60  0000 C CNN
	1    2200 5200
	0    1    1    0   
$EndComp
$Comp
L +3V3 #PWR?
U 1 1 55929295
P 5400 2450
F 0 "#PWR?" H 5400 2300 50  0001 C CNN
F 1 "+3V3" H 5400 2590 50  0000 C CNN
F 2 "" H 5400 2450 60  0000 C CNN
F 3 "" H 5400 2450 60  0000 C CNN
	1    5400 2450
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 5592945E
P 6200 2800
F 0 "C?" H 6225 2900 50  0000 L CNN
F 1 "100n" H 6225 2700 50  0000 L CNN
F 2 "" H 6238 2650 30  0000 C CNN
F 3 "" H 6200 2800 60  0000 C CNN
	1    6200 2800
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR?
U 1 1 5592951F
P 6200 3000
F 0 "#PWR?" H 6200 2750 50  0001 C CNN
F 1 "GND" H 6200 2850 50  0000 C CNN
F 2 "" H 6200 3000 60  0000 C CNN
F 3 "" H 6200 3000 60  0000 C CNN
	1    6200 3000
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 559296F7
P 6700 4450
F 0 "R?" V 6780 4450 50  0000 C CNN
F 1 "10K" V 6700 4450 50  0000 C CNN
F 2 "" V 6630 4450 30  0000 C CNN
F 3 "" H 6700 4450 30  0000 C CNN
	1    6700 4450
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 55929835
P 6700 3100
F 0 "R?" V 6780 3100 50  0000 C CNN
F 1 "10K" V 6700 3100 50  0000 C CNN
F 2 "" V 6630 3100 30  0000 C CNN
F 3 "" H 6700 3100 30  0000 C CNN
	1    6700 3100
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 55929AA7
P 3900 3050
F 0 "R?" V 3980 3050 50  0000 C CNN
F 1 "10K" V 3900 3050 50  0000 C CNN
F 2 "" V 3830 3050 30  0000 C CNN
F 3 "" H 3900 3050 30  0000 C CNN
	1    3900 3050
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 5592A0AE
P 3700 3050
F 0 "R?" V 3780 3050 50  0000 C CNN
F 1 "10K" V 3700 3050 50  0000 C CNN
F 2 "" V 3630 3050 30  0000 C CNN
F 3 "" H 3700 3050 30  0000 C CNN
	1    3700 3050
	1    0    0    -1  
$EndComp
$Comp
L ESP-12 U?
U 1 1 559120F6
P 5400 3700
F 0 "U?" H 5400 3600 50  0000 C CNN
F 1 "ESP-12" H 5400 3800 50  0000 C CNN
F 2 "" H 5400 3700 50  0001 C CNN
F 3 "" H 5400 3700 50  0001 C CNN
	1    5400 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 6250 6700 6250
Wire Wire Line
	6700 6250 5400 6250
Wire Wire Line
	5400 6250 3550 6250
Wire Wire Line
	3550 6250 2700 6250
Wire Wire Line
	2700 6250 2450 6250
Wire Wire Line
	2450 6250 2200 6250
Wire Wire Line
	2200 6250 1950 6250
Wire Wire Line
	1950 6250 1700 6250
Wire Wire Line
	3550 6250 3550 6450
Connection ~ 3550 6250
Wire Wire Line
	2700 6250 2700 5900
Wire Wire Line
	2200 6250 2200 5700
Connection ~ 2700 6250
Wire Wire Line
	2450 5800 2450 6250
Connection ~ 2450 6250
Wire Wire Line
	1700 4200 3400 4200
Wire Wire Line
	1700 6250 1700 5500
Connection ~ 2200 6250
Wire Wire Line
	1950 5600 1950 6250
Connection ~ 1950 6250
Wire Wire Line
	1700 4500 1700 4200
Wire Wire Line
	1950 4600 1950 4450
Wire Wire Line
	1950 4450 3400 4450
Wire Wire Line
	3400 4700 2200 4700
Wire Wire Line
	2450 4800 3300 4800
Wire Wire Line
	3300 4800 3300 4950
Wire Wire Line
	3300 4950 3400 4950
Wire Wire Line
	2700 4900 3200 4900
Wire Wire Line
	3200 4900 3200 5200
Wire Wire Line
	3200 5200 3400 5200
Wire Wire Line
	5400 4600 5400 6250
Wire Wire Line
	5400 2450 5400 2600
Wire Wire Line
	5400 2600 5400 2800
Wire Wire Line
	3700 2600 3900 2600
Wire Wire Line
	3900 2600 5400 2600
Wire Wire Line
	5400 2600 6200 2600
Wire Wire Line
	6200 2600 6700 2600
Wire Wire Line
	6700 2600 7500 2600
Wire Wire Line
	7500 2600 7850 2600
Connection ~ 5400 2600
Wire Wire Line
	6300 3800 6700 3800
Wire Wire Line
	6700 3800 6700 3250
Wire Wire Line
	6700 4600 6700 6250
Wire Wire Line
	6700 4300 6700 4000
Wire Wire Line
	6700 4000 6300 4000
Wire Wire Line
	4500 3400 3900 3400
Wire Wire Line
	3900 3400 3900 3200
Wire Wire Line
	4500 3600 3700 3600
Wire Wire Line
	3700 3600 3700 3200
Wire Wire Line
	3700 2900 3700 2600
Wire Wire Line
	3900 2900 3900 2600
Connection ~ 3900 2600
Wire Wire Line
	6700 2600 6700 2950
Wire Wire Line
	6200 2650 6200 2600
Connection ~ 6200 2600
Wire Wire Line
	6200 3000 6200 2950
$Comp
L DS18B20 IC?
U 3 1 55929CD9
P 7850 3900
F 0 "IC?" H 8075 3925 50  0000 L BNN
F 1 "DS18B20" H 8075 3825 50  0000 L BNN
F 2 "1wire-TO92-" H 7850 4050 50  0001 C CNN
F 3 "" H 7850 3900 60  0000 C CNN
	3    7850 3900
	1    0    0    -1  
$EndComp
$Comp
L DS18B20 IC?
U 2 1 5592A02C
P 7850 3900
F 0 "IC?" H 8075 3925 50  0000 L BNN
F 1 "DS18B20" H 8075 3825 50  0000 L BNN
F 2 "1wire-TO92-" H 7850 4050 50  0001 C CNN
F 3 "" H 7850 3900 60  0000 C CNN
	2    7850 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 3900 7500 3900
Wire Wire Line
	7500 3900 7650 3900
Connection ~ 7500 3900
Wire Wire Line
	7850 2600 7850 3600
Connection ~ 6700 2600
Wire Wire Line
	7500 3250 7500 3900
Wire Wire Line
	7500 2600 7500 2950
Connection ~ 7500 2600
Wire Wire Line
	7850 4200 7850 6250
Connection ~ 5400 6250
Connection ~ 6700 6250
$EndSCHEMATC

-- wegrow.lua: top level entry point for the WeGrow sensor/actuator board
w={}
-- steps: each is a module defining a run() function which returns a table of
-- results, an optional boolean "stayawake" which controls sleep after the step,
-- and an optional boolean "wait" which indicates *not* to take the next step
local steps = {"bat", "sense", "talk" } -- processing sequence
local sleeptime = 3     -- deepsleep duration after each step (in seconds)
local stepf="step.txt"  -- persistence file for the next step index
w.datafile="memory.lua" -- general key/value persistence file
local function store(k, v)  -- remember a key/value pair
  file.open(w.datafile, "a")
  file.write(k .. "=" .. '"' .. v .. '", ')
  file.close()
end
function w.done(stepresults, stayawake)
   print("stayawake: ", stayawake)      -- DEBUG
  for k,v in pairs(stepresults) do store(k, v) end
  if step == #steps then step = 0 end
  file.open(stepf, "w")
  file.write(step + 1)
  file.close()
  if stayawake then
    return w.run() -- go to next step without sleeping 
  end
  print("sleeping for ", sleeptime, " secs...")       -- DEBUG
  node.dsleep(sleeptime * 1000000)
end
function w.run()
  -- TODO setup timer to go to deep sleep, in case a step doesn't return?
  step=1 -- index into the list of steps; 1 by default, or set from file
  if file.open(stepf, "r") then step = 0 + file.read(); file.close() end
  stepname = steps[step]
  print("taking a step: ", stepname)                    -- DEBUG
  require(stepname).run()
end
return w

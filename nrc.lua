--Nuclear Reactor Control System for IC2
--Simple version 1.0

--varables
reactorSide = "<replace with the redstone output wire side to your computer>"
waitTime = 5 --Change this for a shorter load time
programRunning = true

term.clear()
term.setPos(1,1)
print("Nuclear Reactor Control system.")
print("Loading")
os.sleepTime(waitTime)

local function turnOnReactor()
	redstone.setOutput(reactorSide,true)
	term.clear()
	term.setPos(1,1)
end

local function turnOffReactor()
	redstone.setOutput(reactorSide,false)
	term.clear()
	term.setPos(1,1)
	print("Reactor has turned off, ending program")
	programRunning = false
end

while programRunning do
	turnOnReactor()
	print("Reactor has turned on, press SPACE to turn off, and exit")
	local event, key = os.pullEvent("key")
	if key == 57 then
		turnOffReactor()
		break
	end
end

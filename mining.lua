programRunning = true

function checkFuel()
	i = turtle.getFuelLevel() 
	--How many blocks the miner can mine.
	x = i / 3
	
    print("You have "..tostring(math.floor(x)).." block long tunnel available to mine.")
    sleep(2)
    print("would you like to refuel?")
    print("y/n")
    input = read()
    if input=="y" then
        turtle.refuel(1)
        print("Turtle has been refueled")
    end
end
function dig1()
  if turtle.detect()==true then
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.turnLeft()
	  turtle.turnLeft()
	  turtle.forward()
	  turtle.turnRight()
  end
term.clear()
end
function three()
print("Goodbye")
programRunning = false
sleep(3)
term.clear()
end
local menuOptions = {"Refuel", "Mining", "Exit"}
local termX, termY = term.getSize()
local selected = 1
local strSeperator = string.rep(" ",1)
function centerText(text, termY)
term.setCursorPos(termX/2-#text/2, termY)
term.write(text)
end
function start()
while true do
  term.clear()
  local strMenuLine = "|"
  for i,v in ipairs(menuOptions) do
   if i == selected then
        strMenuLine = strMenuLine..strSeperator.."["..v.."]"
   else
        strMenuLine = strMenuLine..strSeperator.." "..v.." "
   end
   strMenuLine = strMenuLine..strSeperator.."|"
  end
  centerText("+"..string.rep("-",(#strMenuLine-2)).."+",1)
  centerText(strMenuLine,2)
  centerText("+"..string.rep("-",(#strMenuLine-2)).."+",3)
  local id, key = os.pullEvent()
  if id == "key" then
   if key == 205 then
        selected = selected + 1
        if selected > #menuOptions then
         selected = 1
        end
   elseif key == 203 then
        selected = selected - 1
        if selected < 1 then
         selected = #menuOptions
        end
   elseif key == 28 then
        return selected
   end
  end
end
end
while programRunning==true do
x = start()
print()
if x == 1 then
term.clear()
checkFuel()
end
if x == 2 then
        term.clear()
	write("How long do you want the tunnel?    ")
        local Num = tonumber( read() )
        
            for i=1,Num do
                dig1()
            end
end
if x == 3 then
three()
end
end
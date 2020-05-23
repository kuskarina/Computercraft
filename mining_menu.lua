--DECLARE THE VARS

local programRunning = true
local mainMenuOptions = {"Refuel", "Mining", "Exit"}
local fuelMenuOptions = {"Avail", "Refuel", "Main"}
local termX, termY = term.getSize()
local selected = 1
local strSeperator = string.rep(" ",1)

function checkFuel()
	local i = turtle.getFuelLevel() 
	--How many blocks the miner can mine.
	local x = i / 3
	local y = fuelMenu()
	
    if y==1 then
	print("You have "..tostring(math.floor(x)).." block long tunnel available to mine.")
    sleep(2)
	end
    if y==2 then
        turtle.refuel(1)
        print("Turtle has been refueled")
    end
end
--Dig a 2x2 tunnel once
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

--Exit the program
function three()
print("Goodbye")
programRunning = false
sleep(3)
term.clear()
end


--Centering the text and preparing the menu
function centerText(text, termY)
term.setCursorPos(termX/2-#text/2, termY)
term.write(text)
end


--Main menu loop
function mainMenu()
while true do
  term.clear()
  local strMenuLine = "|"
  for i,v in ipairs(mainMenuOptions) do
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
        if selected > #mainMenuOptions then
         selected = 1
        end
   elseif key == 203 then
        selected = selected - 1
        if selected < 1 then
         selected = #mainMenuOptions
        end
   elseif key == 28 then
        return selected
   end
  end
end
end
--Menu function
function fuelMenu()
while true do
--Clears the terminal for the menu
  term.clear()
  local strMenuLine = "|"
  
  --Gets the menu items and parses them from the table
  for i,v in ipairs(fuelMenuOptions) do
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
  
  --Getting the key inputs
  local id, key = os.pullEvent()
  if id == "key" then
   if key == 205 then
        selected = selected + 1
        if selected > #fuelMenuOptions then
         selected = 1
        end
   elseif key == 203 then
        selected = selected - 1
        if selected < 1 then
         selected = #fuelMenuOptions
        end
   elseif key == 28 then
        return selected
   end
  end
end
end

--Main program loop
while programRunning==true do
x = mainMenu()
print()


--Fuel Menu picked
if x == 1 then
term.clear()
checkFuel()
end


--Second option picked
if x == 2 then
        term.clear()
	write("How long do you want the tunnel?    ")
        local Num = tonumber( read() )
        
            for i=1,Num do
                dig1()
            end
end

--Exit the program
if x == 3 then
three()
end
end
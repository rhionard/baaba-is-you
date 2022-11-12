  love.filesystem.load("main.lua")()
      buttons = {}
function drawui()
    buttons = {}

  for i,c in ipairs(images) do
      for j,d in ipairs(c) do
  Button1={}

  local t = palettecolors[getspritevalues(d).color[1]]
  Button1.color1 =  t[getspritevalues(d).color[2]]
  --Button1.color1 = getspritevalues(d).color--{0.5,0.5,0.5}
  Button1.buttonname = d

  Button1.buttonsprite = love.graphics.newImage("sprite/" .. d .. ".png")

    Button1.buttonsize = 10
    Button1.x1 = (j-1)*Button1.buttonsize*3.3
    Button1.y1 = (i-1)*Button1.buttonsize*3.3
  table.insert(buttons,Button1)
   end
end
allbuttons = Buttons
for i,c in ipairs(buttons) do
  love.graphics.setColor(c.color1[1] * 0.6,c.color1[2] * 0.6,c.color1[3] * 0.6)
love.graphics.rectangle("fill",c.x1,c.y1,c.buttonsize*3.3,c.buttonsize*3.3)
love.graphics.setColor(c.color1[1] * 0.4,c.color1[2] * 0.4,c.color1[3] * 0.4) --Button1.color1[1] * 0.4,Button1.color1[2] * 0.4,Button1.color1[3] * 0.4
love.graphics.rectangle("fill",Button1.buttonsize/6+c.x1,Button1.buttonsize/6+c.y1,c.buttonsize*3,c.buttonsize*3,c.buttonsize/3,c.buttonsize/3) --c.buttonsize/6,c.buttonsize*3,c.buttonsize*3,c.buttonsize/3,c.buttonsize/3)
love.graphics.setColor(c.color1)
love.graphics.draw(c.buttonsprite,c.buttonsize/3+c.x1,c.buttonsize/3+c.y1,0,c.buttonsize/10)
end
end
function newalert(alertx,alerty,alertmessage,alertbuttons,alertmessages,alertbuttonsizes,alertbuttonstart)
 for i,c in ipairs(alertmessages) do
   love.graphics.setColor(0.25,0.5,1)
 love.graphics.rectangle("fill", alertx, alerty, 300, 100)
  for j = 1,alertbuttons do
    love.graphics.setColor(0,0.25,1)
    love.graphics.rectangle("fill",  alertbuttonstart[1]+j*(alertbuttonstart[1]-1), alertbuttonstart[2], alertbuttonsizes[j][1], alertbuttonsizes[j][2])
    love.graphics.setColor(0,0,0)
    love.graphics.print(alertmessages[j], alertbuttonstart[1]+j*(alertbuttonstart[1]-1), alertbuttonstart[2])
  end
 end


end

current_textinput = ""
levelname = ""
editlevelname = false
function love.textinput(text)
  if (editlevelname == true) and (text ~= "@")then
   current_textinput = current_textinput .. text
  end
  if(text == "@")then
    editlevelname = not editlevelname
    if not editlevelname then
      levelname = current_textinput
      current_textinput = ""
    end
  end
end

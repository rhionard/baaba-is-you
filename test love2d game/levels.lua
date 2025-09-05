love.filesystem.load("values.lua")()

local saveddata = {
  name = "NAME",
  tilex = "XPOS",
  tiley = "YPOS",
  dir = "DIR",
  levelinside = "LEVEL",
  lock = "LOCK",
  num = "NUM"
}
function saveleveldata(getlvlname)

  local tempObjects = ""
  local temp2 = "PALETTE:" .. palette .. "\nSIZE_X:" .. tostring(levelx) .. "\nSIZE_Y:" .. tostring(levely) .. "\nMUSIC:" .. tostring(levelmusic) .. "\n"
  local last_hh = {}
  for gg,hh in ipairs(editor_curr_objects) do
    local li = ""

    --optimization: we can discard parameters that are the same as the last object that we checked, since it's pretty common for that to be the case,
    --and i already had that be handled in the load function
    for a, b in pairs(saveddata) do
      if hh[a] ~= nil and last_hh[a] ~= hh[a] then

        li = li .. "\n" .. b .. ":" .. hh[a]
      end
    end

  tempObjects = "{" .. li .. "\n}\n"
  temp2 = temp2 .. tempObjects
  last_hh = hh

    --love.filesystem.read(getlvlname)
  end
  temp2 = love.data.compress("string", "zlib", temp2, 6)
  love.filesystem.write("levels/"..getlvlname,temp2)

--  love.graphics.setColor(1,1,1)  ????
  notification.timer = 2
  notification.sprite = love.graphics.newImage("sprite/correct.png")
  notification.sprite_color = {4, 1}
  notification.text = "saved!"
  notification.color = {4, 1}
  notification.size = 2
end

local revisions = {
  skulll = "skull",
  leevel = "level",
  icy = "ice",
  tiles = "tile",
  text_skulll = "text_skull",
  text_leevel = "text_level",
  text_icy = "text_ice",
  text_tiles = "text_tile"
}


function split_by_line(st)
  local result = {}
  local curr = ""
  for i = 1, #st do
    local j = string.sub(st, i, i)
    if j == "\n" then
      table.insert(result, curr)
      curr = ""
    else
      curr = curr .. j
    end
  end

  return result
end
function loadleveldata(levelnamee, editor_add)

    editor_curr_objects = {}
    local objxs = 0
    local objys = 0
    local objnames = ""
    local objdirs = "right"
    local objlevels = nil
    local objnums = nil
    local objlocks = nil

    local levelversion = "?"
    local the_level = love.filesystem.read("levels/"..levelnamee)
    if not the_level then
      notification.timer = 2
      notification.sprite = love.graphics.newImage("sprite/incorrect.png")
      notification.sprite_color = {1, 1}
      notification.text = "failed to load " .. levelnamee .. "!"
      notification.color = {1, 1}
      notification.size = 2

      return
    end
    --TODO: determine level version
    if string.sub(the_level, 1, 1) ~= "{" and string.sub(the_level, 1, 1) ~= "P" then
      the_level = love.data.decompress("string", "zlib", the_level)
      --love.filesystem.write("levels/"..levelnamee,the_level)
    end

    for i, objdata in ipairs(split_by_line(the_level)) do


    if not(objdata == "{") then
      if not(objdata == "}") then
       if (string.sub(objdata,1,5)== "NAME:") then
        objnames = string.sub(objdata,6,string.len(objdata))
        objnames = revisions[objnames] or objnames
       end
       if (string.sub(objdata,1,5) == "XPOS:") then
        objxs = string.sub(objdata,6,string.len(objdata))
       end
       if (string.sub(objdata,1,5) == "YPOS:") then
        objys = string.sub(objdata,6,string.len(objdata))
       end
       if (string.sub(objdata,1,4) == "DIR:") then
        objdirs = string.sub(objdata,5,string.len(objdata))
        if objdirs == "nil" then
          objdirs = "right"
        end
       end
       if (string.sub(objdata,1,6) == "LEVEL:") then
        objlevels = string.sub(objdata,7,string.len(objdata))
       end
       if (string.sub(objdata,1,4) == "NUM:") then
        objnums = string.sub(objdata,5,string.len(objdata))
       end
       if (string.sub(objdata,1,5) == "LOCK:") then
        objlocks = string.sub(objdata,6,string.len(objdata))
       end
       if string.sub(objdata,1,8) == "PALETTE:" then
         for m, n in ipairs(all_palettes) do
           if n == string.sub(objdata,9) then
             palette_id = m
             loadPalette(all_palettes[palette_id])
             initui()
             break
           end
         end
       end
       if string.sub(objdata,1,7) == "SIZE_X:" then
         levelx = tonumber(string.sub(objdata,8))
       end
       if string.sub(objdata,1,7) == "SIZE_Y:" then
         levely = tonumber(string.sub(objdata,8))
       end
       if string.sub(objdata,1,6) == "MUSIC:" then
         levelmusic = tonumber(string.sub(objdata,7))
         playmusic(musiclist[levelmusic])
       end
     elseif objnames ~= "error" then
       if levelversion ~= "v3" then
         if tonumber(objxs) % 30 == 0 and tonumber(objys) % 30 == 0 then
           levelversion = "v1"
         elseif tonumber(objxs) % 24 == 0 and tonumber(objys) % 24 == 0 then
           levelversion = "v1.1"
         else
           levelversion = "v3"
         end
       end

       if editor_add then
         addobject(objnames, tonumber(objxs), tonumber(objys), objdirs, objlevels)
         editor_curr_objects[#editor_curr_objects].num = objnums
         editor_curr_objects[#editor_curr_objects].lock = objlocks
       else
         local ob = makeobject(objnames, tonumber(objxs), tonumber(objys), objdirs, nil, objlevels, true)
         ob.num = objnums
         ob.lock = objlocks
       end

     objlevels = nil
     objnums = nil
     objlocks = nil
    end
  end
  end

  local modify = Objects
  if editor_add then
    modify = editor_curr_objects
  end
  --support for demo levels
  if levelversion == "v1" then
    for i, j in ipairs(modify) do
      i.tilex = i.tilex / 30
      i.tiley = i.tiley / 30
    end
    return
  end
  if levelversion == "v1.1" then
    for i, j in ipairs(modify) do
      i.tilex = i.tilex / 24
      i.tiley = i.tiley / 24
    end
    return
  end

end


function enterlevel(thelevel)
  killparticles()
  table.insert(leveltree, thelevel)
  levelname = ""


  dielevel()
  --love.timer.sleep(0.1)


  --playmusic("nothing")
  gamestate = "menu"
  menu_load("main")
  editor_curr_objects = {}

  gotogame()
  levelname = thelevel
  --oh my god this code is so jank what the hE{"1": {1, 3, 56, 2, 56}}

  dolevelload()
  --love.timer.sleep(0.2)
  loadlevel()
  gotogame()
  --playmusic(musiclist[levelmusic])

  x_offset = (love.graphics.getWidth() - levelx * tilesize) / 2
  y_offset = (love.graphics.getHeight() - (levely + 1) * tilesize) / 2
end


function levelcompleted(l)
  if (love.filesystem.getInfo("progress/levels.txt") == nil) then
    return false
  end

  for objdata in love.filesystem.lines("progress/levels.txt") do
    if string.sub(objdata,1,8) == "cleared=" and string.sub(objdata, 9) == l then
      return true
    end

  end

  return false

end

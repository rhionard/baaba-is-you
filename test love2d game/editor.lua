editor_curr_objects = {}
ineditor = true
function addobject(heldtile,x,y,dir,level_)
  if not ineditor then
    return
  end

  local obj = {}
  obj.size = 1
  obj.x = x *  tilesize
  obj.y = y * tilesize
  obj.tilex = x
  obj.tiley = y


  obj.name = heldtile
      obj.type = getspritevalues(obj.name).type
  obj.sprite = obj.name
  obj.color = getspritevalues(obj.name).color
  obj.dir = dir

  obj.id = #Objects + 1
  obj.transformable = true


  obj.active = true

  if level_ ~= nil then
    obj.levelinside = level_
  end

  updatesprite(obj)

  if obj.tilex > 0 and obj.tilex < (levelx - 1) and obj.tiley > 0 and obj.tiley < levely then
    table.insert(editor_curr_objects,obj)
  end
  update_editor_tiling()

  return obj
end



function delobject (x,y)
  if not ineditor then
    return
  end
  local deleted = false
  for i, j in ipairs(editor_curr_objects) do

    if j.tilex == math.floor(x/tilesize) and j.tiley == math.floor(y/tilesize) then
      table.remove(editor_curr_objects, i)
      deleted = true
    end
  end
  if deleted then
    playsfx("editordelete")
  end

  update_editor_tiling()

end

function draweditor()
  -- Don't draw the editor if we're not already in the editor
  if not ineditor then
    return
  end



  love.graphics.setBackgroundColor(palettecolors[1][5])



  for i, c in ipairs(editor_curr_objects) do

    -- copied from main.lua
   local t = palettecolors[c.color[1]]

   if(t ~= nil) and (t[c.color[2]] ~= nil)then
     love.graphics.setColor(t[c.color[2]])
     if c.lock then
       local a1 = { t[c.color[2]][1] * 0.5, t[c.color[2]][2] * 0.5, t[c.color[2]][3] * 0.5}
       love.graphics.setColor(a1)
     end
   end



   if(c.active == true)then
     local xchange = -((c.sprite:getWidth() - 24) / 2) * (tilesize / 24)
     local ychange = -((c.sprite:getHeight() - 24) / 2) * (tilesize / 24)

     love.graphics.draw(c.sprite,c.x  + x_offset + xchange,c.y  + y_offset + ychange,0,c.size  * (tilesize / 24))
     love.graphics.setColor(1,1,1)

   end

   love.graphics.setColor(1,0,0)

   if string.sub(c.name,1,10) == "text_text_" then
     love.graphics.setColor(1,0,0.5)
     love.graphics.draw(textmeta,c.x  + x_offset,c.y  + y_offset,0,c.size * (tilesize / 24))
   end

   if(c.name == "clock")then
     local hour = os.date("*t",os.time()).hour

     if(tonumber(hour) == 0)then
       hour = "12"
     end

     if(string.len(hour) == 1)then
       hour = "0" .. hour
     end

     if(tonumber(hour) > 12)then
       hour = tostring(tonumber(hour) - 12)
     end

     local min = os.date("*t",os.time()).min

     if(string.len(min) == 1)then
       min = "0" .. min
     end

     love.graphics.print(hour .. ":" .. min,c.x + 1 + x_offset,c.y+tilesize/3+1  + y_offset,0,1.3)
   elseif c.name == "calendar" then
     love.graphics.setColor(0,0,0)
     local date = os.date("*t",os.time()).day
     love.graphics.draw(love.graphics.newImage("sprite/calendarnumbers/c" .. tostring(date) .. ".png"),c.x  + x_offset,c.y  + y_offset,0,c.size * (tilesize / 24))

   elseif c.num ~= nil then
     love.graphics.draw(love.graphics.newImage("sprite/calendarnumbers/c" .. tostring(c.num) .. ".png"),c.x  + x_offset - 3,c.y  + y_offset - 1 ,0,c.size * (tilesize / 24))

   end

  end


  if heldtile ~= "" then
      -- copied from main.lua
     local heldsprite = heldtile

     local place_x, place_y = math.floor(love.mouse.getX()/  tilesize  ) * tilesize, math.floor(love.mouse.getY()/  tilesize  ) * tilesize
     if place_x > 0 and place_x < (levelx - 1) * tilesize and place_y > 0 and place_y < levely * tilesize then
       local heldrotate = getspritevalues(heldtile).rotate
       if ((heldrotate == 4) or (heldrotate == 6)) and type(helddir) == "string" then

         heldsprite =  heldtile .. "-" .. helddir

       end

      local tcolor = getspritevalues(heldtile).color
       local t = palettecolors[tcolor[1]]

       if(t ~= nil) and (t[tcolor[2]] ~= nil)then
         love.graphics.setColor(t[tcolor[2]][1], t[tcolor[2]][2], t[tcolor[2]][3], 0.5)

       end


         local csprite = nil
         if string.sub(heldsprite,1,10) == "text_text_" then
           csprite = love.graphics.newImage("sprite/" .. string.sub(heldsprite,6,-1) .. ".png")
         else
           csprite = love.graphics.newImage("sprite/" .. heldsprite .. ".png")
         end
         local xchange = -((csprite:getWidth() - 24) / 2) * (tilesize / 24)
         local ychange = -((csprite:getHeight() - 24) / 2) * (tilesize / 24)
         love.graphics.draw(csprite,place_x  + x_offset + xchange,place_y + y_offset + ychange,0,(tilesize / 24))

       love.graphics.setColor(1,0,0)

       if love.keyboard.isDown("m") then
         love.graphics.setColor(1,0,0.5, 0.5)
         love.graphics.draw(love.graphics.newImage("sprite/textMeta.png"),place_x  + x_offset,place_y  + y_offset,0,(tilesize / 24))
       end
     end

   end


   if eyedrop then
      local place_x, place_y = math.floor(love.mouse.getX()/  tilesize  ) * tilesize, math.floor(love.mouse.getY()/  tilesize  ) * tilesize
      if place_x > 0 and place_x < (levelx - 1) * tilesize and place_y > 0 and place_y < levely * tilesize then


       local tcolor = {3,1}
        local t = palettecolors[tcolor[1]]

        if(t ~= nil) and (t[tcolor[2]] ~= nil)then
          love.graphics.setColor(t[tcolor[2]][1], t[tcolor[2]][2], t[tcolor[2]][3], 0.5)

        end



          local csprite = love.graphics.newImage("sprite/eyedrop.png")

          love.graphics.draw(csprite,place_x  + x_offset,place_y + y_offset,0,(tilesize / 24))

      end

    end

end

function loadlevel()
  game_paused = false
  chooserule = {}
  oldchooserule = {}
  menu_state = "editor_test"
  ineditor = false
  filecount = 0
  fileimages = {}
  undolist = {}
  currenticon = "baaba"
  idtotal = 0

  DBG = tostring(#editor_curr_objects)
  afterframeone = nil

  for i, j in ipairs(editor_curr_objects) do

      makeobject(j.tilex,j.tiley,j.name,j.dir,j.meta,j.levelinside)
      if j.num ~= nil then
        Objects[#Objects].num = j.num
      end
      if j.lock ~= nil and not levelcompleted(levelname) then
        Objects[#Objects].lock = j.lock
      end

  end
  afterframeone = true

  for i, j in ipairs(Objects) do

    if j.lock ~= nil then
      for a, b in ipairs({"left","up","right","down"}) do

        local superbreak = false

        for c, d in ipairs(gettiles(b, j.tilex, j.tiley, 1)) do
          if d.levelinside ~= nil and levelcompleted(d.levelinside) then
            j.lock = nil
            superbreak = true
            break
          end
        end

        if superbreak then
          break
        end

      end
    end

  end
  parse_text()

  local cb = love.system.getClipboardText()
  for a, b in ipairs(rules) do
    if b[3] == "uncopy" and (matches(b[1], cb, true) or (matches(b[1], "text_" .. cb, true) and is_prop(cb))) then
      love.system.setClipboardText("oops!")
    end
  end

  ingroup = {}
  local groups = objectswithproperty("group")
  for i,group in ipairs(groups) do
    if ingroup[group.id] then
      table.insert(ingroup[group.id], "group")
    else
      ingroup[group.id] = {"group"}
    end
  end
  startproperties(true)

  for i, j in ipairs(Objects) do
    dotiling(j)
    updatesprite(j)
  end

  if not music:isPlaying() then
    music:play()
    music:setLooping(true)
  end

end

idtotal = 0

function loadlevelstuff()
  chooserule = {}
  oldchooserule = {}
  ineditor = false
  filecount = 0
  fileimages = {}
  undolist = {}
  currenticon = "baaba"
  idtotal = 0


  for i, j in ipairs(Objects) do

    if j.lock ~= nil then
      for a, b in ipairs({"left","up","right","down"}) do

        local superbreak = false

        for c, d in ipairs(gettiles(b, j.tilex, j.tiley, 1)) do
          if d.levelinside ~= nil and levelcompleted(d.levelinside) then
            j.lock = nil
            superbreak = true
            break
          end
        end

        if superbreak then
          break
        end

      end
    end

  end
  parse_text()

  local cb = love.system.getClipboardText()
  for a, b in ipairs(rules) do
    if b[3] == "uncopy" and (matches(b[1], cb, true) or (matches(b[1], "text_" .. cb, true) and is_prop(cb))) then
      love.system.setClipboardText("oops!")
    end
  end

  ingroup = {}
  local groups = objectswithproperty("group")
  for i,group in ipairs(groups) do
    if ingroup[group.id] then
      table.insert(ingroup[group.id], "group")
    else
      ingroup[group.id] = {"group"}
    end
  end
  startproperties(true)

  for i, j in ipairs(Objects) do
    dotiling(j)
    updatesprite(j)
  end

  if not music:isPlaying() then
    music:play()
    music:setLooping(true)
  end

end

function dielevel()
  killparticles()
  menu_state = "editor"
  ineditor = true
  Objects = {}
  undolist = {}

  currenticon = "baaba"
  wewinning = false
  theloop = false
  love.window.setIcon(love.image.newImageData("sprite/baaba.png"))

  if not music:isPlaying() then
    music:play()
    music:setLooping(true)
  end

end

function handletilething()
  if selected_obj ~= nil then
    return
  end
  local width, height = love.graphics.getDimensions()

    if (love.mouse.getX() > (width - 100) and love.mouse.getY() > (height - 100) and love.mouse.getX() < (width - 20) and love.mouse.getY() < (height - 40)) then return end
    metaval = 0
   if love.mouse.isDown(1) and ineditor and not (love.mouse.getX() > (width - 100) and love.mouse.getY() > (height - 100) and love.mouse.getX() < (width - 20) and love.mouse.getY() < (height - 40)) then

     if not hideui then
      for i2,c in ipairs(buttons) do
       if love.mouse.getX() > c.x1 and love.mouse.getX() < c.x1 + (3.3 * c.buttonsize) and  love.mouse.getY() > c.y1 and love.mouse.getY() < c.y1 + (3.3 * c.buttonsize) then
         if heldtile ~= c.buttonname then
           playsfx("select")
         end
       heldtile = c.buttonname
       --love.window.setPosition(4,6)
       end
      end

      for i2, c in ipairs(tab_buttons) do
        if love.mouse.getX() > c.x and love.mouse.getX() < c.x + 36 and  love.mouse.getY() > c.y and love.mouse.getY() < c.y + 12 then
          if curr_tab ~= c.name then
            playsfx("select")
          end
          curr_tab = c.name
          initui()
        --love.window.setPosition(4,6)
        end
      end
    end
   end
   if(heldtile ~= "")then
   if love.mouse.isDown(1) then
     if not hideui then
      for i6,c in ipairs(buttons) do
        if love.mouse.getX() > c.x1 - 1 and love.mouse.getX() < c.x1 + (3.3 * c.buttonsize) + 1 and  love.mouse.getY() > c.y1 - 1 and love.mouse.getY() < c.y1 + (3.3 * c.buttonsize) + 1 then
          onbutton = true
        end
      end
    end
    if hideui then
      onbuton = false
    end
    if(onbutton==false) then
      if(love.keyboard.isDown("m") and string.sub(heldtile, 1, 5) == "text_" and string.sub(heldtile, 1, 10) ~= "text_text_") then
      metaval = 1
      end
    --getobject()
    local dot = true

    for i, j in ipairs(editor_curr_objects) do
      if j.tilex == math.floor(love.mouse.getX()/ tilesize ) and j.tiley == math.floor(love.mouse.getY()/ tilesize ) and (j.name == heldtile or (string.sub(j.name,1,5) == "text_" and string.sub(heldtile,1,5) == "text_")) then
        dot = false
      end
    end
    local obx, oby = math.floor(love.mouse.getX()/  tilesize  ),math.floor(love.mouse.getY()/  tilesize  )
     if obx > 0 and obx < (levelx - 1) and oby > 0 and oby < levely and not love.mouse.isDown(2) then
       if dot then
         playsfx("place")
         if metaval ~= 1 then
           addobject(heldtile,obx,oby, helddir )
         else
           addobject("text_"..heldtile,obx,oby, helddir )
         end
       end
     end

    end
    onbutton = false
   end
   end


   if love.mouse.isDown(2) and ineditor then
    for i3,c3 in ipairs(buttons) do
     if(dist(c3.x1+50+c3.buttonsize/2,c3.y1+c3.buttonsize/2,love.mouse.getX(),love.mouse.getY()) < c3.buttonsize/1.5) then
    --do function on right click
     end
    end
    for i5,c5 in ipairs(editor_curr_objects) do
     if(dist(c5.x+tilesize/2,c5.y+tilesize/2,love.mouse.getX(),love.mouse.getY()) < tilesize/1.5) then
     --c5.active = false


        if(love.keyboard.isDown("q") == false)then
         delobject(love.mouse.getX(),love.mouse.getY())
        else
          --love.audio.play(love.audio.newSource("sound/place.wav","static"))
          c5.levelinside = levelname
        end

     end
    end
   end
   --drawui()
 end

editor_tabs = {}
function make_tabs()
  editor_tabs = {}

  tab_names = {"basic", "characters","items","obstacles","rules","decor","abstract","letters","advanced","new","all"}
  tab_colors = {{2,3},{1,2},{3,1},{2,3},{1,2},{6,3},{4,4},{1,2},{1,3},{3,1},{1,2}}
  tab_buttons = {}
  for a, b in ipairs(tab_names) do
    miscsprites["tab_" .. b] = love.graphics.newImage("graphics/tabs/tab_" .. b .. ".png")
    table.insert(tab_buttons, {name = b,x = a * 40 - 40,y = 1})
  end
  curr_tab = "all"
  editor_tabs.characters = {
    {"baaba", "text_baaba", "keeke", "text_keeke", "the m", "text_the m", "fofofo", "text_fofofo", "jijiji", "text_jijiji", "ite", "text_ite", "baadbad", "text_baadbad"},
    {"wug","text_wug","pa","text_pa","robot","text_robot","bird","text_bird","crab","text_crab","lim","text_lim","turtle","text_turtle"},
    {"jsdhgous","text_jsdhgous","bee","text_bee","horse","text_horse","sqrt9","text_sqrt9","ghost","text_ghost","guy","text_guy","eye","text_eye"},
    {"skull","text_skull","bat","text_bat","bug","text_bug","statue","text_statue","monster","text_monster","jelly","text_jelly","fish","text_fish"},
    {"cucucu","text_cucucu","abba","text_abba"},
    {},
    {"all","text_all","group","text_group"}
  }

  editor_tabs.letters = {
    {"text_a","text_b","text_c","text_d","text_e","text_f","text_g","text_h","text_i","text_j","text_k","text_l","text_m"},
    {"text_n","text_o","text_p","text_no","text_r","text_s","text_t","text_u","text_v","text_w","text_x","text_y","text_z"},
    {},
    {"text_0","text_1","text_2","text_3","text_4","text_5","text_6","text_7","text_8","text_9","text_ch","text_upsilon","text_dollars"}
  }

  editor_tabs.abstract = {
      {"circle","text_circle","triangle","text_triangle","square","text_square","pentagon","text_pentagon","hex","text_hex","arrow","text_arrow"},
      {"pa","text_pa","block","text_block","target","text_target","goal","text_goal","pixel","text_pixel","line","text_line"},
      {"arc","text_arc","dot","text_dot","love","text_love","blossom","text_blossom","correct","text_correct","incorrect","text_incorrect"},
      {"cursor","text_cursor","question","text_question","mathdotsinxword","text_mathdotsinxword","icon","text_icon"},
      {"file","text_file","choose","text_choose","stack", "text_stack"},

  }

  editor_tabs.items = {
    {"stone","flag","key","clock","box","cake","block","belt","pillar","star","cog","fruit","button","rocket"},
    {"text_stone","text_flag","text_key","text_clock","text_box","text_cake","text_block","text_belt","text_pillar","text_star","text_cog","text_fruit","text_button","text_rocket"},
    {"moon","pants","shirt","card","jar","lever","bell","orb","gem","bucket","bananas","monitor","battery","staple"},
    {"text_moon","text_pants","text_shirt","text_card","text_jar","text_lever","text_bell","text_orb","text_gem","text_bucket","text_bananas","text_monitor","text_battery","text_staple"},
    {"axe","sword","pick","log","3dollars","ring","lemon","chair","prize","car","hand","bolt","pumpkin","seastar"},
    {"text_axe","text_sword","text_pick","text_log","text_3dollars","text_ring","text_lemon","text_chair","text_prize","text_car","text_hand","text_bolt","text_pumpkin","text_seastar"},
    {"satelite","wheel"},
    {"text_satelite","text_wheel"},
  }

  editor_tabs.obstacles = {
    {"wall","text_wall","door","text_door","hedge","text_hedge","pipe","text_pipe","cliff","text_cliff","fence","text_fence","cloud","text_cloud"},
    {"whater","text_whater","lavaaa","text_lavaaa","bog","text_bog","sj7ll","text_sj7ll","fiiiiire","text_fiiiiire","lock","text_lock","fan","text_fan"},
    {"ice","text_ice"},
    {"skull","text_skull","bug","text_bug","jelly","text_jelly"}
  }

  editor_tabs.decor = {
    {"tile","grass","grubble","rubble","brick","fungus","bubble","flower","algae","sun","foliage","husk","leaf","reed"},
    {"text_tile","text_grass","text_grubble","text_rubble","text_brick","text_fungus","text_bubble","text_flower","text_algae","text_sun","text_foliage","text_husk","text_leaf","text_reed"},

    {"tree","rose","dust","stump","gburble","planet","mountain","star","moon","stone","calendar"},
    {"text_tree","text_rose","text_dust","text_stump","text_gburble","text_planet","text_mountain","text_star","text_moon","text_stone","text_calendar"}
  }

  editor_tabs.rules = {
    {"text_is","text_have","text_make","text_write","text_eat","text_fear","text_n'","text_the"},
    {},
    {"text_you","text_win","text_stop","text_push","text_sink","text_defeat","text_hot","text_melt","text_move","text_open","text_shut","text_float","text_weak","text_tele"},
    {"text_up","text_down","text_left","text_right","text_fall","text_hide","text_shift","text_sleep","text_pull"},
    {"text_red","text_orange","text_yellow","text_gellow","text_green","text_blue","text_purple","text_pink"},
    {"text_you2","text_select","text_auto","text_power","text_powered"},
    {"text_meta","text_unmeta","text_what","text_small","text_big","text_place","text_placed","text_active","text_burn","text_hop","text_collect","text_old","text_reset","text_set"},
    {"text_heavy","text_oneway","text_link","text_path","text_only","text_random","text_poof"},
    {},
    {"text_text","text_all","text_group"}
  }

  editor_tabs.advanced = {
    {"clipboard","text_clipboard","icon","text_icon","this","text_this","file","text_file"},
    {"text_no","text_often","text_seldom","text_lonely","text_powered","text_power","text_yes"},
    {"text_on","text_near","text_feeling","text_without","text_above","text_below","text_but","text_starts","text_contains","text_ends","text_facing"},
    {"text","text_text","group","text_group","level","text_level","text_place","text_placed","text_active"},
    {"text_textof","choose","text_choose", "stack", "text_stack"}
  }

  editor_tabs.new = {
    {"text_meta","text_this","text_icon","clock","text_clock",
    "text_clipboard","text_what",
    "grubble","text_grubble", "scribble", "text_scribble","hex","text_hex"},{"pentagon","text_pentagon","text_small","block","text_block","pa","text_pa","text_active","text_place","text_placed","text_goal","text_target","goal","target"},{"button","text_button","text_gellow", "text_burn"
     , "text_only", "sj7ll", "text_sj7ll", "text_unmeta", "text_hop",
    "blossom", "text_blossom", "calendar", "text_calendar", "card"}, {"text_card", "jar", "text_jar", "satelite", "text_satelite", "text_collect", "text_arc","arc","text_guy","guy",
    "text_gburble","gburble","text_old", "text_no"},{"wug","text_wug","bell","text_bell",
    "fan","text_fan","lim","text_lim",
    "all", "text", "group",
     "clipboard", "icon", "this"},{"text_uncopy","text_textof","text_but","mountain","text_mountain","correct","text_correct","horse","text_horse","battery","text_battery","staple","text_staple", "text_upsilon"},
    {"incorrect", "text_incorrect","text_heavy","text_oneway","text_link","text_reset","text_set","text_big","text_random", "axe","text_axe","pick","text_pick","log"},{"text_log","text_starts","text_contains","text_ends",
    "text_path","sqrt9","text_sqrt9", "text_file","mathdotsinxword","text_mathdotsinxword","text_dollars",
    "3dollars","text_3dollars","text_ch"},{"lemon","text_lemon","prize","text_prize","text_poof","jsdhgous","text_jsdhgous",
    "cucucu","text_cucucu","wheel","text_wheel","file","choose","text_choose"},
    {"abba","text_abba","text_none","text_yes","text_the", "stack", "text_stack"}
  }

  editor_tabs.basic = {
    {"baaba", "text_baaba", "wall", "text_wall", "flag", "text_flag", "stone", "text_stone"},
    {"whater", "text_whater", "lavaaa", "text_lavaaa", "key","text_key","door","text_door"},
    {"box", "text_box", "grass", "text_grass", "belt", "text_belt", "skull", "text_skull"},
    {"keeke", "text_keeke", "flower", "text_flower", "clock", "text_clock", "calendar", "text_calendar"},
    {"brick", "text_brick", "pillar", "text_pillar", "tile", "text_tile", "tree", "text_tree"},
    {"text_you", "text_win", "text_stop", "text_push", "text_sink", "text_hot", "text_melt", "text_defeat"},
    {"text_pull", "text_shift", "text_float", "text_move", "text_red", "text_weak"},
    {"text_is", "text_have", "text_n'", "text_on", "text_text"}
  }

  editor_tabs.all = images
end


function update_editor_tiling()
  for i, j in ipairs(editor_curr_objects) do


      j.tiling = nil
        if getspritevalues(j.name).rotate == 5 then


          local tileval = 0
          local l = {{1, 0}, {0, -1}, {-1, 0}, {0, 1}}
          local mult = 1

          for k, m in ipairs(l) do
            local tile_here = false
            for n, o in ipairs(alltilehere_editor(j.tilex + m[1], j.tiley + m[2])) do
              if o.name == j.name or o.name == "level" then
                tileval = tileval + mult
                tile_here = true
                break
              end
            end
            if not tile_here and (j.tilex + m[1] < 1 or j.tiley + m[2] < 1 or j.tilex + m[1] > 1 * (levelx - 2) or j.tiley + m[2] > 1 * (levely - 1)) then
              tileval = tileval + mult
            end
            mult = mult * 2
          end

          j.tiling = tileval
          j.sprite = love.graphics.newImage("sprite/" .. j.name .. " T" .. j.tiling .. ".png")

        end

  end
end

function editor_swap()

    local heldobj = heldtile .. ""
    if string.sub(heldobj, 1, 5) == "text_" then
      heldobj = string.sub(heldobj, 6)
    end
    --DBG = heldobj
    if not getspritevalues(heldobj).nope then
      if heldobj ~= heldtile then
        heldtile = heldobj
      else
        heldtile = "text_" .. heldtile
      end
    end

end

function editor_eyedrop()
  for i5,c5 in ipairs(editor_curr_objects) do
   if(dist(c5.x+tilesize/2,c5.y+tilesize/2,love.mouse.getX(),love.mouse.getY()) < tilesize/1.5) then
   --c5.active = false


       heldtile = c5.name
       break

   end
  end
end

function editor_eyedropping()
  eyedrop = "eye"
  heldtile = ""
end

function editor_leveldropping()
  eyedrop = "level"
  heldtile = ""
end

function editor_leveldrop()

        local delthese = remove_popups()
        for i, j in ipairs(delthese) do
          table.remove(menu_buttons, j)
        end

        local level_toadd = nil
        for i, j in ipairs(editor_curr_objects) do

          if j.tilex == math.floor(love.mouse.getX()/tilesize) and j.tiley == math.floor(love.mouse.getY()/tilesize) then
            level_toadd = i
          end
        end
        if level_toadd ~= nil then
          selected_obj = level_toadd
          local already = editor_curr_objects[selected_obj].levelinside or ""
          addpopup(love.mouse.getX(), love.mouse.getY(), {
            {
              dx = 5,
              dy = 10,
              sizex = 25,
              sizey = 25,
              color = {0.1, 0.1, 0.2, 1, 1, 1},
              text = "<",
              func = function(b)
                local old = editor_curr_objects[selected_obj].num or 0
                editor_curr_objects[selected_obj].num = math.max(0, old - 1)
              end
            },
            {
              dx = 35,
              dy = 10,
              sizex = 25,
              sizey = 25,
              color = {0.1, 0.1, 0.2, 1, 1, 1},
              text = "locked",
              func = function(b)
                if editor_curr_objects[selected_obj].lock == nil then
                  editor_curr_objects[selected_obj].lock = "YES"
                else
                  editor_curr_objects[selected_obj].lock = nil
                end
              end,
              drawfunc = function(b)
                b.color = {0.1, 0.1, 0.2, 1, 1, 1}
                if editor_curr_objects[selected_obj].lock then
                  b.color = {0.5, 0.5, 0.63, 1, 1, 1}
                end
              end
            },
            {
              dx = 70,
              dy = 10,
              sizex = 25,
              sizey = 25,
              color = {0.1, 0.1, 0.2, 1, 1, 1},
              text = ">",
              func = function(b)
                local old = editor_curr_objects[selected_obj].num or 0
                editor_curr_objects[selected_obj].num = math.min(old + 1, 31)
              end
            },
            {
              dx = 10,
              dy = 60,
              sizex = 80,
              sizey = 30,
              color = {0.1, 0.1, 0.2, 1, 1, 1},
              text = already,
              func = function(b)
                b.edit = not b.edit
              end,
              drawfunc = function(b)
                b.color = {0.1, 0.1, 0.2, 1, 1, 1}
                if b.edit then
                  b.color = {0.05, 0.05, 0.13, 1, 1, 1}
                end
              end
            }
          }, 100, 100)
        end
end

function notimplemented()

end

menu_state = "main"
font = love.graphics.newFont(12, "normal", love.graphics.getDPIScale())
mutemusic = false
play_hover_sound = nil
can_play_hover = true
function menu()
    local hovers = false
    -- drawing the menu itself we have the 4 buttons play (0% done) settings (dont even have an idea) quit (who the heck uses this) and editor (was already in the game)
    local width, height = love.graphics.getDimensions()
    for i, j in ipairs(menu_buttons) do

        if j.state == menu_state and (j.tab == nil or j.tab == currtab) then

          local jx, jy = j.x * (width / 1280), j.y * (height / 820)
          local jsizex, jsizey = j.sizex * (width / 1280), j.sizey * (height / 820)

          if j.drawfunc ~= nil then
            j.drawfunc(j)
          end
          love.graphics.setColor(j.color[1], j.color[2], j.color[3], j.color[7])

          if editlevelname and j.text == "Rename" then
            love.graphics.setColor((j.color[1]) / 2, (j.color[2]) / 2, (j.color[3]) / 2)
          end



          if j.justtext ~= true then
            if love.mouse.getX() > jx and love.mouse.getX() < jx + jsizex and  love.mouse.getY() > jy and love.mouse.getY() < jy + jsizey then

              play_hover_sound = true
              hovers = true
              if not love.mouse.isDown() then
                love.graphics.setColor((j.color[1] + 1) / 2, (j.color[2] + 1) / 2, (j.color[3] + 1) / 2, j.color[7])
              else
                love.graphics.setColor((j.color[1]) / 2, (j.color[2]) / 2, (j.color[3]) / 2, j.color[7])
              end
            end
          end




          love.graphics.rectangle("fill", jx, jy, jsizex, jsizey)
          love.graphics.rectangle("line", jx, jy, jsizex, jsizey)
          love.graphics.setColor(j.color[4], j.color[5], j.color[6] , j.color[8])
          local _, linecount = font:getWrap(j.text, jsizex)
          love.graphics.printf(j.text, jx, jy + jsizey / 4 - (#linecount - 1) * 6, jsizex, "center")


        end
    end
    if not hovers then
      can_play_hover = true
    end
    if play_hover_sound and can_play_hover then
      playsfx("hover3", true)
      can_play_hover = false
      play_hover_sound = false
    end
end

menu_states = {
  main = {

    load = function()

      map_level = {}
      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Editor",
        x = 540,
        y = 400,
        sizex = 180,
        sizey = 30,
        func = gotoeditor,
        state = "main"
      })


      table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Quit",
          x = 540,
          y = 500,
          sizex = 180,
          sizey = 30,
          func = love.event.quit,
          state = "main"
      })

      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Play",
        x = 540,
        y = 350,
        sizex = 180,
        sizey = 30,
        func = gotoplay,
        state = "main"
      })

      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Settings",
        x = 540,
        y = 450,
        sizex = 180,
        sizey = 30,
        func = gotosettings,
        state = "main"
      })
    end
  },
  settings = {
    load = function()


      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Back",
        x = 540,
        y = 650,
        sizex = 180,
        sizey = 30,
        func = backtomenu,
        state = "settings"
      })


      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Back",
        x = 540,
        y = 650,
        sizex = 180,
        sizey = 30,
        func = function()
          menu_load("pause")
        end,
        state = "pause_settings"
      })


      table.insert(menu_buttons, {
        color = {0.3, 0.3, 0.4, 0, 0, 0},
        text = "Mute Music",
        x = 540,
        y = 230,
        sizex = 180,
        sizey = 30,
        state = "settings",
        func = nomoremusic,
        drawfunc = function(j)
          j.color = {0.3, 0.3, 0.4, 0, 0, 0}
          if mutemusic then
            j.color = {0.95, 0.3, 0.85, 0, 0, 0}
          end
        end
      })

      table.insert(menu_buttons, {
        color = {0.3, 0.3, 0.4, 0, 0, 0},
        text = "Mute Sound Effects",
        x = 540,
        y = 270,
        sizex = 180,
        sizey = 30,
        state = "settings",
        func = nomoresfx,
        drawfunc = function(j)
          j.color = {0.3, 0.3, 0.4, 0, 0, 0}
          if mutesfx then
            j.color = {0.95, 0.3, 0.85, 0, 0, 0}
          end
        end
      })

      table.insert(menu_buttons, {
        color = {0.3, 0.3, 0.4, 0, 0, 0},
        text = "Useless Setting",
        x = 540,
        y = 310,
        sizex = 180,
        sizey = 30,
        state = "settings",
        func = notimplemented
      })

    end

  },
  editor = {
    load = function()

        table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Back",
          x = 1200,
          y = 5,
          sizex = 60,
          sizey = 30,
          func = gotomenu,
          state = "editor"
        })

        table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Objects",
          x = 560,
          y = 725,
          sizex = 180,
          sizey = 30,
          func = function()
            hideui = not hideui
          end,
          state = "editor"
        })
        table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Swap",
          x = 870,
          y = 725,
          sizex = 80,
          sizey = 30,
          func = editor_swap,
          state = "editor"
        })

        table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Select",
          x = 960,
          y = 725,
          sizex = 80,
          sizey = 30,
          func = editor_eyedropping,
          state = "editor"
        })

        table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Edit",
          x = 1050,
          y = 725,
          sizex = 80,
          sizey = 30,
          func = editor_leveldropping,
          state = "editor"
        })


          table.insert(menu_buttons, {
            color = {0.2, 0.3, 0.7, 0, 0, 0},
            text = "Save",
            x = 290,
            y = 725,
            sizex = 60,
            sizey = 30,
            func = dolevelsave,
            state = "editor"
          })

          table.insert(menu_buttons, {
            color = {0.2, 0.3, 0.7, 0, 0, 0},
            text = "Load",
            x = 360,
            y = 725,
            sizex = 60,
            sizey = 30,
            func = dolevelload,
            state = "editor"
          })


            table.insert(menu_buttons, {
              color = {0.2, 0.3, 0.7, 0, 0, 0},
              text = "Rename",
              x = 80,
              y = 725,
              sizex = 60,
              sizey = 30,
              func = dolevelname,
              state = "editor"
            })

            table.insert(menu_buttons, {
              color = {0.2, 0.2, 0.3, 1, 1, 1},
              text = "",
              x = 150,
              y = 720,
              sizex = 125,
              sizey = 40,
              state = "editor",
              justtext = true,
              id = "textinput",
              drawfunc = function(b)
                b.text = current_textinput
              end
            })

            --TODO: tooltips. don't really feel like implementing another timer system today
    end
  },
  play = {
    load = function()
      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Back",
        x = 1200,
        y = 5,
        sizex = 60,
        sizey = 30,
        func = gotomenuplay,
        state = "play"
      })

      local filest = {}
      local file_table = love.filesystem.getDirectoryItems("levels")
      for i,v in ipairs(file_table) do
        local file = "levels/"..v
        local info = love.filesystem.getInfo(file)
        if info then
          if info.type == "file" then
            table.insert(menu_buttons, {
              color = {0.2, 0.3, 0.7, 0, 0, 0},
              text = v,
              x = 350 + 230 * (((i - 1) % levels_per_tab) % 3),
              y = 70 + 35 * math.floor((((i - 1) % levels_per_tab) ) / 3),
              sizex = 160,
              sizey = 30,
              func = "auto_playlevel",
              state = "play",
              tab = math.floor((i - 1) / levels_per_tab) + 1,
              drawfunc = function(b)
                if b.color[1] == 0.2 and levelcompleted(b.text) then
                  b.color = {0.1, 0.2, 0.4, 1, 1, 1}
                end
              end
            })
          end
        end
      end
      tab_amount = math.ceil(#file_table / levels_per_tab)
      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Previous",
        x = 350,
        y = 720,
        sizex = 160,
        sizey = 30,
        func = prevtab,
        state = "play"
      })
      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Next",
        x = 810,
        y = 720,
        sizex = 160,
        sizey = 30,
        func = nexttab,
        state = "play"
      })
      table.insert(menu_buttons, {
        color = {0, 0, 0, 1, 1, 1},
        text = "",
        x = 580,
        y = 720,
        sizex = 160,
        sizey = 30,
        justtext = true,
        state = "play",
        drawfunc = function(b)
          b.text = "Tab " .. currtab .. "/" .. tab_amount
        end
      })
    end
  },
  playing = {
    load = function()

        table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Pause",
          x = 1200,
          y = 5,
          sizex = 60,
          sizey = 30,
          func = pause,
          state = "playing"
        })
    end
  },
  pause = {
    load = function()
      add_backdrop()

      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 1, 1, 1, 0},
        text = levelname,
        x = 540,
        y = 5,
        sizex = 180,
        sizey = 30,
        justtext = true,
        state = "pause"
      })

      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Resume",
        x = 540,
        y = 50,
        sizex = 180,
        sizey = 30,
        func = unpause,
        state = "pause"
      })

      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Settings",
        x = 540,
        y = 95,
        sizex = 180,
        sizey = 30,
        func = pausesettings,
        state = "pause"
      })

      table.insert(menu_buttons, {
        color = {0.2, 0.3, 0.7, 0, 0, 0},
        text = "Back To Menu",
        x = 540,
        y = 140,
        sizex = 180,
        sizey = 30,
        func = gotomenuplay,
        state = "pause"
      })
      if #leveltree > 1 then
        table.insert(menu_buttons, {
          color = {0.2, 0.3, 0.7, 0, 0, 0},
          text = "Back To Map",
          x = 540,
          y = 185,
          sizex = 180,
          sizey = 30,
          func = gotomap,
          state = "pause"
        })
      end

    end
  },
  pause_settings = {
    load = function()
      --atom what happened with the indentation here?????????
            add_backdrop()

            table.insert(menu_buttons, {
              color = {0.2, 0.3, 0.7, 0, 0, 0},
              text = "Back",
              x = 540,
              y = 650,
              sizex = 180,
              sizey = 30,
              func = function()
                menu_load("pause")
              end,
              state = "pause_settings"
            })


            table.insert(menu_buttons, {
              color = {0.3, 0.3, 0.4, 0, 0, 0},
              text = "Mute Music",
              x = 540,
              y = 230,
              sizex = 180,
              sizey = 30,
              state = "pause_settings",
              func = nomoremusic,
              drawfunc = function(j)
                j.color = {0.3, 0.3, 0.4, 0, 0, 0}
                if mutemusic then
                  j.color = {0.95, 0.3, 0.85, 0, 0, 0}
                end
              end
            })

            table.insert(menu_buttons, {
              color = {0.3, 0.3, 0.4, 0, 0, 0},
              text = "Mute Sound Effects",
              x = 540,
              y = 270,
              sizex = 180,
              sizey = 30,
              state = "pause_settings",
              func = nomoresfx,
              drawfunc = function(j)
                j.color = {0.3, 0.3, 0.4, 0, 0, 0}
                if mutesfx then
                  j.color = {0.95, 0.3, 0.85, 0, 0, 0}
                end
              end
            })

            table.insert(menu_buttons, {
              color = {0.3, 0.3, 0.4, 0, 0, 0},
              text = "Useless Setting",
              x = 540,
              y = 310,
              sizex = 180,
              sizey = 30,
              state = "pause_settings",
              func = notimplemented
            })
          end

  }

}

depause_state = "playing"
game_paused = false
function pause()
  depause_state = menu_state
  menu_load("pause")
  game_paused = true
end
function unpause()
  menu_load(depause_state)
  game_paused = false
end

function add_backdrop()
  --not jank way of making a backdrop
  table.insert(menu_buttons, {
    color = {0.0, 0.0, 0.0, 0, 0, 0, 0.5},
    text = "",
    x = 0,
    y = 0,
    sizex = 1280,
    sizey = 820,
    justtext = true,
    state = menu_state
  })
end

function pausesettings()
  menu_load("pause_settings")
end
function menu_load(state)
  --got rid of this garbage
  menu_buttons = {}
  menu_state = state
  menu_states[menu_state].load()
  --
end


function addpopup(x, y, things, _sx, _sy)

  table.insert(menu_buttons, {
    color = {0.2, 0.2, 0.3, 1, 1, 1},
    text = "",
    x = x,
    y = y,
    sizex = _sx or 200,
    sizey = _sy or 200,
    state = gamestate,
    id = "popup",
    justtext = true,
    popup = "base"
  })

  for _, stuff in ipairs(things) do
    table.insert(menu_buttons, {
      color = stuff.color or {0.2, 0.2, 0.3, 1, 1, 1},
      text = stuff.text or "",
      x = x + (stuff.dx or 0),
      y = y + (stuff.dy or 0),
      sizex = stuff.sizex or 200,
      sizey = stuff.sizey or 200,
      state = gamestate,
      id = "popup",
      func = stuff.func,
      drawfunc = stuff.drawfunc,
      popup = "top"
    })
  end


end





function gotoeditor()
  x_offset = 0
  y_offset = 0

  playmusic("default")
  gamestate = "editor"
  menu_load("editor")

  palette_id = 1
  loadPalette(all_palettes[palette_id])

  initui()
end

function gotogame()
  gamestate = "playing"
  menu_load("playing")
end

function gotomenu()
  leveltree = {}
  playmusic("baaba")
  gamestate = "menu"
  menu_load("main")
  heldtile = ""
  editor_curr_objects = {}
end

function gotomenuplay()
  leveltree = {}

  levelname = ""

  dielevel()
  love.timer.sleep(0.1)


  playmusic("baaba")
  gamestate = "menu"
  menu_load("main")
  editor_curr_objects = {}


end

function gotomap()
  enterlevel(leveltree[#leveltree - 1])
  table.remove(leveltree, #leveltree)
  game_paused = false
end
levels_per_tab = 51
function gotoplay()
  menu_load("play")

end

currtab = 1
tab_amount = 1
function nexttab()
  currtab = math.min(currtab + 1, tab_amount)
end

function prevtab()
  currtab = math.max(currtab - 1, 1)
end

function backtomenu()
  gamestate = "menu"
  menu_load("main")
        leveltree = {}
end

function nomoremusic()
  mutemusic = not mutemusic
  if mutemusic then
    music:setVolume(0)
  else
    music:setVolume(0.3)
  end
end
mutesfx = false
function nomoresfx()
  mutesfx = not mutesfx
end

function gotosettings()
  menu_load("settings")
end

function dolevelsave()
  saveleveldata(levelname)
end
function dolevelload()
  loadleveldata(levelname, true)
end

function dolevelname()
  editlevelname = not editlevelname
  if not editlevelname then
    levelname = current_textinput
  end
end
windowsize = 1
windowtilesize = 1
function windowsmaller()
  if windowsize == 1 then
    windowsize = 0.75
    windowtilesize = 0.75
    for i, j in ipairs(menu_buttons) do
      j.x = j.x * 0.75
      j.y = j.y * 0.75
      j.sizex = j.sizex * 0.75
      j.sizey = j.sizey * 0.75
    end
    tilesize = 36
  end
end
function windowbigger()
  if windowsize < 1 then
    windowsize = 1
    windowtilesize = 1
    for i, j in ipairs(menu_buttons) do
      j.x = j.x * (4 / 3.0)
      j.y = j.y * (4 / 3.0)
      j.sizex = j.sizex * (4 / 3.0)
      j.sizey = j.sizey * (4 / 3.0)
    end
    tilesize = 48
  end
end

-- NOTE: What am i even doing anymore
function delete_these_specific_menu_buttons()

  local removes = {}
  for a, b in ipairs(menu_buttons) do
    if b.func == "auto_playlevel" then
      table.insert(removes, a)
    end
  end
  local h = 0
  for a, b in ipairs(removes) do
    table.remove(menu_buttons, b - h)
    h = h + 1
  end

end

function loadlevel_advanced(j)
  dolevelload()
  loadlevel()
end

function playlevel_advanced(j)

  gotogame()
  love.timer.sleep(1)
  levelname = j.text
  full_level_load()
  gotogame()
  playmusic(musiclist[levelmusic])
  delete_these_specific_menu_buttons()

end

function remove_popups(delthese_)
  selected_obj = nil

  local delthese = delthese_ or {}

  for i, j in ipairs(menu_buttons) do
    if j.popup == "top" or j.popup == "base" then
      table.insert(delthese, 1, i)
    end
  end
  return delthese
end

function menu_press()

  if eyedrop == "level" then
    eyedrop = nil
    playsfx("select")
    editor_leveldrop()
    return
  elseif eyedrop == "eye" then
    eyedrop = nil
    playsfx("select")
    editor_eyedrop()
    return
  end

  local width, height = love.graphics.getDimensions()

  local delthese = {}
  for i, j in ipairs(menu_buttons) do

      if j.popup == "base" then
        local jx, jy = j.x * (width / 1280), j.y * (height / 820)
        local jsizex, jsizey = j.sizex * (width / 1280), j.sizey * (height / 820)
        if not (love.mouse.getX() > jx and love.mouse.getX() < jx + jsizex and  love.mouse.getY() > jy and love.mouse.getY() < jy + jsizey) then
          delthese = remove_popups(delthese)
        end

      end

      if j.justtext ~= true and j.state == menu_state  and (j.tab == nil or j.tab == currtab) then
        local jx, jy = j.x * (width / 1280), j.y * (height / 820)
        local jsizex, jsizey = j.sizex * (width / 1280), j.sizey * (height / 820)
        if love.mouse.getX() > jx and love.mouse.getX() < jx + jsizex and  love.mouse.getY() > jy and love.mouse.getY() < jy + jsizey then
          playsfx("click", true)
          if j.func ~= "auto_playlevel" then
            j.func(j)
            break
          else
            currtab = 1
            tab_amount = 1
            table.insert(leveltree, j.text)
            gotogame()
            --love.timer.sleep(1)
            levelname = j.text
            dolevelload()
            --love.timer.sleep(1)

            --what were these random sleeps for anyway? why would waiting one second ever help anything????
            loadlevel()
            gotogame()
            playmusic(musiclist[levelmusic])
            delete_these_specific_menu_buttons()

            x_offset = (love.graphics.getWidth() - levelx * tilesize) / 2
            y_offset = (love.graphics.getHeight() - (levely + 1) * tilesize) / 2
            break

          end
        end
      end
  end

  for i, j in ipairs(delthese) do
    table.remove(menu_buttons, j)
  end
end

curmusic = ""
function playmusic(name)
  if curmusic == name then
    return
  end
  curmusic = name
  music:stop()
  if musictable[name] == nil then
    musictable[name] = love.audio.newSource("sound/" .. name .. ".wav","static")
  end
  music = musictable[name]
  music:play()
  music:setLooping(true)
  if mutemusic then
    music:setVolume(0)
  else
    music:setVolume(1)
    if name ~= "default" then
      music:setVolume(0.3)
    end
  end
end

soundtable = {}
function playsfx(sound, vary)
  if mutesfx then
    return
  end
  if (not soundtable[sound]) or soundtable[sound]:isPlaying() then
    soundtable[sound] = love.audio.newSource("sound/" .. sound .. ".wav","static")
  end
  if vary then
    local pitches = {0.85, 0.92, 1, 1, 1.08, 1.15}
    soundtable[sound]:setPitch(pitches[love.math.random(1, 6)])
  end
  love.audio.play(soundtable[sound])
end

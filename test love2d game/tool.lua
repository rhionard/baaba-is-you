function newturn()
  for i,playerkey in ipairs(keys) do
   if love.keyboard.isDown(playerkey) then
    return true
   end
  end
end
function realname(name)
if(string.sub(name,1,5) == "text_")then
return string.sub(name,6,string.len(name))
end
return name
end
function istext_or_word(name,noword_)
  -- What

  if name == nil then
    return false
  end
  local noword = noword_ or false
  if(noword == false)then
   return string.sub(name,1,5) == "text_" or letterreplacements[name] ~= nil
  else
   return string.sub(name,1,5) == "text_"
  end
end


function unitingroup(group, id)
  if ingroup[id] == nil then
    return false
  end
  for i, j in pairs(ingroup[id]) do
    if j == group then return true end
  end
  return false
end

function revdir(d)
  if d == "right" then return "left" end
  if d == "left" then return "right" end
  if d == "up" then return "down" end
  if d == "down" then return "up" end
end

function matches(word, unit, justname_)
  local justname = justname_ or false
  local name = ""
  local id = 0 --Rest in peace id = -15. You will be missed.
  if not justname then
    if unit ~= "icon" then
      name = unit.name
      id = unit.id
    else
      name = "icon"
      id = 0
    end
  else
    name = unit
  end

  if word == name then
    return true
  end

  if unit == "any" then
    return true
  end

  if word == "text" and istext_or_word(name, 1) then
    return true
  end

  if word == "clipboard" and love.system.getClipboardText() == name then
    return true
  end

  if word == "group"  and unitingroup("group", id) then
    return true
  end

  if word == "icon" and name == currenticon then
    return true
  end

  if word == "this" and name == "text_this" then
    return true
  end

  if word == "all" and not istext_or_word(name, 1) and not justname and name ~= "particle" then
    return true
  end

  if word == "file" and id ~= 0 and unit.file ~= nil then
    return true
  end

  if word == "choose" and chooserule ~= nil and chooserule ~= "" and chooserule[2] == name then
    return true
  end

  if word == "particle" and id < 0 then
    return true
  end

  return false


end


--if this isnt clear, take a unit and a noun and gets all names that match that pair
function unitreference(unit, ref)

  if ref == "text" then
    if string.sub(unit.name, 1, 5) == "text_" then
      return {"text_text"}
    else
      return {"text_" .. unit.name}
    end
  end

  if ref == "this" then
    return {"text_this"}
  end

  if ref == "clipboard" then
    local clipboard = love.system.getClipboardText()
    local found  = false
    for i,val in ipairs(objectValues)do
      if(clipboard == val.name) then
        found = true
      end
    end
    if found then
      return {clipboard}
    else
      return {"clipboard"}
    end
  end

  if ref == "group" then
    local groups = {}
    for i, v in pairs(ingroup) do
      local hasgroup = false
      for a, b in ipairs(v) do
        if b == "group" then
          hasgroup = true
          break
        end
      end
      if hasgroup then
        local unit = Objects[i]
        table.insert(groups, unit.name)
      end
    end
    return groups
  end

  if ref == "icon" then
    return {currenticon}
  end

  if ref == "all" then
    local alls = {}
    for i, j in ipairs(Objects) do
      if not istext_or_word(j.name, true) then
        table.insert(alls, j.name)
      end
    end
    return alls
  end

  if ref == "choose" then
    if chooserule ~= "" and chooserule ~= nil then
      local o = chooserule[2] .. ""
      if string.sub(o, 1, 5) == "text_" then
        o = string.sub(o, 6)
      end
      --DBG = heldobj
      if not getspritevalues(o).nope then
        return {chooserule[2]}
      end
      return {}
    end

    return {"choose"}
  end

  return {ref}
end

function float(ob1,ob2)
  local floorheight1 = 0
  local floorheight2 = 0
  local ceilingheight1 = Objects[ob1].size
  local ceilingheight2 = Objects[ob2].size
  if ruleexists(ob1, Objects[ob1].name ,"is","float") then
    floorheight1 = Objects[ob1].size
    ceilingheight1 = ceilingheight1 + Objects[ob1].size
  end
  if ruleexists(ob2, Objects[ob2].name ,"is","float") then
    floorheight2 = Objects[ob2].size
    ceilingheight2 = ceilingheight2 + Objects[ob2].size
  end
  return floorheight1 < ceilingheight2 and ceilingheight1 > floorheight2
end

function dochoose()
  turnkey = "choose"
  local choosers = {}
  local vischoosers = {}

  for abc, def in ipairs(rules) do
    if def[1] == "choose" and def[2] == "is" then
      table.insert(choosers, {def[2], def[3], def[4]})
      table.insert(vischoosers, def[3])
    end
  end

  if #choosers > 0 then
    if chooserule ~= nil then
      oldchooserule = {}
      for i, j in ipairs(chooserule) do
        table.insert(oldchooserule,j)
      end
    end
    table.insert(vischoosers, "nah")
    vischoosers.escapebutton = #vischoosers

    local pressedbutton = love.window.showMessageBox("Choose.", "Choose.", vischoosers)
    chooserule = choosers[pressedbutton]

  end

end

function is_particle(id)
  return id < 0
end

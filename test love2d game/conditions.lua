condf = {}
condf["lonely"] = function(id)
    if id == "icon" then
      return (turnkey ~= "Absolutely Not")
    end
    local obj = Objects[id]
    if #on(obj) == 0 then
      return true
    end
    return false
end

condf["often"] = function(id)
    if math.ceil(math.random(0,4)) ~= 1 then
      return true
    else
      return false
    end
end

condf["seldom"] = function(id)
    if math.ceil(math.random(0,6)) == 1 then
      return true
    else
      return false
    end
end

condf["powered"] = function(id, _, p)
    if p then
      return false
    end
    return (#objectswithproperty("power", true) > 0) or (ruleexists("icon",nil,"is","power",nil,true))
end

condf["active"] = function(id, _, p)
    return active
end

condf["no"] = function(id, _, p)
    return false
end

condf["yes"] = function(id, _, p)
    return true
end

condf["never"] = function(id, _, p)
    return false
end


condf["on"] = function(id, args, p)
  if id == "icon" then
    return false
  end
  if is_particle(id) then
    return false
  end
    local obj = Objects[id]
    local done = 0

    local onthis = on(obj)
    for i, j in ipairs(args) do
      for n, m in ipairs(onthis) do
        if m.id ~= id then
          if matches(j, m) then
            done = done + 1
            break
          end
          if j == "none" then
            return false
          end
        end
      end
      if j == "none" then
        done = done + 1
      end
    end
    return done == #args
end

condf["above"] = function(id, args, p)
  if id == "icon" then
    return false
  end
  local obj = Objects[id]
  local done = 0

  local belowthis = {}

  for i, j in ipairs(Objects) do
    if id ~= j.id and j.tilex == obj.tilex and j.tiley > obj.tiley then
      table.insert(belowthis, j)
    end
  end

  for i, j in ipairs(args) do
    for n, m in ipairs(belowthis) do
      if m.id ~= id then
        if matches(j, m) then
          done = done + 1
          break
        end
        if j == "none" then
          return false
        end
      end
    end
    if j == "none" then
      done = done + 1
    end
  end
  return done == #args
end

condf["below"] = function(id, args, p)
  if id == "icon" then
    local belowthis = {}
    for i, j in ipairs(Objects) do
      table.insert(belowthis, j)
    end
    local done = 0
    for i, j in ipairs(args) do
      for n, m in ipairs(belowthis) do
        if matches(j, m) then
          done = done + 1
          break
        end
      end
    end
    return done == #args
  end
  local obj = Objects[id]
  local done = 0

  local belowthis = {}

  for i, j in ipairs(Objects) do
    if id ~= j.id and j.tilex == obj.tilex and j.tiley < obj.tiley then
      table.insert(belowthis, j)
    end
  end

  for i, j in ipairs(args) do
    for n, m in ipairs(belowthis) do
      if m.id ~= id then
        if matches(j, m) then
          done = done + 1
          break
        end
        if j == "none" then
          return false
        end
      end
    end
    if j == "none" then
      done = done + 1
    end
  end
  return done == #args
end

condf["near"] = function(id, args, p)
  if id == "icon" then
    return false
  end
  local obj = Objects[id]

  local done = 0

  local results = {}

  for i, j in ipairs(Objects) do
    if id ~= j.id then

      local xdiff = math.abs(j.tilex - obj.tilex)
      local ydiff = math.abs(j.tiley - obj.tiley)
      if xdiff <= 1 and ydiff <= 1 then
        table.insert(results, j)
      end
    end
  end

  for i, j in ipairs(args) do
    for n, m in ipairs(results) do
      if m.id ~= id then
        if matches(j, m) then
          done = done + 1
          break
        end
        if j == "none" then
          return false
        end
      end
    end
    if j == "none" then
      done = done + 1
    end
  end
  return done == #args
end

condf["nextto"] = function(id, args, p)
  if id == "icon" then
    return false
  end
  local obj = Objects[id]

  local done = 0

  local results = {}

  for i, j in ipairs(Objects) do
    if id ~= j.id then

      local xdiff = math.abs(j.tilex - obj.tilex)
      local ydiff = math.abs(j.tiley - obj.tiley)
      if (xdiff + ydiff == 1) then
        table.insert(results, j)
      end
    end
  end

  for i, j in ipairs(args) do
    for n, m in ipairs(results) do
      if m.id ~= id then
        if matches(j, m) then
          done = done + 1
          break
        end
        if j == "none" then
          return false
        end
      end
    end
    if j == "none" then
      done = done + 1
    end
  end
  return done == #args
end

condf["facing"] = function(id, args, p)
  if id == "icon" then
    return false
  end
  local obj = Objects[id]

  local done = 0

  local results = {}

  for i, j in ipairs(Objects) do
    if id ~= j.id then

      local xdiff = j.tilex - obj.tilex
      local ydiff = j.tiley - obj.tiley
      local dir_val = dir_to_xy(obj.dir)
      if xdiff == dir_val[1] and ydiff == dir_val[2] then
        table.insert(results, j)
      end
    end
  end

  for i, j in ipairs(args) do
    for n, m in ipairs(results) do
      if m.id ~= id then
        if matches(j, m) then
          done = done + 1
          break
        end
        if j == "none" then
          return false
        end
      end
    end
    if j == "none" then
      done = done + 1
    end
  end
  return done == #args
end

condf["without"] = function(id, args, p)
  local done = 0

  local results = {}
  for i, j in ipairs(Objects) do
    if id ~= j.id then
      table.insert(results, j)
    end
  end

  for i, j in ipairs(args) do
    for n, m in ipairs(results) do
      if matches(j, m) then
        return false
      end
    end
  end
  return true
end

condf["feeling"] = function(id, args, p, q)

  if q then return false end
  if id == "icon" then
    for i, j in ipairs(args) do
      loop_detector = loop_detector + 1
      if loop_detector > 1000 then
        the_level_is_gone = true
        return false
      end
      if not ruleexists("icon",nil,"is",j, true) then
        return false
      end
    end
    return true
  end
  local obj = Objects[id]

  local done = 0

  for i, j in ipairs(args) do
    loop_detector = loop_detector + 1
    if loop_detector > 1000 then
      the_level_is_gone = true
      return false
    end
    if not ruleexists(id,nil,"is",j, true) then
      return false
    end
  end
  return true
end

condf["but"] = function(id, args, p)
  if id == "icon" then
    local done = 0
    for i, j in ipairs(args) do
      if not matches(j, "icon") then
        done = done + 1
        break
      end
    end
    return done == #args
  end
  local obj = Objects[id]

  local done = 0

  for i, j in ipairs(args) do
    if not matches(j, obj) then
      done = done + 1
      break
    end
  end
  return done == #args
end

condf["if"] = function(id, args)
  local valid = 0
  for i, jj in ipairs(args) do
    local stringrule = {}
    for k, l in ipairs(jj) do
      local jname = realname(Objects[l].name)
      table.insert(stringrule, jname)
    end
    for k, l in ipairs(Objects) do
      if matches(stringrule[1], l) and ruleexists(l.id, nil, stringrule[2], stringrule[3]) then
        valid = valid + 1
        break
      end
    end
  end
  return valid == #args
end

condf["starts"] = function(id, args, p)
  local name = ""
  if id ~= "icon" then
    name = realname(Objects[id].name)
  else
    name = currenticon
  end
  for i, j in ipairs(args) do
    if string.sub(name, 0, string.len(j)) ~= j then
      return false
    end
  end
  return true
end

condf["ends"] = function(id, args, p)
  local name = ""
  if id ~= "icon" then
    name = realname(Objects[id].name)
  else
    name = currenticon
  end
  for i, j in ipairs(args) do
    if string.sub(name, -string.len(j)) ~= j then
      return false
    end
  end
  return true
end

condf["contains"] = function(id, args, p)
  local name = ""
  local unname = ""
  if id ~= "icon" then
    name = realname(Objects[id].name)
    unname = Objects[id].name
  else
    name = realname(currenticon)
    unname = currenticon
  end
  if name == "what" then
    name = "?"
  end
  if unname == "calendar" then
    local m = true
    for i, j in ipairs(args) do
      if not string.match(name, j) then
        m = false
        break
      end
    end
    if m then
      return true
    end

    name = tostring(os.date("*t",os.time()).day)

  end
  for i, j in ipairs(args) do
    if not string.match(name, j) then
      return false
    end
  end
  return true
end

condf["the"] = function(id, args, p)
  if id == "icon" then
    return true -- there is only one window icon. you can't add more.
  end


  local ob = Objects[id]

  for i, j in ipairs(Objects) do
    if id ~= j.id and j.name == ob.name then
      return false
    end
  end

  return true
end


function testcond(conds_, unitid, preventpowerloop, preventfeelingloop)
  local conds = conds_ or {}

  local condtype = ""
  local result = true
  for i, j in ipairs(conds) do
    condtype = j[1]
    if condf[condtype] ~= nil then
      result = result and condf[condtype](unitid, j[2], preventpowerloop, preventfeelingloop)
    end
  end
  return result
end

love.filesystem.load("conditions.lua")()

function gettiles(directiontype,xpos,ypos,tileamount)
  local finalobjects = {}
 for e,f in ipairs(Objects) do
   local oxpos = f.tilex
   local oypos = f.tiley
   if(oxpos-xpos == tileamount) and (oypos == ypos) and (directiontype == "right") then
    table.insert(finalobjects,f)
   end
   if(oxpos-xpos == -tileamount) and (oypos == ypos) and (directiontype == "left") then
    table.insert(finalobjects,f)
   end
   if(oypos-ypos == tileamount) and (oxpos == xpos) and (directiontype == "down") then
    table.insert(finalobjects,f)
   end
   if(oypos-ypos == -tileamount) and (oxpos == xpos) and (directiontype == "up") then
    table.insert(finalobjects,f)
   end
 end
 return finalobjects
end
function objectswithproperty(property, p)
 local objs1 = {}
 for i,ob in ipairs(rules) do
    if matches(ob[3], property, true) and (ob[2] == "is")then
      for j,job in ipairs(Objects) do

       if matches(ob[1], job) then
          if not isruleblocked(job.id, "is", property) then
            if testcond(ob[4], job.id, p) then
             table.insert(objs1,job)
            end
          end
        end
      end
    end

 end

return objs1
end

function objectswithverb(verb, p)
 local objs1 = {}
 for i,ob in ipairs(rules) do
    if (ob[2] == verb)then
      for j,job in ipairs(Objects) do

       if matches(ob[1], job) then
          if not isruleblocked(job.id, verb, ob[3]) then
            if testcond(ob[4], job.id, p) then
             table.insert(objs1, {
               noun = job.name,
               target = ob[3],
               unit = job
             })
            end
          end
        end
      end
    end

 end

return objs1
end

function getplayers(select_)
  local deselect = select_ or false
 local objs1 = {}
 for i,ob in ipairs(rules) do
   local property = ob[3]
    if matches(property, "you", true) or matches(property, "you2", true) or (matches(property, "select", true) and not deselect) and (ob[2] == "is")then
      for j,job in ipairs(Objects) do

       if matches(ob[1], job) then
          if not isruleblocked(job.id, "is", property) then
            if testcond(ob[4], job.id, p) then
             table.insert(objs1,job)
            end
          end
        end
      end
    end

 end

return objs1
end


function on(thisobj)
  local finalobjs2 = {}
  local xpos1 = thisobj.tilex
  local ypos1 = thisobj.tiley
  for a,b in ipairs(Objects) do
    if(xpos1 == b.tilex) and (ypos1 == b.tiley) then
      if not (b==thisobj) and (b.name ~= "particle") then
        table.insert(finalobjs2,b)
      end
    end
  end
  return finalobjs2
end
function ison(thisobj,otherobj)
  local finalobjs2 = {}
  local xpos1 = thisobj.tilex
  local ypos1 = thisobj.tiley
  local xpos2 = otherobj.tilex
  local ypos2 = otherobj.tiley
  return (xpos1 == xpos2) and (ypos1 == ypos2)
end

function isruleblocked(id,verb,prop)

  local unit = {}
  if id == "icon" then
    unit = id
  elseif type(id) == "number" then
    if id > 0 then
      unit = Objects[id]
    else
      unit = particles[-id]
    end
  end
  local norule = false
  for i,ob in ipairs(rules) do
    if ob[4] ~= nil then
      local hasno = false
      local non_no_conds = {}
      local hasyes = false
      for j,k in ipairs(ob[4]) do
        if k[1] == "no" then
          hasno = true
        elseif k[1] ~= "never" and k[1] ~= "yes" then
          table.insert(non_no_conds, k)
        elseif k[1] == "yes" then
          hasyes = true
        end
      end

      if hasno then
        if matches(ob[3], prop, true) and (ob[2] == verb) and (matches(ob[1], unit)) then
          if testcond(non_no_conds, id) then
            norule = true
          end
        end
      end
      if hasyes then
        if matches(ob[3], prop, true) and (ob[2] == verb) and (matches(ob[1], unit)) then
          if testcond(non_no_conds, id) then

            return false
          end
        end
      end

    end
  end
  return norule

end
function ruleexists(id, noun,verb,property, feeling,power)

  if isruleblocked(id, verb, property) then
    return false
  end

  local unit = {}
  if id ~= "icon" and type(id) == "number" then
    if id > 0 then
      unit = Objects[id]
    else
      unit = particles[-id]
    end
  else
    unit = "icon"
  end

  for i,ob in ipairs(rules) do

     if matches(ob[3], property, true) and (ob[2] == verb)then

        if matches(ob[1], unit) then
           if testcond(ob[4], id, power, feeling) then
            return true
           end

       end
     end

  end

 return false
end

function rulecount(id, verb,property)

  if isruleblocked(id, verb, property) then
    return false
  end
  local unit = {}
  if id ~= "icon" then
    if id > 0 then
      unit = Objects[id]
    else
      unit = particles[-id]
    end
  else
    unit = "icon"
  end


  count = 0
  for i,ob in ipairs(rules) do

     if matches(ob[3], property, true) and (ob[2] == verb)then

        if matches(ob[1], unit) then

           if testcond(ob[4], id) then
            count = count + 1
           end

       end
     end

  end

 return count
end

function hasrule(name1,verb1,prop1)
  local finals = {}
  for useless,getrule in ipairs(rules) do
     if matches(getrule[1], name1, true)then
      if(getrule[2] == verb1)then
       if matches(getrule[3], prop1, true)then
          return true
       end
      end
     end
  end
  return false
end
function getletters(x,y,dir,flip_)
 local k = true
 local i = 0
 local finalletters = {}
 local try = ""
 local flip = flip_ or false
 while k == true do

  i = i + 1
  local tile = gettiles(dir,x,y,i)
  if(#tile < 1)then
   k = false
  else
   if(getspritevalues(tile[1].name).type == 5)then

     table.insert(finalletters,tile[1])
   else
   k = false
   end
  end
 end
 if flip then
--  finalletters = ReverseTable(finalletters)
 end
 for i,letter in ipairs(finalletters)do
   try = try .. realname(letter.name)
   to = try
   for j,obj in ipairs(objectValues)do
    if((obj.name == try) and not flip)then
      return try
    end
    to = string.reverse(try)
    if((obj.name == string.reverse(try)) and flip)then
      return string.reverse(try)
    end
   end
 end
return ""


end

function letters_to_text(letters, start)

  local str = ""
  local letterobjs = {}

  for i, v in ipairs(letters) do
    if i > start then

      local obj = Objects[v]
      local gsv = getspritevalues(obj.name)
      local name = realname(obj.name)
      if letterreplacements[obj.name] ~= nil then
        name = letterreplacements[obj.name]
      end

      if gsv.type == 5 then
        str = str .. name
        table.insert(letterobjs, v)
      else
        break
      end

    end

  end
  if alias[str] ~= nil then
    str = alias[str]
  end
  return getspritevalues("text_" .. str), letterobjs

end

Parser = {}

function Parser:init()
  self.words = {}
  self.wordsToParse = {}
  self.parsed_rules = {}

  local dels = {}
  for i, unit in ipairs(Objects) do
    if istext_or_word(unit.name,true) then
      unit._active = false
      if not undoing then
        local p = on(unit)
        local thedel = false
        for j, unit2 in ipairs(p) do
          if istext_or_word(unit2.name,true) then
            thedel = true
            table.insert(dels, unit2)
          end
        end
        if thedel then
          table.insert(dels, unit)
          makeobject(unit.tilex, unit.tiley, "stack", "right")
        end
      end
    end
  end
  handledels(dels, false)
end

function Parser:makeFirstWords()

  i = 1
  while i < levelx do
    j = 1
    while j < levely do
      local here = allhere(i,j)
      for _, ob in ipairs(here) do
        local name = ob.name
        local type = ob.type

        -- Actual first word checks

        -- Right now, fancy stuff like conditions exist, so uh oh no



        if type == 3 or type == 5 then
          table.insert(self.words, {ob.id, "right"})
          table.insert(self.words, {ob.id, "down"})
        end

        if type == 0 or type == 9 then

          local lft = gettiles("left",ob.tilex,ob.tiley,1)
          local ups = gettiles("up",ob.tilex,ob.tiley,1)

          local lft2 = gettiles("left",ob.tilex,ob.tiley,2)
          local ups2 = gettiles("up",ob.tilex,ob.tiley,2)

          local lft3 = gettiles("left",ob.tilex,ob.tiley,3)
          local ups3 = gettiles("up",ob.tilex,ob.tiley,3)

          local rt = gettiles("right",ob.tilex,ob.tiley,1)

          local blft, bup = false,false

          local hasand = false
          local istext_and = false
          for i, j in ipairs(lft) do
            if j.type == 3 or (j.type == 9 and type ~= 9) then
              blft = true
            elseif j.type == 4 or (j.type == 7 and j.name ~= "text_feeling") then
              hasand = true
            end
          end
          for i, j in ipairs(lft3) do
            if hasand and j.type == 9 then
              istext_and = true
              break
            end
          end
          for i, j in ipairs(lft2) do
            if hasand and (j.type == 0 or ((istext_and) and istext_or_word(j.name))) then
              blft = true
            end
          end
          hasand = false
          istext_and = false
          for i, j in ipairs(ups) do
            if j.type == 3 or (j.type == 9 and type ~= 9) then
              bup = true
            elseif j.type == 4 or (j.type == 7 and j.name ~= "text_feeling") then
              hasand = true
            end
          end
          for i, j in ipairs(lft3) do
            if hasand and j.type == 9 then
              istext_and = true
              break
            end
          end
          for i, j in ipairs(ups2) do
            if hasand and (j.type == 0 or ((istext_and) and istext_or_word(j.name))) then
              bup = true
            end
          end

          if not blft then
            table.insert(self.words, {ob.id, "right"})
          end
          if not bup then
            table.insert(self.words, {ob.id, "down"})
          end
        end



      end
      j = j + 1
    end
    i = i + 1
  end

end

function Parser:MakeRules()
  for i, jj in ipairs(self.words) do
    local j = jj[1]
    local thissentence = {}
    table.insert(thissentence, j)
    local checktile = {":"}
    local ind = 1


      while #checktile ~= 0 do
        checktile = gettiles(jj[2],Objects[j].tilex,Objects[j].tiley,ind)
        local found = false
        for k,l in ipairs(checktile) do
          if istext_or_word(l.name) then
            table.insert(thissentence, l.id)
            found = true
            break
          end
        end
        if not found then
          break
        end
        ind = ind + 1
      end

      if #thissentence > 2 then
        table.insert(self.wordsToParse, thissentence)
      end
    end

end

function Parser:ParseRules()

  for i, j in ipairs(self.wordsToParse) do
    local stage = -1
    local stop = false

    local rule_targets = {}

    local rule_subjects = {}

    local rule_conds = {}

    local id_targets = {}
    local id_subjects = {}
    local id_conds = {}

    local fixTHIS = false
    local ids = {}

    local pass = false
    local letterpass = 0
    local thisletterword = ""
    local thisletterids = {}
    local textof = false
    local doublepass = false
    local letterarg = false

    local isif = false
    local if_rule = {}
    local if_ids = {}

    for ind, thing in ipairs(j) do

      local obj = Objects[thing]
      local name = realname(obj.name)
      local type = obj.type


      local next = Objects[j[ind + 1]]

      if letterreplacements[obj.name] ~= nil then
        name = letterreplacements[obj.name]
      end

      -- handle letters
      if type == 5 and not (letterpass > 0) and not textof and not letterarg then

        thisletterword = thisletterword .. name
        table.insert(thisletterids, thing)
        letterpass = 1
        local found = false

        local finalword = thisletterword .. ""
        if alias[finalword] ~= nil then
          finalword = alias[finalword]
        end
        local gsv = getspritevalues("text_" .. finalword)

        if not gsv.nope and gsv.type ~= 5 then
          found = true
          name = finalword
          type = gsv.type
          letterpass = 0
          for ____, letterid in ipairs(thisletterids) do
            table.insert(ids, letterid)
          end
          thisletterids = {}
          thisletterword = ""
        end

        if not found and next ~= nil and next.type ~= 5 then
          stop = true
        end

      end
      letterarg = false
--[[      if next ~= nil and next.type ~= 5 and thisletterword ~= "" then
        local found = false
        for i, o in ipairs(images) do
          for n, m in ipairs(o) do
            if m == "text_" .. thisletterword and string.len(thisletterword) > 1 then
              for k, l in ipairs(thisletterids) do
                table.insert(ids, l)
              end
              local p = getspritevalues(m)
              type = p.type
              name = realname(m)
              found = true
              pass = false
              break
            end
          end
        end
        if not found then
          stop = true
        end
        thisletterword = ""
      end]]

      if doublepass then
        doublepass = false
      elseif pass then
        pass = false
        table.insert(ids, thing)
      -- Lonely
    elseif letterpass > 0 then
      letterpass = letterpass - 1
    elseif(stage == -1) then
        if type == 0 then
          table.insert(ids, thing)
          table.insert(rule_targets, name)
          stage = 1
        elseif type == 3 then
          table.insert(rule_conds, {name, {}})
          table.insert(ids, thing)
          stage = 0
        elseif type == 9 then
          textof = true
          stage = 0
          table.insert(ids, thing)
        else
          stop = true
        end
      -- X
      elseif (stage == 0) then
        if not textof then
          if type == 0 then
            table.insert(ids, thing)
            table.insert(rule_targets, name)
            stage = 1
          elseif type == 9 then
            textof = true
            stage = 0
            table.insert(ids, thing)
          else
            stop = true
          end
        else
          table.insert(ids, thing)
          table.insert(rule_targets, "text_" .. name)
          stage = 1
          textof = false
        end
      -- IS X / X AND Y IS Z / x ON Y IS Z
      elseif (stage == 1) then
        if type == 1 then

          if next == nil then

            stop = true

          else

            local accepted_args = getspritevalues("text_" .. name).args or {0}
            local success = false
            local asletter = false
            local lettername = ""
            local istextof = false
            for i, z in ipairs(accepted_args) do

              if (next.type == z) then
                success = true
                break
              elseif (next.type == 5) then
                local lettergsv, letterids = letters_to_text(j, ind)
                if lettergsv.type == z then
                  success = true
                  asletter = letterids
                  lettername = realname(lettergsv.name)
                  break
                end
              elseif (next.type == 9) then
                local next2 = Objects[j[ind + 2]]
                if next2 ~= nil then
                  success = true
                  istextof = "text_" .. realname(next2.name)
                end
              end
            end

            if success then
              table.insert(ids, thing)
              if asletter == false and istextof == false then
                table.insert(ids, next.id)
                table.insert(rule_subjects, {name, realname(next.name)})
              elseif istextof == false then
                for a, b in ipairs(asletter) do
                  table.insert(ids, b)
                end
                letterpass = #asletter - 1
                table.insert(rule_subjects, {name, lettername})
              else
                table.insert(ids, j[ind + 1])
                table.insert(ids, j[ind + 2])
                table.insert(rule_subjects, {name, istextof})
                doublepass = true
              end

              pass = true
              if fixTHIS ~= false then
                table.insert(ids, fixTHIS)
                fixTHIS = false
              end
              stage = 2

            else

              stop = true

            end

          end


        elseif type == 4 then
          table.insert(ids, thing)
          stage = 0
        elseif type == 7 and next ~= nil then

          local accepted_args = getspritevalues("text_" .. name).args or {0}
          local success = false
          local asletter = false
          local lettername = ""
          local istextof = false

          for i, z in ipairs(accepted_args) do

            if ((next.type == z) or (z == 0 and next.type == -5)) and not (z == 5) then
              success = true
              break
            elseif (next.type == 5) then
              local lettergsv, letterids = letters_to_text(j, ind)
              if lettergsv.type == z then
                success = true
                asletter = letterids
                if(z == 5) then
                  letterarg = true
                end
                lettername = realname(lettergsv.name)
                break
              end
            elseif (next.type == 9) then
              local next2 = Objects[j[ind + 2]]
              if next2 ~= nil then
                success = true
                istextof = "text_" .. realname(next2.name)
              end
            end

          end

          if success then
            table.insert(ids, thing)
            if asletter == false and istextof == false then
              table.insert(ids, next.id)
              table.insert(rule_conds, {name, {realname(next.name)}})
            elseif istextof == false then
              for a, b in ipairs(asletter) do
                table.insert(ids, b)
              end
              letterpass = (#asletter - 1)
              table.insert(rule_conds, {name, {lettername}})
            else
              table.insert(ids, j[ind + 1])
              table.insert(ids, j[ind + 2])
              table.insert(rule_conds, {name, {istextof}})
              doublepass = true
            end

            pass = true

          else

            stop = true

          end
        else
          stop = true
        end
      -- IS Y AND HAVE Z / IS Y AND Z
      elseif (stage == 2) then

        if next ~= nil then

          if type == 4 then



              if next.type == 1 then

                fixTHIS = thing
                stage = 1

              else

                local last_rule_subject = rule_subjects[#rule_subjects][1]
                local accepted_args = getspritevalues("text_" .. last_rule_subject).args or {0}
                local success = false
                local asletter = false
                local lettername = ""
                local istextof = false
                for i, z in ipairs(accepted_args) do

                  if (next.type == z) then
                    success = true
                    break
                  elseif (next.type == 5) then
                    local lettergsv, letterids = letters_to_text(j, ind)
                    if lettergsv.type == z then
                      success = true
                      asletter = letterids
                      lettername = realname(lettergsv.name)
                      break
                    end
                  elseif (next.type == 9) then
                    local next2 = Objects[j[ind + 2]]
                    if next2 ~= nil then
                      success = true
                      istextof = "text_" .. realname(next2.name)
                    end
                  end

                end

                if success then
                  table.insert(ids, thing)
                  if asletter == false and istextof == false then
                    table.insert(ids, next.id)
                    table.insert(rule_subjects, {last_rule_subject, realname(next.name)})
                  elseif istextof == false then
                    for a, b in ipairs(asletter) do
                      table.insert(ids, b)
                    end
                    letterpass = #asletter - 1
                    table.insert(rule_subjects, {last_rule_subject, lettername})
                  else
                    table.insert(ids, next.id)
                    table.insert(ids, j[ind + 2])
                    table.insert(rule_subjects, {last_rule_subject, istextof})
                  end

                  pass = true


                else

                  stop = true

                end

              end



          elseif type == 14 then
            if not isif then
              table.insert(ids, thing)
              isif = true
              if_rule = {{}, {}, {}}
              for aaa, bbb in ipairs(rule_subjects) do
                table.insert(if_rule[1], bbb)
              end
              for aaa, bbb in ipairs(rule_targets) do
                table.insert(if_rule[2], bbb)
              end
              for aaa, bbb in ipairs(rule_conds) do
                table.insert(if_rule[3], bbb)
              end
              stage = 0
            else
              stop = true
            end

          else
            stop = true
          end
        else
          stop = true
        end
      end

      if isif and not stop and name ~= "if" then
        table.insert(if_ids, thing)
      end

      if ind == #j then
        stop = true
      end

      if stop then

        if isif then
          if #(if_rule[1]) > 0 and #(if_rule[2]) > 0 and #rule_targets > 1 then
            rule_subjects = if_rule[1]
            rule_targets = if_rule[2]
            rule_conds = if_rule[3]
            table.insert(rule_conds, {"if", {if_ids}})
          end
        end
        debug = ""
        local made_sentence = false
        for m, n in ipairs(rule_targets) do
          for i, j in ipairs(rule_subjects) do
            debug = debug .. rule_targets[1] .. " " .. j[1] .. " " .. j[2] .. " "
              table.insert(self.parsed_rules, {n,j[1],j[2],rule_conds,ids})
              made_sentence = true
          end
        end
        if made_sentence then
          for k,l in ipairs(ids) do
            Objects[l]._active = true
          end
        end

        break


      end

    end
  end
end

function Parser:AddRules()
  local ifrules = {}
  for i, j in ipairs(self.parsed_rules) do
    if #j[4] > 0 and j[4][#j[4]][1] == "if" then
      table.insert(ifrules, j[4][#j[4]][2][1])
    end
  end

  local blockedrules = {}
  for i, j in ipairs(self.parsed_rules) do
    local notif = true
    if #ifrules > 0 and j[5] ~= nil then
      local hasif = false
      for a, b in ipairs(ifrules) do
        local isinif = 0
        for c, d in ipairs(b) do
          if j[5][c] == d then
            isinif = isinif + 1
          end
        end

        if isinif == #b then
          hasif = true
          break
        end
      end
      if hasif then
        notif = false
      end
    end
    if notif then
      table.insert(rules, j)
      if j[3] == "random" then
        if j[2] == "write" then
          table.remove(rules, #rules)
        end
        table.insert(rules, {j[1], j[2], random_prop(), j[4], j[5]})
      end
    end
    local valid = false
    for k, cond in ipairs(j[4]) do
      if cond[1] == "no" then
        valid = true
      else
        valid = false
        break
      end
    end
    if valid then
      table.insert(blockedrules, j)
    end
  end

  if #blockedrules > 0 then
    for i, j in ipairs(rules) do
      for k, l in ipairs(blockedrules) do

        local valid = true
        if j[4] ~= nil then
          for m, cond in ipairs(j[4]) do
            if cond[1] == "no" or cond[1] == "yes" then

              valid = false
              break
            end
          end
        end
        if valid then
          if j[1] == l[1] and j[2] == l[2] and j[3] == l[3] then
            if rules[i][4] ~= nil then
              table.insert(rules[i][4], {"never", {}})
            else
              rules[i][4] = {"never", {}}
            end
            if j[5] ~= nil then
              for c, d in ipairs(j[5]) do
                local textobj = Objects[d]
                textobj.blocked = true
              end
            end

            break
          end
        end
      end
    end
  end

end

function Parser:Debug()
  DBG = "Firstwords: " .. tostring(#self.words) .. "\n" .. "sentences to parse: " .. tostring(#self.wordsToParse) .. "\nParsed sentences: " .. tostring(#self.parsed_rules) .. "\nList of parsed sentences:"
  for i, j in ipairs(self.parsed_rules) do
    DBG = "\n" .. DBG .. j[1] .. " " .. j[2] .. " " .. j[3] .. " "
    for k, l in ipairs(j[4]) do
      DBG = DBG .. l[1] .. " "
      for m, n in ipairs(l[2]) do
        DBG = DBG .. n .. " & "
      end
    end
    DBG = DBG .. "\n"

  end

  DBG = DBG .. "Read:\n"
  for i, l in ipairs(self.wordsToParse) do
      for k, j in ipairs(l) do
          DBG = "\n" .. DBG .. realname(Objects[j].name) .. " "
      end
    DBG = DBG .. "\n"

  end

  DBG = DBG .. tostring(love.timer.getFPS())
end

function random_prop()
  return string_prop_list[math.ceil(math.random(0.01,#string_prop_list))]
end

function make_prop_list()
  for i, j in ipairs(objectValues) do
    if j.type == 2 and j.name ~= "text_random" and j.name ~= nil then
      table.insert(string_prop_list, string.sub(j.name,6))
    end
  end


end

function is_prop(name)
  for i, j in ipairs(string_prop_list) do
    if name == j then
      return true
    end
  end
  return false
end


--[[
TODO:
write a real parsing system [DONE]
add conditions [DONE]

add check to remove rules if they start with a firstword that is in the middle of another rule in the same direction [FLAG ON BAABA IS YOU -> BAABA is not allowed to start a rule to the right]
]]

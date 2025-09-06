love.filesystem.load("rules.lua")()
love.filesystem.load("main.lua")()
  allmoved = {}
  updates = {}


  function notmoved(unitid,dir)
    for i, j in ipairs(allmoved) do
      if j[1] == unitid and j[2] == dir then
        return false
      end
    end
    return true
  end


function down(key)
  return turnkey == key
end
domovesound = false
function testmove()
  domovesound = false
  updates = {}
  for i,unit in ipairs(Objects) do
    unit.moving = false
  end
  local yous = objectswithproperty("you")
  local you2s = objectswithproperty("you2")
  local p1 = (#you2s == 0)
 for youi,younit in ipairs(yous) do

  if((down("w") and p1) or down("up"))then table.insert(allmoved,{younit.id,"up"})
elseif((down("a") and p1)or down("left"))then table.insert(allmoved,{younit.id,"left"})
elseif((down("s") and p1)or down("down"))then table.insert(allmoved,{younit.id,"down"})
elseif((down("d") and p1)or down("right"))then table.insert(allmoved,{younit.id,"right"}) end
 end

 for youi,younit in ipairs(you2s) do

  if down("w") then table.insert(allmoved,{younit.id,"up"})
elseif down("a") then table.insert(allmoved,{younit.id,"left"})
elseif down("s") then table.insert(allmoved,{younit.id,"down"})
elseif down("d") then table.insert(allmoved,{younit.id,"right"}) end
 end
 moveunits()

  local movers = objectswithproperty("move")
  for i,mover in ipairs(movers) do
   table.insert(allmoved,{mover.id,mover.dir, "move"})
  end
  moveunits()
  local movers = objectswithproperty("auto")
  for i,mover in ipairs(movers) do
   table.insert(allmoved,{mover.id,mover.dir})
  end



moveunits()

 local isfear = objectswithverb("fear")
 for i,fear in ipairs(isfear) do
   local unit = fear.unit
   for a, b in ipairs({"up","right","left","down"}) do
     local ptl_fears = gettiles(b, unit.tilex, unit.tiley, 1)
     for _, ob in ipairs(ptl_fears) do
       if matches(fear.target, ob) then
         table.insert(allmoved,{unit.id,revdir(b)})
       end
     end
   end
 end
 moveunits()
 local isshift = objectswithproperty("shift")
 for i, shift in ipairs(isshift) do
   local onshift = on(shift)
   for a, here in ipairs(onshift) do
     table.insert(allmoved,{here.id, shift.dir})
   end
 end
 moveunits()
 if domovesound then
   playsfx("movem", true)
 end

end

mypushedunits = {}
function moveunits(_thereturnofevilrecursion)
   pushedunits = {}
   pulledunits = {}
   mypushedunits = {}
   local movequeue = {}

   local recurse = _thereturnofevilrecursion or 0

  for i,moved in ipairs(allmoved) do

    local dir = moved[2]
    local unitid = moved[1]
    local unit = Objects[unitid]
    mypushedunits = {}

    if unit ~= nil then

      if unit.moving then
        unit.moving = false
        table.insert(movequeue, {unitid, dir}) -- fix double moves so we can finally fix the stupid bug! after 3 years!
        break
      end

      local sleep = ruleexists(unit.id, unit.name,"is","sleep")
      local still = ruleexists(unit.id, unit.name,"is","still")
      if not sleep and not still then
        table.insert(updates, moved[1])

        local x,y = unit.tilex,unit.tiley
        local ox, oy = dir_to_xy(dir)[1], dir_to_xy(dir)[2]
        local weak = ruleexists(unit.id, unit.name,"is","weak")
        local hop = ruleexists(unit.id, unit.name,"is","hop")
        if(collision(unit,x+ox,y+oy,dir))then
          fullmove(unit, dir)
          for a, b in pairs(mypushedunits) do
            pushedunits[a] = b
          end
        elseif hop then
          fullmove(unit, dir)
          fullmove(unit, dir)
        elseif moved[3] == "move" then

          if(collision(unit,x-ox,y-oy,revdir(dir)))then
            fullmove(unit, revdir(dir))
            for a, b in pairs(mypushedunits) do
              pushedunits[a] = b
            end
          end
        elseif weak then
          handledels({unit})
        end
      end
    end
  end
  for pid, pdir  in pairs(pushedunits) do
    if notmoved(pid,pdir) then
      local punit = Objects[pid]
      add_undo("update", {id = punit.undo_id, old_x = punit.tilex, old_y = punit.tiley, dir = punit.dir})
      local old_x, old_y = punit.tilex * tilesize, punit.tiley * tilesize
      punit.tilex = punit.tilex + (dir_to_xy(pdir)[1])
      punit.tiley = punit.tiley+ (dir_to_xy(pdir)[2])
      table.insert(punit.anim_stack, {{old_x, old_y}, {punit.tilex * tilesize, punit.tiley * tilesize}})
      punit.dir = pdir
      particle("move", punit.x, punit.y, 1, {rotation = math.pi + dir_to_rotate(pdir), color = punit.color}, true)
    end
  end
  pushedunits = {}
  allmoved = {}

  if #movequeue > 0 then

    if recurse < 417 then

      allmoved = movequeue
      moveunits(recurse + 1)

    else

      the_level_is_gone = true
      return false

    end

  end

end
function update(unitid,x,y)
 local unit = Objects[unitid]
  add_undo("update", {id = unit.undo_id, old_x = unit.tilex, old_y = unit.tiley, dir = unit.dir})
  local old_x, old_y = unit.tilex * tilesize, unit.tiley * tilesize
 unit.tilex = x
 unit.tiley = y
 table.insert(unit.anim_stack, {{old_x, old_y}, {unit.tilex * tilesize, unit.tiley * tilesize}})
 unit.moving = true
end

function fullmove(unit, dir)

  add_undo("update", {id = unit.undo_id, old_x = unit.tilex, old_y = unit.tiley, dir = unit.dir})
  domovesound = true
  local old_x, old_y = unit.tilex * tilesize, unit.tiley * tilesize
  if(dir == "right")then
    unit.tilex = unit.tilex + 1
  elseif(dir == "left")then
    unit.tilex = unit.tilex - 1
  elseif(dir == "down")then
    unit.tiley = unit.tiley + 1
  elseif(dir == "up")then
    unit.tiley = unit.tiley - 1
  end
 table.insert(unit.anim_stack, {{old_x, old_y}, {unit.tilex * tilesize, unit.tiley * tilesize}})
  unit.dir = dir
  unit.moving = true
  particle("move", unit.x, unit.y, 1, {rotation = math.pi + dir_to_rotate(dir), color = unit.color}, true)

end

function moveunit(unitid,dir)
 local unit = Objects[unitid]
  unit.tilex = unit.tilex + (dir_to_xy(dir)[1])
  unit.tiley = unit.tiley + (dir_to_xy(dir)[2]) * tilesize
  unit.dir = dir
  unit.moving = true
  return true
end

function dir_to_xy(dir)
  if(dir == "right")then return {1,0}
elseif(dir == "left")then return {-1,0}
elseif(dir == "down")then return {0,1}
elseif(dir == "up")then return {0,-1}
else return {0,0} end
end

function smallcheck(ida,idb)
  if Objects[idb].small > Objects[ida].small and not (ruleexists(ida, nil, "is", "heavy") and not ruleexists(idb, nil, "is", "heavy"))  then
    return true -- small always returns true if target object is smaller or equal
  end
  return false
end

function heavycheck(ida, idb)
  if ruleexists(idb, nil, "is", "heavy") and not ruleexists(ida, nil, "is", "heavy") then
    return true
  end
  return false
end

function collision(unit,x,y,dir,pushing)
  if x < 1 or y < 1 or x > 1 * (levelx - 2) or y > 1 * (levely - 1) then
    return false
  end
  for k,v in ipairs(allhere(x,y)) do
    local fail = false
    if ruleexists(v.id, v.name,"is","push") then

        if not ruleexists(v.id, v.name,"is","still")  and not heavycheck(unit.id, v.id) and not smallcheck(unit.id,v.id)  then
           if collision(v,v.tilex+ (dir_to_xy(dir)[1]),v.tiley+ (dir_to_xy(dir)[2]), dir,true) then
             if pushing then
               mypushedunits[unit.id] = dir
               --[[
               unit.x = unit.x+ (dir_to_xy(dir)[1]) * tilesize
               unit.y = unit.y+ (dir_to_xy(dir)[2]) * tilesize
               unit.tilex = unit.tilex + (dir_to_xy(dir)[1])
               unit.tiley = unit.tiley+ (dir_to_xy(dir)[2])
               unit.dir = dir
             end]]
             end

           else
             fail = true
           end
         else
           fail = true
         end
       elseif ruleexists(v.id, v.name,"is","stop") or (ruleexists(v.id, v.name,"is","oneway") and v.dir ~= dir) or ((ruleexists(v.id, v.name,"is","push") or (ruleexists("text","is","stop") and string.sub(v.name,1,5) == "text_"))and smallcheck(unit.id,v.id) and heavycheck(unit.id,v.id)) then
          if notmoved(v.id, dir) or not collision(v,v.tilex+ (dir_to_xy(dir)[1]),v.tiley+ (dir_to_xy(dir)[2]), dir,false) then
             fail = true
          end
       elseif ruleexists(v.id, v.name, "is", "pull") then
         if pulledunits[v.id] == nil and (notmoved(v.id, dir) or not collision(v,v.tilex+ (dir_to_xy(dir)[1]),v.tiley+ (dir_to_xy(dir)[2]), dir,false)) then
           fail = true
         end
       end

       if fail then
         if (ruleexists(unit.id, unit.name,"eat",v.name)) then
           if notmoved(v.id, dir) or not collision(v,v.tilex+ (dir_to_xy(dir)[1]),v.tiley+ (dir_to_xy(dir)[2]), dir,false) then
             particle("hot", v.tilex * tilesize, v.tiley * tilesize, love.math.random(3, 5), nil, true)
             handledels({v})
           end
         elseif mypushedunits[unit.id] == dir and (ruleexists(v.id, v.name,"is","hop")) then
           return true
         elseif ((ruleexists(v.id, v.name,"is","open") and ruleexists(unit.id, unit.name,"is","shut"))
          or (ruleexists(v.id, v.name,"is","shut") and ruleexists(unit.id, unit.name,"is","open")))
         and not smallcheck(unit.id,v.id) then

           if notmoved(v.id, dir) or not collision(v,v.tilex+ (dir_to_xy(dir)[1]),v.tiley+ (dir_to_xy(dir)[2]), dir,false) then
             particle("open", v.x, v.y, 4, nil, true)
             handledels({v,unit}, "keys")
             return true
           end
         else
           return false
         end
       end
   end

   --
   local canpush = false
   for k, v in ipairs(allhere(x - 2 * dir_to_xy(dir)[1], y - 2 * dir_to_xy(dir)[2])) do
     if pulledunits[v.id] == nil then
       if ruleexists(v.id, v.name,"is","pull") then
          if not ruleexists(v.id, v.name,"is","still") and not smallcheck(unit.id,v.id) and not heavycheck(unit.id, v.id) then
            pulledunits[v.id] = dir
            if collision(v,x - (dir_to_xy(dir)[1]),y - (dir_to_xy(dir)[2]), dir, true) then
              if pushing then
                mypushedunits[unit.id] = dir
              end
            else
              canpush = false
            end
          else
            canpush = false
          end
       end
     end
   end


   if pushing and not canpush  then
     mypushedunits[unit.id] = dir
     --[[
     unit.x = unit.x+ (dir_to_xy(dir)[1]) * tilesize
     unit.y = unit.y+ (dir_to_xy(dir)[2]) * tilesize
     unit.tilex = unit.tilex + (dir_to_xy(dir)[1])
     unit.tiley = unit.tiley+ (dir_to_xy(dir)[2])
     unit.dir = dir]]
   end
   return true
end
function allhere(x,y)
    local finalobjs3 = {}
      for a,b in ipairs(Objects) do
    if(x == b.tilex) and (y == b.tiley) then
     table.insert(finalobjs3,b)
    end
  end
  return finalobjs3
end

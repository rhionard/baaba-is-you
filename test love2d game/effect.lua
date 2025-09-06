--we're in the homestretch!
particles = {}

psprites = {}
psprites["default"] = love.graphics.newImage("sprite/particle/default.png")
psprites["move"] = love.graphics.newImage("sprite/particle/move.png")
psprites["power"] = love.graphics.newImage("sprite/particle/power.png")
psprites["water1"] = love.graphics.newImage("sprite/particle/water1.png")
psprites["water2"] = love.graphics.newImage("sprite/particle/water2.png")
psprites["zzz"] = love.graphics.newImage("sprite/particle/zzz.png")
psprites["doot"] = love.graphics.newImage("sprite/particle/doot.png")

ptypes = {
  move = {
    speed = 100,
    sprite = "move",
    lifetime = 0.5,
    size = 2,
    shrink = 1.03,
    initfunc = function(p)
      p.offset = {tilesize / 2, tilesize / 2 + tilesize / 4}
    end
  },
  obj = {
    speed = 100,
    sprite = "move",
    lifetime = 1,
    size = 2,
    shrink = 1.015,
    initfunc = function(p)
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {0, 0}
    end
  },
  open = {
    speed = 200,
    sprite = "default",
    lifetime = 0.5,
    color = {3, 1},
    size = 2,
    shrink = 1.01,
    initfunc = function(p)
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {tilesize / 2, tilesize / 2}
    end
  },
  power = {
    speed = 100,
    rotatable = true,
    sprite = "power",
    lifetime = 1,
    color = {3, 1},
    size = 3,
    shrink = 1.01,
    initfunc = function(p)
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {tilesize / 2, tilesize / 2}
    end
  },
  destroy = {
    speed = 200,
    sprite = "default",
    lifetime = 0.7,
    color = {1, 2},
    size = 3,
    shrink = 1.02,
    initfunc = function(p)
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {tilesize / 2, tilesize / 2}
    end
  },
  win = {
    speed = 100,
    sprite = "default",
    lifetime = 0.7,
    color = {3, 1},
    size = 2,
    shrink = 1.01,
    initfunc = function(p)
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {tilesize / 2, tilesize / 2}
    end
  },
  water = {
    speed = 250,
    sprite = "water",
    lifetime = 0.3,
    color = {3, 1},
    size = 3,
    shrink = 1.01,
    initfunc = function(p)
      p.sprite = "water" .. tostring(love.math.random(1, 2))
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {tilesize / 2, tilesize / 2}
    end
  },
  active = {
    speed = 70,
    sprite = "move",
    lifetime = 0.7,
    color = {3, 1},
    size = 2,
    shrink = 1.015,
    initfunc = function(p)
      p.size = love.math.random(18, 22) / 10.0
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {tilesize / 2, tilesize / 2}
    end
  },
  burn = {
    speed = 100,
    sprite = "power",
    rotatable = true,
    lifetime = 1,
    color = {1, 4},
    size = 3,
    shrink = 1,
    initfunc = function(p)
      p.rotation = math.pi * 3 / 2
      p.speed = love.math.random(90,110)
      p.offset = {love.math.random(0, tilesize), love.math.random(0, tilesize)}
    end
  },
  hot = {
    speed = 30,
    lifetime = 1,
    color = {1, 4},
    shrink = 1.005,
    sprite = "move",
    initfunc = function(p)
      p.size = love.math.random(38, 42) / 10.0
      p.rotation = love.math.random(0, 628) / 100
      p.offset = {tilesize / 2, tilesize / 2}
    end
  },
  zzz = {
    speed = 30,
    lifetime = 1,
    color = {7, 5},
    shrink = 1.005,
    sprite = "zzz",
    initfunc = function(p)
      p.size = love.math.random(38, 42) / 10.0
      p.offset = {tilesize / 2, tilesize / 2}
      p.rotation = love.math.random(math.pi * 7 / 6, math.pi * 11 / 6)
    end
  },
  tele = {
    speed = 70,
    lifetime = 0.7,
    color = {6, 5},
    shrink = 1.009,
    sprite = "doot",
    initfunc = function(p)
      p.size = love.math.random(33, 67) / 10.0
      p.offset = {love.math.random(0, tilesize), love.math.random(0, tilesize)}
      p.rotation = love.math.random(0, 628) / 100
    end
  },
  what = {
    speed = 140,
    lifetime = 1.4,
    color = {6, 3},
    shrink = 1.004,
    sprite = "doot",
    initfunc = function(p)
      p.size = love.math.random(33, 67) / 10.0
      p.offset = {love.math.random(0, tilesize), love.math.random(0, tilesize)}
      p.rotation = love.math.random(0, 628) / 100
      p.x = love.math.random(x_offset, x_offset + tilesize * levelx), love.math.random(x_offset, x_offset + tilesize * levely)
      p.y = love.math.random(x_offset, x_offset + tilesize * levelx), love.math.random(y_offset, y_offset + tilesize * levely)
    end
  }

}
function dir_to_rotate(d)
  if d == "right" then return 0 end
  if d == "down" then return math.pi / 2 end
  if d == "left" then return math.pi end
  if d == "up" then return math.pi * 1.5 end
  return -23497834738
end

function rotate_to_dir(d_)
  local d = d_ % (2 * math.pi)
  if d >= 0 and d < math.pi / 2 then
    return "right"
  elseif d < math.pi then
    return "down"
  elseif d < 1.5 * math.pi then
    return "left"
  end
  return "up"
end

function particle(t, x, y, count, override_, makeunit_)
  local override = override_ or {}
  local totaldir = 0
  local particlemade = false
  local partsize = 1
  for __ = 1, count do
    local part = {}
    part.type = t
    part.x, part.y = x, y
    part.speed = 4
    part.sprite = "default"
    part.lifespan = 1
    part.rotation = 0
    part.size = 1
    part.lifetime = 0
    part.offset = {0,0}
    part.color = {1,1}
    part.shrink = 1.05
    part.rotatable = false
    part.vely = 0
    part.name = "particle"
    part.id = 1 + #particles
    for i, j in pairs(ptypes[t]) do
      part[i] = j
    end
    if part.initfunc ~= nil then
      part.initfunc(part)
    end
    for i, j in pairs(override) do
      part[i] = j
    end
    table.insert(particles, part)
    --make a test object for conditions, then remove it instantly
    local newpart = makeobject(math.floor(x / tilesize + 0.1),math.floor(y / tilesize + 0.1), "particle", rotate_to_dir(totaldir), nil, nil, true)
    local exists, partsize = particleblock(part, newpart.id)
    table.remove(Objects, #Objects)
    particlemade = particlemade or exists
    totaldir = part.rotation
  end
  if makeunit_ and particlemade then
    local newob = makeobject(math.floor(x / tilesize + 0.1),math.floor(y / tilesize + 0.1),"particle",rotate_to_dir(totaldir))
    Objects[#Objects].small = partsize
  end
end

function particleblock(p, id)
  local small, big = 0, 0
  if ruleexists(id, nil, "is", "any") then
    for i,color in ipairs(colorblocks)do
      if ruleexists(id, nil, "is", color.name) then
        p.color = color.color
      end
    end
    if ruleexists(id, nil, "is", "fall") then
      p.vely = 1
      p.rotation = math.pi * 0.5
    end
    if ruleexists(id, nil, "is", "up") then
      p.rotation = math.pi * 1.5
    end
    if ruleexists(id, nil, "is", "down") then
      p.rotation = math.pi * 0.5
    end
    if ruleexists(id, nil, "is", "right") then
      p.rotation = 0
    end
    if ruleexists(id, nil, "is", "left") then
      p.rotation = math.pi
    end
    if ruleexists(id, nil, "is", "hide") then
      p.size = 0
      p.lifetime = 0
    end
    if ruleexists(id, nil, "is", "poof") then
      p.size = 0
      p.lifetime = 0
      return false
    end
    if ruleexists(id, nil, "is", "still") then
      p.speed = 0
      p.vely = 0
      return false
    end
    small = rulecount(id, "is", "small")
    big = rulecount(id, "is", "big")
    p.size = p.size * math.pow(2, big) * math.pow(0.5, small)
  end
  return true, (math.pow(2, big) * math.pow(0.5, small))

end
function particles:draw()

  for i, p in ipairs(particles) do

    local t = palettecolors[p.color[1]]
    if(t ~= nil) and (t[p.color[2]] ~= nil)then
      love.graphics.setColor(t[p.color[2]])
    end
    local r = 0
    if p.rotatable then
      r = p.rotation
    end
    local spr = psprites[p.sprite]
    if p.usesprite ~= nil then
      spr = p.usesprite
    end
    if type(spr) == "string" then
      spr = love.graphics.newImage("sprite/" .. spr .. ".png")
    end
    love.graphics.draw(spr, p.x + x_offset + p.offset[1], p.y + y_offset + p.offset[2], r, p.size, p.size)

  end


end
pwords = {}
function addparticleword(word, ptype, count, delay, chance, add_)
  for i, j in ipairs(objectswithproperty(word)) do
    table.insert(pwords, {j, ptype, count, delay, chance, love.math.random(0, delay - 1)})
    if add_ then
      makeobject(j.tilex,j.tiley,"particle",j.dir)
    end
  end
end
function effects(add_)
  if add_ then
    local delthese = {}
     for i,unit in ipairs(Objects) do
       if unit.name == "particle" then
         table.insert(delthese, unit)
       end
     end
     handledels(delthese, false)
   end

  pwords = {}
  addparticleword("win", "win", 1, 100, 2, add_)
  addparticleword("open", "win", 1, 300, 2, add_)
  addparticleword("power", "power", 1, 100, 2, add_)
  addparticleword("burn", "burn", 1, 250, 3, add_)
  addparticleword("hot", "hot", 1, 350, 3, add_)
  addparticleword("sleep", "zzz", 1, 350, 3, add_)
end
function particles:update(delta)

  local delthese = {}
  for i, p in ipairs(particles) do
    p.x = p.x + math.cos(p.rotation) * delta * p.speed
    p.y = p.y + math.sin(p.rotation) * delta * p.speed + p.vely
    p.size = p.size / p.shrink
    p.lifetime = p.lifetime - delta
    if p.lifetime <= 0 then
      table.insert(delthese, i)
    end

  end

  local off = 0
  for i, j in ipairs(delthese) do
    for k, l in ipairs(particles) do
      if l.id > j then
        l.id = l.id - 1
      end
    end
    table.remove(particles, j - off)
    off = off + 1
  end

  for i, j in ipairs(pwords) do
    j[6] = j[6] + 1

    if j[6] > j[4] then
      j[6] = 0

      if j[5] == 1 or love.math.random(1, j[5]) == 1 then
        particle(j[2], j[1].x, j[1].y, j[3])
      end

    end
  end

end

bg_parts = {
  dot = function()
    particle("what", love.math.random(x_offset, x_offset + tilesize * levelx), love.math.random(x_offset, x_offset + tilesize * levely), 17)

  end
}
function bg_particles(ty)
  bg_parts[ty]()
end

function killparticles()
  pwords = {}
  for i, j in ipairs(particles) do
    table.remove(particles, 1)
  end
end

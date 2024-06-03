undolist = {}
undo_funcs = {}
undoing = false

function add_undo(undo_type, data)
  table.insert(undolist[#undolist], {undo_type, data})
end

function undo()
  if #undolist > 0 then
    local rc = undolist[#undolist]
    for a, b in ipairs(rc) do
      local revfunc = rc[1 + #rc - a]
      undo_funcs[revfunc[1]](revfunc[2])
    end
    table.remove(undolist, #undolist)
    undoing = true
    parse_text()

    for a, b in ipairs(Objects) do
      b.oldactive = b._active
      updatesprite(b)
    end

    startproperties()

    if #getplayers() == 0 then
      music:pause()
    elseif not music:isPlaying() then
      music:play()
    end

    love.audio.play(love.audio.newSource("sound/undo.wav","static"))
  end
  undoing = false
end

function undo_ob(undo_id)
  for _, f in ipairs(Objects) do
    if f.undo_id == undo_id then
      return f.id
    end
  end
end

undo_funcs.update = function(data)



  local old_x = data.old_x
  local old_y = data.old_y

  local o_uid = data.id
  local o_id = undo_ob(o_uid)
  local unit = Objects[o_id]

  unit.dir = data.dir

  unit.from_x = unit.x
  unit.from_y = unit.y

  unit.tilex = old_x
  unit.tiley = old_y

  unit.to_x = old_x * tilesize
  unit.to_y = old_y * tilesize
  unit.moving = true

  updatesprite(unit)

  doparse = true

end

undo_funcs.convert = function(data)
  local toconvert = data.convert

  local c_id = data.convert_id
  local o_id = undo_ob(c_id)
  local c = Objects[o_id]

  c.name=toconvert
  c.sprite=toconvert
  c.color=getspritevalues(toconvert).color
  c.type = getspritevalues(toconvert).type
  c._active = true
  c.file = nil
  dotiling(c)
  updatesprite(c)

end

undo_funcs.destroy = function(data)

  local dead = data.undo_id
  local deadid = data.id

  local dx, dy, dname, ddir = data.dx, data.dy, data.dname, data.ddir
  afterframeone = nil
  local unit = makeobject(dx, dy, dname, ddir)
  afterframeone = true
  unit.undo_id = data.undo_id

end

undo_funcs.create = function(data)
  local h = data.the_id
  removeunit(Objects[undo_ob(h)])
end





undo_funcs.iconchange = function(data)
  oldicon = data.oldicon

  local baseimage = love.image.newImageData("sprite/" .. oldicon .. ".png")
  local bcolor = getspritevalues(oldicon).color
  tint_icon(baseimage, bcolor)
  currenticon = oldicon
end

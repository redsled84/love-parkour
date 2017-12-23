Map = require "map"
bump = require "bump"

world = bump.newWorld 32, 32

Player = require "player"
player = Player nil, nil, nil, nil, world

Viewport = require "viewport"
viewport = Viewport!
-- player = nil

-- world\add player, player.x, player.y, player.width, player.height

createSolids = ->
  with Map!
    local map
    map = .exportMap!
    for i = 1, #map.layers
      if map.layers[i].name == "solids"
        for j = 1, #map.layers[i].objects
          local obj
          obj = map.layers[i].objects[j]
          world\add(obj, obj.x, obj.y, obj.width, obj.height)

createSolids!

love.graphics.setBackgroundColor 20, 15, 35

love.load = ->
  love.update = (dt) ->
    player\update dt, world
    viewport\update dt, player.xv, player.yv, player.x, player.y
    -- print player.yv, player.xv
    -- world\update dt
    -- print true
  love.draw = ->
    viewport.cam\attach!
    with Map!
      .draw!
    player\draw!
    viewport.cam\detach!
  love.keyreleased = (key) ->
    player\jump key

    if key == "r"
      love.event.quit "restart"
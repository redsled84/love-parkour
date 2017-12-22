Map = require "map"
bump = require "bump"
camera = require "camera"
cam = camera(0, 0)

world = bump.newWorld 32, 32

Player = require "player"
player = Player nil, nil, nil, nil, world
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
    cam\lookAt player.x, player.y
    -- world\update dt
    -- print true
  love.draw = ->
    cam\attach!
    with Map!
      .draw!
    player\draw!
    cam\detach!
  love.keypressed = (key) ->
    player\jump key

    if key == "r"
      love.event.quit "restart"
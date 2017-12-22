tutorial = require "tutorial"

class Map
  exportMap: =>
    return tutorial
  -- could replace `tutorial` with an argument for a level...
  draw: =>
    for i = 1, #tutorial.layers
      local layer
      layer = tutorial.layers[i]
      if layer.name == "solids"
        love.graphics.setColor 255, 230, 234
        for j = 1, #layer.objects
          local obj
          obj = tutorial.layers[i].objects[j]
          love.graphics.rectangle "fill", obj.x, obj.y, obj.width, obj.height
      if layer.name == "ledges"
        love.graphics.setColor 130, 230, 210
        for j = 1, #layer.objects
          local obj
          obj = tutorial.layers[i].objects[j]
          love.graphics.rectangle "fill", obj.x, obj.y, obj.width, obj.height
return Map
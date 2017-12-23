camera = require "camera"

class Viewport
  new: (@cam=camera(love.graphics.getWidth()/2, love.graphics.getHeight()/2)) =>
  update: (dt, xv, yv, x, y) =>
    @cam.x = xv * .01 + x
    @cam.y = yv * .02 + y
  
return Viewport
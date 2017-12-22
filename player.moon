class Player
  new: (@x=550, @y=-100, @width=18, @height=40, @world) =>
    @xv = 0
    @yv = 0
    @acc, @dec, @top = 1450, 2000, 750
    @low = 25
    @frc = 4500
    @onGround = false
    @terminalv = 3000
    @jumpv = -900
    @gravity = 2500
    @world\add self, @x, @y, @width, @height

  update: (dt, world) =>
    @applyGravity dt
    @move dt
    @collide dt, world

  applyGravity: (dt) =>
    if @yv > @terminalv
      @yv = @terminalv
    else
      @yv += @gravity * dt

  move: (dt) =>
    if love.keyboard.isDown "d"
      if @xv < 0
        @xv = @xv + @dec * dt
      elseif @xv < @top
        @xv = @xv + @acc * dt
    elseif love.keyboard.isDown "a"
      if @xv > 0
        @xv = @xv - @dec * dt
      elseif @xv > -@top
        @xv = @xv - @acc * dt
    else
      if math.abs(@xv) < @low
        @xv = 0
      elseif @xv > 0
        @xv = @xv - @frc * dt
      elseif @xv < 0
        @xv = @xv + @frc * dt

  collide: (dt, world) =>
    local futureX, futureY, nextX, nextY, cols, len
    futureX = @x + @xv * dt
    futureY = @y + @yv * dt
    nextX, nextY, cols, len = @world\move self, futureX, futureY

    @onGround = false
    for i = 1, len
      local col
      col = cols[i]
      if col.normal.y == -1 then
        @yv = 0
        @onGround = true

    @x, @y = nextX, nextY

  jump: (key) =>
    if key == "w" and @onGround
      @yv = @jumpv

  draw: =>
    love.graphics.setColor 60, 245, 130, 245
    love.graphics.rectangle "fill", @x, @y, @width, @height

return Player
class Player
  new: (@x=550, @y=-100, @width=18, @height=40, @world) =>
    @xv = 0
    @yv = 0
    @acc, @dec, @top = 1450, 2000, 750
    @low = 25
    @frc = 4500
    @onGround = false
    @terminalv = 3000
    @minJumpv = -600
    @maxJumpv = -1100
    @jumpv = @minJumpv
    @gravity = 2500
    @world\add self, @x, @y, @width, @height
    @state = "idle"

  update: (dt, world) =>
    @applyGravity dt
    @move dt
    @collide dt, world
    @updateState!

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

    if (love.keyboard.isDown("w") or love.keyboard.isDown("space"))and @jumpv > @maxJumpv
      @jumpv = @jumpv - 1000 * dt

  collide: (dt, world) =>
    local futureX, futureY, nextX, nextY, cols, len
    futureX = @x + @xv * dt
    futureY = @y + @yv * dt
    nextX, nextY, cols, len = @world\move self, futureX, futureY

    @onGround = false
    for i = 1, len
      local col
      col = cols[i]
      if col.normal.y == -1 or col.normal.y == 1
        @yv = 0
        @onGround = true
      if col.normal.x == -1 or col.normal.x == 1
        @xv = 0
      if math.abs(col.other.y - @y) < 64
        if col.normal.x == -1
          @world\update self, col.other.x - @width, col.other.y - @height - 10
        elseif col.normal.x == 1
          @world\update self, col.other.x + @width, col.other.y - @height - 10

      if col.normal.y == -1 and (love.keyboard.isDown("w") or love.keyboard.isDown("space"))
        if @x + @width > col.other.x + col.other.width
          @triggerJump!
        if @x < col.other.x
          @triggerJump!
    @x, @y = nextX, nextY

  updateState: =>
    if @yv < 0 and not @onGround
      @state = "jumping"
    elseif @yv > 0 and not @onGround
      @state = "falling"
    elseif @xv ~= 0 and @onGround
      @state = "running"
    elseif @xv == 0 and @onGround
      @state = "idle"

  triggerJump: =>
    @yv = @jumpv
    @jumpv = @minJumpv

  jump: (key) =>
    if (key == "w" or key == "space") and @onGround
      @triggerJump!

  draw: =>
    love.graphics.setColor 60, 245, 130, 245
    love.graphics.rectangle "fill", @x, @y, @width, @height

return Player
{Phaser} = this

_boot = Phaser.Camera::boot
_follow = Phaser.Camera::follow
_unfollow = Phaser.Camera::unfollow

Phaser.Camera::boot = ->
  _boot.apply this, arguments
  @targetOffset = new Phaser.Point
  this

Phaser.Camera::follow = (target, style, lerpX, lerpY, offsetX, offsetY) ->
  result = _follow.call this, target, style, lerpX, lerpY
  if offsetX? and offsetY?
    @targetOffset.set offsetX, offsetY
  result

Phaser.Camera::unfollow = ->
  result = _unfollow.call this, arguments
  @targetOffset.set 0
  result

Phaser.Camera::updateTarget = ->
  @_targetPosition.x = @view.x + @target.worldPosition.x
  @_targetPosition.y = @view.y + @target.worldPosition.y
  @_targetPosition.x += @targetOffset.x
  @_targetPosition.y += @targetOffset.y
  if @deadzone
    @_edge = @_targetPosition.x - (@view.x)
    if @_edge < @deadzone.left
      @view.x = @game.math.linear(@view.x, @_targetPosition.x - (@deadzone.left), @lerp.x)
    else if @_edge > @deadzone.right
      @view.x = @game.math.linear(@view.x, @_targetPosition.x - (@deadzone.right), @lerp.x)
    @_edge = @_targetPosition.y - (@view.y)
    if @_edge < @deadzone.top
      @view.y = @game.math.linear(@view.y, @_targetPosition.y - (@deadzone.top), @lerp.y)
    else if @_edge > @deadzone.bottom
      @view.y = @game.math.linear(@view.y, @_targetPosition.y - (@deadzone.bottom), @lerp.y)
  else
    @view.x = @game.math.linear(@view.x, @_targetPosition.x - (@view.halfWidth), @lerp.x)
    @view.y = @game.math.linear(@view.y, @_targetPosition.y - (@view.halfHeight), @lerp.y)
  if @bounds
    @checkBounds()
  if @roundPx
    @view.floor()
  @displayObject.position.x = -@view.x
  @displayObject.position.y = -@view.y
  return

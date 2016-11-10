player = undefined
cursors = undefined
line = new Phaser.Line
rect = new Phaser.Rectangle

RED = 'rgba(255,0,0,0.75)'
YELLOW = 'rgba(255,255,0,0.75)'
ORANGE = 'rgba(255,127,0,0.75)'

FOLLOW_STYLE = null # Phaser.Camera.FOLLOW_TOPDOWN

makeGui = (camera) ->
  {deadzone, lerp, targetOffset} = camera
  {width, height} = camera.view
  gui = new dat.GUI
  if deadzone
    deadzoneF = gui.addFolder 'deadzone'
    deadzoneF.add deadzone, 'x'
    deadzoneF.add deadzone, 'y'
    deadzoneF.add deadzone, 'width'
    deadzoneF.add deadzone, 'height'
  lerpF = gui.addFolder 'lerp'
  lerpF.add lerp, 'x', 0, 1, 0.05
  lerpF.add lerp, 'y', 0, 1, 0.05
  gui.add camera, 'reset'
  gui.add camera.game.renderer.renderSession, 'roundPixels'
  gui.add camera, 'shake'
  targetOffsetF = gui.addFolder 'targetOffset'
  targetOffsetF.add targetOffset, 'x', -width  / 2, width  / 2
  targetOffsetF.add targetOffset, 'y', -height / 2, height / 2
  gui.add camera, 'unfollow'
  gui

game = new Phaser.Game
  width: 960,
  height: 960,
  renderer: Phaser.CANVAS,
  state:

    preload: ->
      @load.baseURL = 'http://examples.phaser.io/assets/'
      @load.crossOrigin = 'anonymous'
      @load.image 'background', 'tests/debug-grid-1920x1920.png'
      @load.image 'player', 'sprites/phaser-dude.png'
      return

    create: ->
      {debug} = game
      @world.setBounds 0, 0, 1920, 1920
      @add.image @world.left, @world.top, 'background'
      player = @add.sprite @world.centerX, @world.centerY, 'player'
      player.anchor.set 0.5
      player.name = 'camera.target'
      cursors = game.input.keyboard.createCursorKeys()
      @camera.follow player, FOLLOW_STYLE, 0.5, 0.5, 64, 64
      @gui = makeGui @camera, width: 480
      debug.font = '16px monospace'
      debug.lineHeight = 24
      return

    update: ->
      if      cursors.up.isDown    then player.y -= 5
      else if cursors.down.isDown  then player.y += 5
      if      cursors.left.isDown  then player.x -= 5
      else if cursors.right.isDown then player.x += 5
      return

    render: ->
      {camera, debug} = game
      {deadzone, targetOffset, view} = camera
      {x, y} = camera._targetPosition
      debug.cameraInfo camera, 32, 32, 'yellow'
      debug.spriteCoords player, 32, 608, 'violet'
      line.setTo x, y, x - targetOffset.x, y - targetOffset.y
      debug.geom line, YELLOW
      debug.pixel view.centerX - view.x, view.centerY - view.y, YELLOW
      line.setTo x, y, view.centerX, view.centerY
      if line.length isnt 0
        debug.geom line, ORANGE
      if deadzone
        rect.copyFrom(deadzone).offset view.x, view.y
        debug.geom rect, RED, no
        debug.text "Deadzone: #{deadzone}", 32, 160, 'red', debug.font
      return

    shutdown: ->
      @gui.destroy()

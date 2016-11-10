// Generated by CoffeeScript 1.10.0
(function() {
  var FOLLOW_STYLE, ORANGE, RED, YELLOW, cursors, game, line, makeGui, player, rect;

  player = void 0;

  cursors = void 0;

  line = new Phaser.Line;

  rect = new Phaser.Rectangle;

  RED = 'rgba(255,0,0,0.75)';

  YELLOW = 'rgba(255,255,0,0.75)';

  ORANGE = 'rgba(255,127,0,0.75)';

  FOLLOW_STYLE = null;

  makeGui = function(camera) {
    var deadzone, deadzoneF, gui, height, lerp, lerpF, ref, targetOffset, targetOffsetF, width;
    deadzone = camera.deadzone, lerp = camera.lerp, targetOffset = camera.targetOffset;
    ref = camera.view, width = ref.width, height = ref.height;
    gui = new dat.GUI;
    if (deadzone) {
      deadzoneF = gui.addFolder('deadzone');
      deadzoneF.add(deadzone, 'x');
      deadzoneF.add(deadzone, 'y');
      deadzoneF.add(deadzone, 'width');
      deadzoneF.add(deadzone, 'height');
    }
    lerpF = gui.addFolder('lerp');
    lerpF.add(lerp, 'x', 0, 1, 0.05);
    lerpF.add(lerp, 'y', 0, 1, 0.05);
    gui.add(camera, 'reset');
    gui.add(camera.game.renderer.renderSession, 'roundPixels');
    gui.add(camera, 'shake');
    targetOffsetF = gui.addFolder('targetOffset');
    targetOffsetF.add(targetOffset, 'x', -width / 2, width / 2);
    targetOffsetF.add(targetOffset, 'y', -height / 2, height / 2);
    gui.add(camera, 'unfollow');
    return gui;
  };

  game = new Phaser.Game({
    width: 960,
    height: 960,
    renderer: Phaser.CANVAS,
    state: {
      preload: function() {
        this.load.baseURL = 'http://examples.phaser.io/assets/';
        this.load.crossOrigin = 'anonymous';
        this.load.image('background', 'tests/debug-grid-1920x1920.png');
        this.load.image('player', 'sprites/phaser-dude.png');
      },
      create: function() {
        var debug;
        debug = game.debug;
        this.world.setBounds(0, 0, 1920, 1920);
        this.add.image(this.world.left, this.world.top, 'background');
        player = this.add.sprite(this.world.centerX, this.world.centerY, 'player');
        player.anchor.set(0.5);
        player.name = 'camera.target';
        cursors = game.input.keyboard.createCursorKeys();
        this.camera.follow(player, FOLLOW_STYLE, 0.5, 0.5, 64, 64);
        this.gui = makeGui(this.camera, {
          width: 480
        });
        debug.font = '16px monospace';
        debug.lineHeight = 24;
      },
      update: function() {
        if (cursors.up.isDown) {
          player.y -= 5;
        } else if (cursors.down.isDown) {
          player.y += 5;
        }
        if (cursors.left.isDown) {
          player.x -= 5;
        } else if (cursors.right.isDown) {
          player.x += 5;
        }
      },
      render: function() {
        var camera, deadzone, debug, ref, targetOffset, view, x, y;
        camera = game.camera, debug = game.debug;
        deadzone = camera.deadzone, targetOffset = camera.targetOffset, view = camera.view;
        ref = camera._targetPosition, x = ref.x, y = ref.y;
        debug.cameraInfo(camera, 32, 32, 'yellow');
        debug.spriteCoords(player, 32, 608, 'violet');
        line.setTo(x, y, x - targetOffset.x, y - targetOffset.y);
        debug.geom(line, YELLOW);
        debug.pixel(view.centerX - view.x, view.centerY - view.y, YELLOW);
        line.setTo(x, y, view.centerX, view.centerY);
        if (line.length !== 0) {
          debug.geom(line, ORANGE);
        }
        if (deadzone) {
          rect.copyFrom(deadzone).offset(view.x, view.y);
          debug.geom(rect, RED, false);
          debug.text("Deadzone: " + deadzone, 32, 160, 'red', debug.font);
        }
      },
      shutdown: function() {
        return this.gui.destroy();
      }
    }
  });

}).call(this);

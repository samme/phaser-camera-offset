# Phaser Camera Offset

```javascript
// camera.follow(target, style, lerpX, lerpY, offsetX, offsetY)
camera.follow(player, FOLLOW_STYLE, 0.5, 0.5, 64, 64);

camera.targetOffset.x = 64;
camera.targetOffset.y = 64;

camera.targetOffset.set(64);

camera.targetOffset.set(0);

// Camera#unfollow will clear the offset
camera.unfollow();

camera.targetOffset.isZero() === true;
```

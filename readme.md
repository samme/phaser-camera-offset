![Screenshot](https://samme.github.io/phaser-camera-offset/screenshot.png)

[Demo](https://samme.github.io/phaser-camera-offset/)

Use
---

```javascript
// Set follow target, lerp, and offset:
// camera.follow(target, style, lerpX, lerpY, offsetX, offsetY)
camera.follow(player, FOLLOW_STYLE, 0.5, 0.5, 64, 64);

// Set offset only:
camera.targetOffset.x = 64;
camera.targetOffset.y = 64;

camera.targetOffset.set(64);

// Remove offset:
camera.targetOffset.set(0);

// Camera#unfollow() will also clear the offset
camera.unfollow();

camera.targetOffset.isZero() === true; //-> true
```

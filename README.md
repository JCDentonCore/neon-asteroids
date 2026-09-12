# Neon Asteroids

Arcade clásico estilo Asteroids en Godot 4 (Forward+, 3D): nave neon,
asteroides wireframe que se rompen, arena toroidal con grid, bloom,
starfield, puntaje, vidas, olas y récord persistente.

## Jugar

```fish
godot --path /home/jcgolinux/neon-asteroids
```

- WASD / flechas — girar y empujar
- ESPACIO — disparar (máx. 4 balas)
- ENTER — empezar / reiniciar
- F12 — screenshot a `user://auto_NN.png`

## Autopiloto (verificación)

```fish
godot --path /home/jcgolinux/neon-asteroids -- -auto
```

Con `-auto` la nave juega sola y guarda screenshots automáticos
(frames 90/240/480/720/1000) en
`~/.local/share/godot/app_userdata/Neon Asteroids/`.

## Licencia

GPL-3.0 — ver [LICENSE](LICENSE).

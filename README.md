# Neon Asteroids

Arcade clásico estilo Asteroids en Godot 4 (Forward+, 3D): nave neon,
asteroides wireframe que se rompen, arena toroidal con grid, bloom,
starfield, puntaje, vidas, olas y récord persistente.

## Jugar

```fish
godot --path ~/neon-asteroids
```

- WASD / flechas — girar y empujar
- ESPACIO — disparar (máx. 4 balas)
- ENTER — empezar / reiniciar
- F12 — screenshot a `user://auto_NN.png`
- **Mando de juego** — soportado (InputMap: giro en eje X, empuje en eje Y, disparo en eje 5)

## Autopiloto (verificación)

```fish
godot --path ~/neon-asteroids -- -auto
```

Con `-auto` la nave juega sola y guarda screenshots automáticos
(frames 90/240/480/720/1000) en
`~/.local/share/godot/app_userdata/Neón Asteroides/`.

## Créditos

- **JC Gaming On Linux** - Idea original, uso de motor godot, caracteristicas, testeo, binarios de Linux/Windows/Android

- **JC IA (La IA de JC Gaming On Linux)** - Desarrollo, programación, debug, etc

- **Fabiosarts** — audio (disparo láser, propulsor y explosión), InputMap con
  soporte de mando de juego, y ajuste del ritmo del juego (velocidad de la
  nave, de las balas y de las rocas). Gracias por el fork de este proyecto.
  

## Licencia

GPL-3.0 — ver [LICENSE](LICENSE).

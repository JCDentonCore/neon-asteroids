class_name Bullet
extends Node3D
## Neon bolt: flies straight, dies at the arena edge (no wrap), short lifetime.

var vel := Vector3.ZERO
var life := 1.25
var prev_pos := Vector3.ZERO


func launch(pos: Vector3, dir: Vector3, v: Vector3) -> void:
	# Clamp the spawn point inside the arena: a ship hugging the frame would
	# otherwise spawn the bolt outside and it would vanish on the first step.
	position = pos.clamp(Vector3(-G.ARENA_HALF, 0.0, -G.ARENA_HALF), Vector3(G.ARENA_HALF, 0.0, G.ARENA_HALF))
	prev_pos = position
	vel = v
	rotation.y = -atan2(dir.z, dir.x)


func _ready() -> void:
	var mi := MeshInstance3D.new()
	var bm := BoxMesh.new()
	bm.size = Vector3(1.1, 0.38, 0.38)
	mi.mesh = bm
	mi.material_override = G.unshaded(G.BULLET_COLOR, 3.0)
	add_child(mi)


func _physics_process(delta: float) -> void:
	prev_pos = position
	var np := position + vel * delta
	if absf(np.x) > G.ARENA_HALF or absf(np.z) > G.ARENA_HALF:
		queue_free()
		return
	position = np
	life -= delta
	if life <= 0.0:
		queue_free()

class_name Rock
extends Node3D
## Neon asteroid: jittered icosahedron convex hull, splits on hit.

var size_idx := 0  # 0 big, 1 medium, 2 small
var radius := 6.5
var vel := Vector3.ZERO

var _rotor: Node3D = null
var _spin_axis := Vector3.UP
var _spin_speed := 1.0
var _t := 0.0
var _seed := 0


func setup(idx: int, pos: Vector3, v: Vector3) -> void:
	size_idx = idx
	radius = G.ROCK_RADII[idx]
	position = pos
	vel = v
	_seed = randi()


func _ready() -> void:
	var axis := Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	_spin_axis = axis.normalized() if axis.length_squared() > 0.001 else Vector3.UP
	_spin_speed = randf_range(0.4, 1.6) * (0.7 if size_idx == 0 else 1.0)
	_build_mesh()


func _physics_process(delta: float) -> void:
	position = G.wrap_pos(position + vel * delta)
	_t += delta
	if _rotor:
		_rotor.rotate_object_local(_spin_axis, _spin_speed * delta)


func _build_mesh() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = _seed
	var t := (1.0 + sqrt(5.0)) / 2.0
	var base: PackedVector3Array = [
		Vector3(-1, t, 0), Vector3(1, t, 0), Vector3(-1, -t, 0), Vector3(1, -t, 0),
		Vector3(0, -1, t), Vector3(0, 1, t), Vector3(0, -1, -t), Vector3(0, 1, -t),
		Vector3(t, 0, -1), Vector3(t, 0, 1), Vector3(-t, 0, -1), Vector3(-t, 0, 1),
	]
	var pts := PackedVector3Array()
	for v in base:
		var j := rng.randf_range(0.72, 1.32)
		pts.append(v.normalized() * radius * j)

	var hull := ConvexPolygonShape3D.new()
	hull.points = pts
	var faces := G.convex_hull_faces(pts)
	var st := SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	for i in range(0, faces.size(), 3):
		st.add_vertex(pts[faces[i]])
		st.add_vertex(pts[faces[i + 1]])
		st.add_vertex(pts[faces[i + 2]])
	st.generate_normals()
	var mesh := st.commit()
	if mesh == null:
		mesh = ArrayMesh.new()

	_rotor = Node3D.new()
	add_child(_rotor)
	var col: Color = G.ROCK_COLORS[size_idx]

	var fill := G.unshaded(Color(col.r, col.g, col.b, 0.16), 0.25)
	var mi_fill := MeshInstance3D.new()
	mi_fill.mesh = mesh
	mi_fill.material_override = fill
	_rotor.add_child(mi_fill)

	var wire := G.unshaded(col, 2.4)
	var wire_mesh := G.lines_mesh(pts, G.hull_edges(faces))
	var mi_wire := MeshInstance3D.new()
	mi_wire.mesh = wire_mesh
	mi_wire.material_override = wire
	_rotor.add_child(mi_wire)

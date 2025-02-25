extends Camera3D

var is_active := true
@export var translate_speed: float = 3.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	if not is_active: return

	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		is_active = false

	var input_vector := Vector3()
	if Input.is_key_pressed(KEY_W):
		input_vector.z -= 1
	if Input.is_key_pressed(KEY_S):
		input_vector.z += 1
	if Input.is_key_pressed(KEY_A):
		input_vector.x -= 1
	if Input.is_key_pressed(KEY_D):
		input_vector.x += 1
	if Input.is_key_pressed(KEY_Q):
		input_vector.y -= 1
	if Input.is_key_pressed(KEY_E):
		input_vector.y += 1

	input_vector = input_vector.normalized()

	translate(input_vector * translate_speed * delta)


func _input(event: InputEvent):
	if not is_active:
		if event is InputEventMouseButton:
			is_active = true
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			return

	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				translate_speed *= 0.95
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				translate_speed /= 0.95

			translate_speed = clamp(translate_speed, 0.1, 10.0)


	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.001)
		rotate_object_local(Vector3.RIGHT, -event.relative.y * 0.001)

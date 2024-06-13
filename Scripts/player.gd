extends Area2D

signal hit;
@export var SPEED := 400;
@onready var anim = $anime_idle;
@onready var collision = $CollisionShape2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity := Input.get_vector("move_left", "move_right", "move_up", "move_down");
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED;
	position += velocity * delta;
	_changeAnimation(velocity);

#region Metodos
func _getScreenSize():
	var screenSize = get_viewport_rect().size;
	return screenSize;

func _changeAnimation(velocity: Vector2):
	if velocity.x != 0:
		anim.play("move")
	elif velocity.y > 0:
		anim.play("move_up")
	elif velocity.y < 0:
		anim.play("move_down")
	else:
		anim.play("idle")
	anim.flip_h = true if velocity.x > 0 else false;

func start_position(pos):
	position = pos;
	show();
	collision.disabled = false;

#endregion
#region Eventos Do Jogador
func _on_body_entered(body):
	hide();
	hit.emit();
	collision.set_deferred("disabled", true);
#endregion


extends Node2D

var _score;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _on_game_over() -> void:
	$BugTimer.stop();
	$ScoreTimer.stop();
	$Hud._show_game_over();
	$GameOver.play();
	$BgMusic.stop();
	get_tree().call_group("bugs", "queue_free");
	
func _new_game():
	$BgMusic.play();
	$StartTimer.start();
	$Player.start_position($StartPosition.position);
	_score = 0;
	$Hud.update_score(_score);
	$Hud._show_message("Get Ready!");
	get_tree().call_group("bugs", "queue_free");

func _on_bug_timer_timeout() -> void:
	var bug = preload("res://prefabs/enemy.tscn").instantiate();
	var bug_location = $bug_path/BugPathLocation;
	bug_location.progress_ratio = randf();
	
	var direction = bug_location.rotation + PI / 2;
	bug.position = bug_location.position;
	direction += randf_range(-PI / 4, PI/4);
	bug.rotation = direction;

	var velocity := Vector2(randf_range(150.0, 250.0), 0.0);
	
	bug.linear_velocity = velocity.rotated(direction);
	add_child(bug);

func _on_score_timer_timeout() -> void:
	_score += 1;
	$Hud.update_score(_score);

func _on_start_timer_timeout() -> void:
	$BugTimer.start();
	$ScoreTimer.start();

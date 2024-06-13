extends CanvasLayer

signal start_game
@onready var message_label := $Control/MessageLabel;
@onready var message_timer := $Control/MessageTimer;
@onready var start_button := $Control/StartButton;
@onready var score_label := $Control/ScoreLabel;


func _show_message(text: StringName):
	message_label.text = text;
	message_label.show();
	message_timer.start();

func _show_game_over():
	score_label.text = "0";
	_show_message("Game Over");
	await message_timer.timeout;
	await get_tree().create_timer(1.0).timeout;
	message_label.text = "Retry?";
	message_label.show();
	start_button.show();

func update_score(score: int):
	score_label.text = str(score);


func _on_start_button_pressed() -> void:
	start_button.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	message_label.hide();

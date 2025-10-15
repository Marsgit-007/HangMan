extends PanelContainer
@onready var label: Label = $Label


var tween:Tween
var label_text:String

func start_timer(delay):
	label.text = label_text
	$OffSetTimer.wait_time = float(delay)
	$OffSetTimer.start()
	
func start_moving():
	tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position:y", 3, 0.9).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:y", 0, 0.9).set_trans(Tween.TRANS_CUBIC)


func _on_off_set_timer_timeout() -> void:
	start_moving()

extends CanvasLayer

func _ready():
	update_ghost_count(0)

func update_ghost_count(count: int):
	%GhostCounter.text = "Ghosts Collected: " + str(count)

func update_timer(time: float):
	%Timer.text = ("Time: %.2f" % time)

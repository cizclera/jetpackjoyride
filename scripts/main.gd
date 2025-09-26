extends Node2D

var obstacleArr : Array
var obstaclenode = preload("res://scenes/obstacle.tscn")
var obstacleSTART_SPEED = 150
var obstacleDELAY = randi_range(10, 200)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$obstacletimer.start_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for obstacle in obstacleArr:
		obstacle.position.x -= obstacleSTART_SPEED * delta
	obstacleSTART_SPEED += 0.05


func spawnobstacles():
	var obsSCALErando = randf_range(0.5, 1.0)
	var obstacleinstance = obstaclenode.instantiate()
	obstacleinstance.position.x = 1000 + obstacleDELAY
	obstacleinstance.position.y = randi_range(100, 350)
	obstacleinstance.scale = Vector2(obsSCALErando, obsSCALErando)
	obstacleinstance.rotation = randf_range(0, 2 * PI)
	print("size: ", obstacleinstance.scale)
	print("rotation: ", obstacleinstance.rotation)
	obstacleinstance.hit.connect(oncollision)
	add_child(obstacleinstance)
	obstacleArr.append(obstacleinstance)

func oncollision():
	print("collided")

func _on_obstacletimer_timeout() -> void:
	spawnobstacles()
	$obstacletimer.stop()
	$obstacletimer.start_random()
	print("wait time: ", $obstacletimer.wait_time)

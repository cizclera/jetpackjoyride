extends Node2D

var gamerunning : bool = false
var gameover : bool = false

var score : float
var speed : float = 50
var highscore : int

var obstacleArr : Array
var obstaclenode = preload("res://scenes/obstacle.tscn")
var obstacleSTART_SPEED = 150
var obstacleDELAY = randi_range(10, 200)

var groundObsArr : Array
var groundOBSNode = preload("res://scenes/ground_obstacle.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startgame()


func startgame():
	score = 0
	obstacleSTART_SPEED = 150
	gamerunning = true
	gameover = false
	$player.running = true
	obstacleArr.clear()
	groundObsArr.clear()
	$GameOver.hide()
	$obstacletimer.start_random()
	$groundOBStimer.start_random()
	get_tree().call_group("obstacles", "queue_free")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gamerunning == true:
		for obstacle in obstacleArr:
			obstacle.position.x -= obstacleSTART_SPEED * delta
		for groundOBS in groundObsArr:
			groundOBS.position.x -= obstacleSTART_SPEED * delta
		obstacleSTART_SPEED += 0.05
		score = speed * delta
		$HUD/Distance.text = "Distance: " + str(int(score)) + ("m")
		speed += 3
	if gameover == true:
		score = 0


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


func spawnGroundOBS():
	var groundOBSinstance = groundOBSNode.instantiate()
	groundOBSinstance.position.x = 1000 + obstacleDELAY
	groundOBSinstance.position.y = 458
	groundOBSinstance.ground_hit.connect(oncollision)
	add_child(groundOBSinstance)
	groundObsArr.append(groundOBSinstance)


func _on_obstacletimer_timeout() -> void:
	spawnobstacles()
	$obstacletimer.stop()
	$obstacletimer.start_random()
	print("wait time: ", $obstacletimer.wait_time)


func _on_ground_ob_stimer_timeout() -> void:
	spawnGroundOBS()
	$groundOBStimer.stop()
	$groundOBStimer.start_random()
	print("wait time for ground: ", $groundOBStimer.wait_time)


func stopgame():
	$obstacletimer.stop()
	$groundOBStimer.stop()
	gameover = true
	gamerunning = false
	$GameOver.show()
	$player.running = false
	$GameOver/Score.text = "Score: " + str(int(score))
	if score >= highscore:
		$GameOver/HighScore.text = "High Score: " + str(int(score))
		highscore = score
	else:
		$GameOver/HighScore.text = "High Score: " + str(int(highscore))
	score = 0


func oncollision():
	print("collided")
	stopgame()


func _on_game_over_restart() -> void:
	startgame()

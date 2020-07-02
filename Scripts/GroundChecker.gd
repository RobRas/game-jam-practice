extends Node2D

func is_grounded():
	return $GroundCheckerLeft.is_colliding() or $GroundCheckerRight.is_colliding()

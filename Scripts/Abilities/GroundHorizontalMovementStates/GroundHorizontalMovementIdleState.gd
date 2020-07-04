extends Node

signal entering(from)
signal exiting(to)

var States = preload("res://Scripts/Abilities/GroundHorizontalMovement.gd").States

func enter(from):
	pass

func exit(to):
	pass

func update(parent, input, delta):
	if input != 0:
		exit(States.IDLE)

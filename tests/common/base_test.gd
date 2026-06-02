class_name BaseTest
extends GdUnitTestSuite


## Shortcut for `global_position + size / 2`
func get_center_position(node: Node) -> Vector2:
	return node.global_position + node.size / 2

class_name MinimalTest
extends GdUnitTestSuite
@warning_ignore_start("REDUNDANT_AWAIT")


func test_basic_ui_interactions_work() -> void:
	# Arrange
	var runner := scene_runner("res://samples/minimal/minimal.tscn")
	var button_layer: CanvasLayer = runner.get_property("layer")

	# Act/Assert
	assert_str(runner.get_property("text")).is_equal("Click")

	# Click on the button
	runner.set_mouse_position(Vector2(100, 100))
	await runner.await_input_processed()

	await runner.simulate_mouse_move_absolute(Vector2(10, 10), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Items dropdown opens
	assert_bool(button_layer.visible).is_true()

	# Click on the first option
	await runner.simulate_mouse_move_absolute(Vector2(10, 40), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(runner.get_property("text")).is_equal("Option 1")
	assert_bool(button_layer.visible).is_false()

	# Click on the second option
	await runner.simulate_mouse_move_absolute(Vector2(10, 10), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	await runner.simulate_mouse_move_absolute(Vector2(10, 80), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(runner.get_property("text")).is_equal("Option 2")
	assert_bool(button_layer.visible).is_false()

	# Open the button again and click outside
	await runner.simulate_mouse_move_absolute(Vector2(10, 10), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	await runner.simulate_mouse_move_absolute(Vector2(100, 100), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option remains the same, dropdown closes
	assert_str(runner.get_property("text")).is_equal("Option 2")
	assert_bool(button_layer.visible).is_false()

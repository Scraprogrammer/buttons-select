class_name MinimalTest
extends BaseTest
@warning_ignore_start("REDUNDANT_AWAIT")

var runner: GdUnitSceneRunner
var button_layer: CanvasLayer
var buttons: VBoxContainer
var dropdown: ButtonsSelect


func before() -> void:
	runner = scene_runner("res://samples/minimal/minimal.tscn")
	dropdown = runner.scene()
	button_layer = runner.get_property("layer")
	buttons = runner.get_property("buttons")


func test_select_first_option() -> void:
	# Scene loaded with initial dropdown text set
	assert_str(dropdown.text).is_equal("Click")

	# Set the mouse outside of control
	runner.set_mouse_position(Vector2(100, 100))
	await runner.await_input_processed()

	# Move over the dropdown and click
	await runner.simulate_mouse_move_absolute(get_center_position(dropdown), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Expect dropdown to be opened and aligned
	assert_bool(button_layer.visible).is_true()
	assert_float(buttons.global_position.x).is_equal(dropdown.global_position.x)
	assert_float(buttons.size.x).is_equal(dropdown.size.x)

	# Click on the first option
	var first_option = dropdown.buttons.get_child(0)
	await runner.simulate_mouse_move_absolute(get_center_position(first_option), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(dropdown.text).is_equal("Option 1")
	assert_bool(button_layer.visible).is_false()


func test_select_second_option() -> void:
	# Click on the dropdown again
	await runner.simulate_mouse_move_absolute(get_center_position(dropdown), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Items dropdown opens again
	assert_bool(button_layer.visible).is_true()
	assert_float(buttons.global_position.x).is_equal(dropdown.global_position.x)
	assert_float(buttons.size.x).is_equal(dropdown.size.x)

	# Click the second option
	var second_option = dropdown.buttons.get_child(1)
	await runner.simulate_mouse_move_absolute(get_center_position(second_option), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(dropdown.text).is_equal("Option 2")
	assert_bool(button_layer.visible).is_false()


func test_close_by_clicking_outside() -> void:
	var original_text = dropdown.text
	# Open the button again
	await runner.simulate_mouse_move_absolute(get_center_position(dropdown), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Items dropdown opens again
	assert_bool(button_layer.visible).is_true()
	assert_float(buttons.global_position.x).is_equal(dropdown.global_position.x)
	assert_float(buttons.size.x).is_equal(dropdown.size.x)

	# Move the mouse outside of the control and click
	await runner.simulate_mouse_move_absolute(Vector2(100, 100), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option remains the same, dropdown closes
	assert_str(dropdown.text).is_equal(original_text)
	assert_bool(button_layer.visible).is_false()

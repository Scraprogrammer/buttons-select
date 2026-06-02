class_name WithThemeTest
extends BaseTest
@warning_ignore_start("REDUNDANT_AWAIT")

var runner: GdUnitSceneRunner
var parent: CanvasLayer
var dropdown: ButtonsSelect


func before() -> void:
	runner = scene_runner("res://samples/with_theme/with_theme.tscn")
	parent = runner.scene()
	dropdown = parent.buttons_select


func test_select_first_option() -> void:
	# Scene loaded with initial parent text set and reasonable height
	await await_idle_frame()
	assert_str(dropdown.text).is_equal("ONLINE")
	assert_float(dropdown.size.y).is_not_equal(parent.tall_control.size.y)

	# Set the mouse outside of control
	runner.set_mouse_position(get_center_position(parent.get_child(0)))
	await runner.await_input_processed()

	# Move over the parent and click
	await runner.simulate_mouse_move_absolute(get_center_position(dropdown), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Expect dropdown to be opened and aligned
	assert_bool(dropdown.layer.visible).is_true()
	assert_float(dropdown.buttons.global_position.x).is_equal(dropdown.global_position.x)
	assert_float(dropdown.buttons.size.x).is_equal(dropdown.size.x)

	# Click on the first option
	var first_option = dropdown.buttons.get_child(0)
	await runner.simulate_mouse_move_absolute(get_center_position(first_option), 0.5)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(dropdown.text).is_equal("OFFLINE")
	assert_bool(dropdown.layer.visible).is_false()

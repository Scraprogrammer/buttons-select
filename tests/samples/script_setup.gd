class_name ScriptSetupTest
extends GdUnitTestSuite
@warning_ignore_start("REDUNDANT_AWAIT")

var runner: GdUnitSceneRunner
var parent: CanvasLayer
var dropdown_1: ButtonsSelect
var dropdown_2: ButtonsSelect
var dropdown_3: ButtonsSelect


func before() -> void:
	runner = scene_runner("res://samples/script_setup/script_setup.tscn")
	parent = runner.scene()
	dropdown_1 = parent.dropdowns.get_child(0)
	dropdown_2 = parent.dropdowns.get_child(1)
	dropdown_3 = parent.dropdowns.get_child(2)


func get_center_position(control: Control) -> Vector2:
	return control.global_position + control.size / 2


func test_use_first_dropdown() -> void:
	# Scene loaded with first option set
	assert_str(dropdown_1.text).is_equal("Option 1")

	# Set the mouse outside of control
	runner.set_mouse_position(Vector2(0, 0))
	await runner.await_input_processed()

	# Move over the button and click
	await runner.simulate_mouse_move_absolute(get_center_position(dropdown_1), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Expect dropdown to be opened and aligned
	assert_bool(dropdown_1.layer.visible).is_true()
	assert_float(dropdown_1.buttons.global_position.x).is_equal(dropdown_1.global_position.x)
	assert_float(dropdown_1.buttons.size.x).is_equal(dropdown_1.size.x)

	# Select option
	var third_option = dropdown_1.buttons.get_child(2)
	await runner.simulate_mouse_move_absolute(get_center_position(third_option), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(dropdown_1.text).is_equal("Option 3")
	assert_bool(dropdown_1.layer.visible).is_false()


func test_use_second_dropdown() -> void:
	# Scene loaded with first option set
	assert_str(dropdown_2.text).is_equal("Another Option 1")

	# Set the mouse outside of control
	runner.set_mouse_position(Vector2(0, 0))
	await runner.await_input_processed()

	# Move over the parent and click
	await runner.simulate_mouse_move_absolute(get_center_position(dropdown_2), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Expect dropdown to be opened and aligned
	assert_bool(dropdown_2.layer.visible).is_true()
	assert_float(dropdown_2.buttons.global_position.x).is_equal(dropdown_2.global_position.x)
	assert_float(dropdown_2.buttons.size.x).is_equal(dropdown_2.size.x)

	# Select option
	var second_option = dropdown_2.buttons.get_child(1)
	await runner.simulate_mouse_move_absolute(get_center_position(second_option), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(dropdown_2.text).is_equal("Short Opt 2")
	assert_bool(dropdown_2.layer.visible).is_false()


func test_use_third_dropdown() -> void:
	# Scene loaded with first option set
	assert_str(dropdown_3.text).is_equal("Easy")

	# Set the mouse outside of control
	runner.set_mouse_position(Vector2(0, 0))
	await runner.await_input_processed()

	# Move over the parent and click
	await runner.simulate_mouse_move_absolute(get_center_position(dropdown_3), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Expect dropdown to be opened and aligned
	assert_bool(dropdown_3.layer.visible).is_true()
	assert_float(dropdown_3.buttons.global_position.x).is_equal(dropdown_3.global_position.x)
	assert_float(dropdown_3.buttons.size.x).is_equal(dropdown_3.size.x)

	# Select option
	var fifth_option = dropdown_3.buttons.get_child(4)
	await runner.simulate_mouse_move_absolute(get_center_position(fifth_option), 1)

	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()

	# Option chosen, dropdown closes
	assert_str(dropdown_3.text).is_equal("Impossibly Unfair")
	assert_bool(dropdown_3.layer.visible).is_false()

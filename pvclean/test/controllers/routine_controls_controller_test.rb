require 'test_helper'

class RoutineControlsControllerTest < ActionController::TestCase
  setup do
    @routine_control = routine_controls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:routine_controls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create routine_control" do
    assert_difference('RoutineControl.count') do
      post :create, routine_control: { enabled: @routine_control.enabled, monthly: @routine_control.monthly }
    end

    assert_redirected_to routine_control_path(assigns(:routine_control))
  end

  test "should show routine_control" do
    get :show, id: @routine_control
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @routine_control
    assert_response :success
  end

  test "should update routine_control" do
    patch :update, id: @routine_control, routine_control: { enabled: @routine_control.enabled, monthly: @routine_control.monthly }
    assert_redirected_to routine_control_path(assigns(:routine_control))
  end

  test "should destroy routine_control" do
    assert_difference('RoutineControl.count', -1) do
      delete :destroy, id: @routine_control
    end

    assert_redirected_to routine_controls_path
  end
end

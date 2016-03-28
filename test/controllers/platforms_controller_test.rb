require 'test_helper'

class PlatformsControllerTest < ActionController::TestCase
  setup do
    @platform = platforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:platforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create platform" do
    assert_difference('Platform.count') do
      post :create, platform: { description: @platform.description, gain1: @platform.gain1, gain2: @platform.gain2, picture: @platform.picture, target1: @platform.target1, target2: @platform.target2, title: @platform.title }
    end

    assert_redirected_to platform_path(assigns(:platform))
  end

  test "should show platform" do
    get :show, id: @platform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @platform
    assert_response :success
  end

  test "should update platform" do
    patch :update, id: @platform, platform: { description: @platform.description, gain1: @platform.gain1, gain2: @platform.gain2, picture: @platform.picture, target1: @platform.target1, target2: @platform.target2, title: @platform.title }
    assert_redirected_to platform_path(assigns(:platform))
  end

  test "should destroy platform" do
    assert_difference('Platform.count', -1) do
      delete :destroy, id: @platform
    end

    assert_redirected_to platforms_path
  end
end

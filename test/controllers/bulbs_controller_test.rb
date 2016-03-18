require 'test_helper'

class BulbsControllerTest < ActionController::TestCase
  setup do
    @bulb = bulbs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bulbs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bulb" do
    assert_difference('Bulb.count') do
      post :create, bulb: { category: @bulb.category, forwhom: @bulb.forwhom, need: @bulb.need, private: @bulb.private, title: @bulb.title, user_id: @bulb.user_id, what: @bulb.what, why: @bulb.why }
    end

    assert_redirected_to bulb_path(assigns(:bulb))
  end

  test "should show bulb" do
    get :show, id: @bulb
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bulb
    assert_response :success
  end

  test "should update bulb" do
    patch :update, id: @bulb, bulb: { category: @bulb.category, forwhom: @bulb.forwhom, need: @bulb.need, private: @bulb.private, title: @bulb.title, user_id: @bulb.user_id, what: @bulb.what, why: @bulb.why }
    assert_redirected_to bulb_path(assigns(:bulb))
  end

  test "should destroy bulb" do
    assert_difference('Bulb.count', -1) do
      delete :destroy, id: @bulb
    end

    assert_redirected_to bulbs_path
  end
end

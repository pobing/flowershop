require 'test_helper'

class TabflowersControllerTest < ActionController::TestCase
  setup do
    @tabflower = tabflowers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tabflowers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tabflower" do
    assert_difference('Tabflower.count') do
      post :create, :tabflower => @tabflower.attributes
    end

    assert_redirected_to tabflower_path(assigns(:tabflower))
  end

  test "should show tabflower" do
    get :show, :id => @tabflower.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tabflower.to_param
    assert_response :success
  end

  test "should update tabflower" do
    put :update, :id => @tabflower.to_param, :tabflower => @tabflower.attributes
    assert_redirected_to tabflower_path(assigns(:tabflower))
  end

  test "should destroy tabflower" do
    assert_difference('Tabflower.count', -1) do
      delete :destroy, :id => @tabflower.to_param
    end

    assert_redirected_to tabflowers_path
  end
end

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect from index to login when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect from edit to login when no logged in" do
    get :edit,id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end


  test "should redirect from update to login when no logged in" do
    patch :update,id: @user, user:{name: @user.name, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect from edit to login when login as wrong user" do
    log_in_as(@other_user)
    get :edit,id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect from update to login when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update,id: @user, user:{name: @user.name, email: @user.email}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect from delete to login page when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy,id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect from delete to home page when not admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy,id: @user
    end
    assert_redirected_to root_url
  end
end

require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post :create , micropost:{content: "yo bor!"}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      post :destroy , id: @micropost
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when trying to delete other user's posts" do
    log_in_as(users(:michael))
    @micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      post :destroy , id: @micropost
    end
    assert_redirected_to root_url
  end
end

require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @micropost = Micropost.new(content: "Here m i" , user_id: @user.id)
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end

  test "should contain user_id" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "should contain content" do
    @micropost.content = "  "
    assert_not @micropost.valid?
  end

  test "content length less than 140" do
    @micropost.content = 'a'*141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end

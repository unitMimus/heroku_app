require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  test "follow-unfollow display" do
    michael = users(:michael)
    archer  = users(:archer)
    log_in_as(michael)
    get user_path(archer)
    assert_not michael.following?(archer)
    assert_match 'value="Follow"', response.body
    michael.follow(archer)
    get user_path(archer)
    assert michael.following?(archer)
    assert_match 'value="Unfollow"', response.body
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
end

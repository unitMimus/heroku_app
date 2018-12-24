require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
    @nonactuser = users(:malory)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path

    #велосипеды с костылями вместо колес
    @nonactuser.update_columns(activated: nil, activated_at: nil)
    get users_path
    assert_select 'a', text: @nonactuser.name, count: 0
    @nonactuser.update_columns(activated: true, activated_at: Time.zone.now)
    get users_path
    assert_select 'a', text: @nonactuser.name, count: 1

    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
    assert_select 'a', text: @nonactuser.name, count: 1
    @nonactuser.update_columns(activated: nil, activated_at: nil)
    get users_path
    assert_select 'a', text: @nonactuser.name, count: 0
  end
end

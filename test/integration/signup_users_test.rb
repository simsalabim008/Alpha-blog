require 'test_helper'

class SignupUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
  end

  test "invalid password submission results in failure" do
    # sign_in_as(@user, "password1")
    get user_path
    # assert_template 'users/show'
    assert_no_difference 'User.count' do
      post users_path, params:{user: {name: "John", password: "password1"}}
    end
    # assert_template 'users/index'
    assert_select 'h2.card-title'
    assert_select 'div.card-body'
  end

end

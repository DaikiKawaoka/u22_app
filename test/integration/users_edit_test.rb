require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
#編集失敗時のテスト
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              user_name: "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "foooooooo",
                                              sex:1,
                                              user_comment: "aaaaaaaaaaaaaaaaa" } }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    user_name="aaafi"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              user_name: user_name,
                                              sex: 1,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
require "test_helper"

class InvalidNewUserWorkflowTest < ActionDispatch::IntegrationTest
  fixtures :all

  # -----------  New User / Sign Up Page Form ---------------

  test 'try to create a new user without login' do
    @user = users(:user1)
    get '/users/sign_up'
    assert_response :success

    post '/users', params:{user: {username: @user.username}}
    assert_equal '/users', path
    assert_select 'li', "Email can't be blank"
    assert_select 'li', "Password can't be blank"
  end

  test 'try to create a new user without password' do
    @user = users(:user1)
    get '/users/sign_up'
    assert_response :success

    post '/users', params:{user: {email: @user.email, username: @user.username}}
    assert_equal '/users', path
    assert_select 'li', "Password can't be blank"
  end

  test 'try to create a new user with invalid password' do
    @user = users(:user1)
    get '/users/sign_up'
    assert_response :success

    post '/users', params:{user: {email: @user.email, password: 'passw', password_confirmation: 'passw', username: @user.username}}
    assert_equal '/users', path
    assert_select 'li', "Password is too short (minimum is 6 characters)"
  end

  test 'try to create a new user without matching passwords' do
    @user = users(:user1)
    get '/users/sign_up'
    assert_response :success

    post '/users', params:{user: {email: @user.email, password: 'passw', password_confirmation: 'password', username: @user.username}}
    assert_equal '/users', path
    assert_select 'li', "Password confirmation doesn't match Password"
  end

end

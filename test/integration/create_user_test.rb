require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest

  test "should get new user form and create user" do
    # GET "/signup"
    get signup_path
    assert_response :success
    assert_difference("User.count", 1) do
      # POST "/users"
      post users_path, params: { 
        user: { username: "test2", email: "test2@test.com", password: "teste2" }
      }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert session[:current_user_id].present?
    assert_match "Welcome to the Alpha-Blog", response.body
  end

  test "should get new category form and reject invalid category" do
    # GET "/signup"
    get signup_path
    assert_response :success
    assert_no_difference("User.count") do
      # POST "/users"
      post users_path, params: { user: { username: " ", email: " ", password: " " } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end

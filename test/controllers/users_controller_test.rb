require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "test", email: "test@test.com", password: "teste", admin: true)
    @user = User.create(username: "test1", email: "test1@test.com", password: "teste1", admin: false)
    @user_params = { username: "test2", email: "test2@test.com", password: "teste2", admin: false }
  end

  test "should get new" do
    # GET "/signup"
    get signup_path
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count", 1) do
      # POST "/users"
      post users_path, params: { user: @user_params }
    end
    assert session[:current_user_id].present?
    assert_redirected_to articles_path
  end

  test "should get index" do
    # GET "/users"
    sign_in_as(@user)
    get users_path
    assert_response :success
  end

  test "should show user" do
    # GET "/users/:id"
    sign_in_as(@user)
    get users_path(@user)
    assert_response :success
  end

  test "should get edit if current_user is the edit user" do
    # GET "/users/:id/edit"
    sign_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should not get edit if current_user is not the edit user" do
    # GET "/users/:id/edit"
    @user2 = User.create(@user_params)
    sign_in_as(@user2)
    get edit_user_path(@user)
    assert_redirected_to user_path(@user)
  end

  test "should get edit if current_user is not the edit user but is an admin" do
    # GET "/users/:id/edit"
    sign_in_as(@admin_user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user if current_user is the edit user" do
    sign_in_as(@user)
    # PUT "/users/:id"
    patch user_path(@user), params: { user: @user_params }
    assert_redirected_to user_path(@user)
  end

  test "should not update user if current_user is not the edit user" do
    @user2 = User.create(@user_params)
    sign_in_as(@user2)
    # PUT "/users/:id"
    patch user_path(@user), params: { user: @user_params }
    assert_redirected_to user_path(@user)
  end

  test "should update user if current_user is not the edit user but is an admin" do
    sign_in_as(@admin_user)
    # PUT "/users/:id"
    patch user_path(@user), params: { user: @user_params }
    assert_redirected_to user_path(@user)
  end

  test "should destroy user if current_user is the delete user" do
    sign_in_as(@user)
    @article = Article.create(title: 'teste teste', description: 'teste teste teste')
    @user.articles << @article
    assert_difference(["User.count", "Article.count"], -1) do
      # DELETE "/users/:id"
      delete user_path(@user)
    end
    assert session[:current_user_id].nil?
    assert_redirected_to root_path
  end

  test "should not destroy user if current_user is not the delete user" do
    @user2 = User.create(@user_params)
    sign_in_as(@user2)
    assert_no_difference("User.count", -1) do
      # DELETE "/users/:id"
      delete user_path(@user)
    end

    assert_redirected_to user_path(@user)
  end

  test "should destroy user if current_user is not the delete user but is an admin" do
    sign_in_as(@admin_user)
    assert_difference("User.count", -1) do
      # DELETE "/users/:id"
      delete user_path(@user)
    end

    assert_redirected_to users_path
  end
end

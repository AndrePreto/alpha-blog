require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(
      username: 'test', 
      email: 'test@test.com', 
      password: 'teste123', 
      admin: true
    )
    sign_in_as(@admin_user)
  end

  test "should get new category form and create category" do
    # GET "/categories/new"
    get new_category_path
    assert_response :success
    assert_difference("Category.count", 1) do
      # POST "/categories"
      post categories_path, params: { category: { name: "Sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "should get new category form and reject invalid category" do
    # GET "/categories/new"
    get new_category_path
    assert_response :success
    assert_no_difference("Category.count") do
      # POST "/categories"
      post categories_path, params: { category: { name: "" } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end

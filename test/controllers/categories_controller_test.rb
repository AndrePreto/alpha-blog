require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(username: 'test', email: 'test@test.com', password: 'teste1', admin: true)
    @user = User.create(username: 'test1', email: 'test1@test.com', password: 'teste1', admin: false)
  end

  test "should get index" do
    # GET "/categories"
    sign_in_as(@user)
    get categories_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user)
    # GET "/categories/new"
    get new_category_path
    assert_response :success
  end

  test "should create category" do
    sign_in_as(@admin_user)
    assert_difference('Category.count', 1) do
      # POST "/categories"
      post categories_path, params: { category: { name: 'Teste' } }
    end

    assert_redirected_to category_path(Category.last)
  end

  test "should not create category if not admin" do
    sign_in_as(@user)
    assert_no_difference('Category.count') do
      # POST "/categories"
      post categories_path, params: { category: { name: 'Teste' } }
    end

    assert_redirected_to categories_path
  end

  test "should show category" do
    sign_in_as(@user)
    # GET "/categories/:id"
    get category_path(@category)
    assert_response :success
  end

  test "should get edit" do
    # GET "/categories/:id/edit"
    sign_in_as(@admin_user)
    get edit_category_path(@category)
    assert_response :success
  end

  test "should update category if admin" do
    sign_in_as(@admin_user)
    # PUT "/categories/:id"
    patch category_path(@category), params: { category: { name: 'Teste2' } }
    assert_redirected_to category_path(@category)
  end

  test "should not update category if not admin" do
    sign_in_as(@user)
    # PUT "/categories/:id"
    patch category_path(@category), params: { category: { name: 'Teste2' } }
    assert_redirected_to categories_path
  end

  test "should destroy category if admin" do
    sign_in_as(@admin_user)
    assert_difference('Category.count', -1) do
      # DELETE "/categories/:id"
      delete category_path(@category)
    end

    assert_redirected_to categories_path
  end

  test "should not destroy category if not admin" do
    sign_in_as(@user)
    assert_no_difference('Category.count', -1) do
      # DELETE "/categories/:id"
      delete category_path(@category)
    end

    assert_redirected_to categories_path
  end
end

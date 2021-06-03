require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: 'Sports')
    @category2 = Category.create(name: 'Travel')
    @user = User.create(username: 'test1', email: 'test1@test.com', password: 'teste1', admin: false)
  end

  test "should show categories listing" do
    sign_in_as(@user)
    # GET "/categories"
    get categories_path
    assert_response :success
    assert_select "a[href=?]", category_path(@category)
    assert_select "a[href=?]", category_path(@category2)
  end
end

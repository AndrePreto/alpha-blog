require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: 'Sports')
    @category2 = Category.create(name: 'Travel')
  end

  test "should show categories listing" do
    # GET "/categories"
    get categories_path
    assert_response :success
    assert_select "a[href=?]", category_path(@category)
    assert_select "a[href=?]", category_path(@category2)
  end
end

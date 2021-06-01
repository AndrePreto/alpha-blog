require 'test_helper'

class CatergoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'Sports')
  end
  
  test "category should be valid" do
    assert @category.valid?
  end

  test "category name should be present" do
    @category.name = ''
    assert_not @category.valid?
  end

  test "category name should be unique" do
    @category.save
    @category2 = Category.new(name: 'Sports')
    assert_not @category2.valid?
  end

  test "category name should not be too long" do
    @category.name = 'The history of sports and athletes'
    assert_not @category.valid?
  end

  test "category name should not be too short" do
    @category.name = 'A'
    assert_not @category.valid?
  end


end
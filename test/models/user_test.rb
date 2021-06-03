require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: 'test1', email: 'test1@test.com', password: 'teste1', admin: false)
  end
  
  test "user should be valid" do
    assert @user.valid?
  end

  test "user username should be present" do
    ['', nil].each do |username|
      @user.username = username
      assert_not @user.valid?
    end
  end

  test "user username should not be too long or too short" do
    ['aa', 'aaaaaaaaaaaaaaaaaaaaaaaaaa'].each do |username|
      @user.username = username
      assert_not @user.valid?
    end
  end

  test "user username should be unique" do
    @user.save
    @user2 = User.new(
      username: 'test1', 
      email: 'teste2@teste.com', 
      password: 'password123',
      admin: false
    )
    assert_not @user2.valid?
  end

  test "user email should be present" do
    ['', nil].each do |email|
      @user.email = email
      assert_not @user.valid?
    end
  end

  test "user email should not be too long" do
    @user.email = "#{'a'*100}@test.com"
    assert_not @user.valid?
  end

  test "user email should not have a valid format" do
    @user.email = "#{'a'*100}"
    assert_not @user.valid?
  end

  test "user email should be unique" do
    @user.save
    @user2 = User.new(
      username: 'Username', 
      email: 'test1@test.com', 
      password: 'password123',
      admin: false
    )
    assert_not @user2.valid?
  end

end
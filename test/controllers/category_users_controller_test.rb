require 'test_helper'

class CategoryUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get category_users_index_url
    assert_response :success
  end

  test "should get new" do
    get category_users_new_url
    assert_response :success
  end

  test "should get create" do
    get category_users_create_url
    assert_response :success
  end

  test "should get edit" do
    get category_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get category_users_update_url
    assert_response :success
  end

  test "should get show" do
    get category_users_show_url
    assert_response :success
  end

  test "should get delete" do
    get category_users_delete_url
    assert_response :success
  end

end

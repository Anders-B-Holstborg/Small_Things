require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get activities_index_url
    assert_response :success
  end

  test "should get new" do
    get activities_new_url
    assert_response :success
  end

  test "should get create" do
    get activities_create_url
    assert_response :success
  end

  test "should get edit" do
    get activities_edit_url
    assert_response :success
  end

  test "should get update" do
    get activities_update_url
    assert_response :success
  end

  test "should get show" do
    get activities_show_url
    assert_response :success
  end

  test "should get delete" do
    get activities_delete_url
    assert_response :success
  end

end

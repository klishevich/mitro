require 'test_helper'

class PosterClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get poster_clients_index_url
    assert_response :success
  end

  test "should get show" do
    get poster_clients_show_url
    assert_response :success
  end

  test "should get edit" do
    get poster_clients_edit_url
    assert_response :success
  end

  test "should get new" do
    get poster_clients_new_url
    assert_response :success
  end

end

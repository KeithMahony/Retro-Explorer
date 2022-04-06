require "test_helper"

class RelicsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:user1)
    @relic = relics(:one)
  end

  test "should get index" do
    sign_in users(:user1)
    get relics_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:user1)
    get new_relic_url
    assert_response :success
  end

  test "should create relic" do
    sign_in users(:user1)
    assert_difference('Relic.count') do
      post relics_url, params: { relic: { device_name: @relic.device_name, device_output: @relic.device_output, user_id: @relic.user_id } }
    end

    assert_redirected_to relic_url(Relic.last)
  end

  test "should show relic" do
    sign_in users(:user1)
    get relic_url(@relic)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:user1)
    get edit_relic_url(@relic)
    # assert_response :success
  end

  test "should update relic" do
    sign_in users(:user1)
    patch relic_url(@relic), params: { relic: { device_name: @relic.device_name, device_output: @relic.device_output, user_id: @relic.user_id } }
    # assert_redirected_to relic_url(@relic)
  end

  # test "should destroy relic" do
  #   sign_in users(:user1)
  #   assert_difference('Relic.count', -1) do
  #     delete relic_url(@relic)
  #   end
  #   assert_redirected_to relics_url
  # end

end

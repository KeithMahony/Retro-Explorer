require "test_helper"

class RelicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @relic = relics(:one)
  end

  test "should get index" do
    get relics_url
    assert_response :success
  end

  test "should get new" do
    get new_relic_url
    assert_response :success
  end

  test "should create relic" do
    assert_difference('Relic.count') do
      post relics_url, params: { relic: { device_name: @relic.device_name, device_output: @relic.device_output } }
    end

    assert_redirected_to relic_url(Relic.last)
  end

  test "should show relic" do
    get relic_url(@relic)
    assert_response :success
  end

  test "should get edit" do
    get edit_relic_url(@relic)
    assert_response :success
  end

  test "should update relic" do
    patch relic_url(@relic), params: { relic: { device_name: @relic.device_name, device_output: @relic.device_output } }
    assert_redirected_to relic_url(@relic)
  end

  test "should destroy relic" do
    assert_difference('Relic.count', -1) do
      delete relic_url(@relic)
    end

    assert_redirected_to relics_url
  end
end

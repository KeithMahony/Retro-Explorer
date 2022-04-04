require "application_system_test_case"

class RelicsTest < ApplicationSystemTestCase
  setup do
    @relic = relics(:one)
  end

  test "visiting the index" do
    visit relics_url
    assert_selector "h1", text: "Relics"
  end

  test "creating a Relic" do
    visit relics_url
    click_on "New Relic"

    fill_in "Device name", with: @relic.device_name
    fill_in "Device output", with: @relic.device_output
    click_on "Create Relic"

    assert_text "Relic was successfully created"
    click_on "Back"
  end

  test "updating a Relic" do
    visit relics_url
    click_on "Edit", match: :first

    fill_in "Device name", with: @relic.device_name
    fill_in "Device output", with: @relic.device_output
    click_on "Update Relic"

    assert_text "Relic was successfully updated"
    click_on "Back"
  end

  test "destroying a Relic" do
    visit relics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Relic was successfully destroyed"
  end
end

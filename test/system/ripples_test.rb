require "application_system_test_case"

class RipplesTest < ApplicationSystemTestCase
  setup do
    @ripple = ripples(:fix_1)
  end

  test "visiting the index" do
    visit ripples_url
    assert_selector "h1", text: "CONSCIOUS/mess"
  end

  test "creating a Ripple" do
    visit ripples_url
    click_on "New Ripple"

    save_and_open_page
    fill_in "ripple_message", with: @ripple.message
    fill_in "ripple_name", with: @ripple.name
    fill_in "ripple_url", with: @ripple.url
    click_on "Create Ripple"

    assert_text "Ripple was successfully created"
  end

  test "updating a Ripple" do
#    visit ripples_url
#    click_on "Edit", match: :first

#    fill_in "Message", with: @ripple.message
#    fill_in "Name", with: @ripple.name
#    fill_in "Url", with: @ripple.url
#    click_on "Update Ripple"

#    assert_text "Ripple was successfully updated"
#    click_on "Back"
  end

  test "destroying a Ripple" do
#    visit ripples_url
#    page.accept_confirm do
#      click_on "Destroy", match: :first
#    end

#    assert_text "Ripple was successfully destroyed"
  end
end

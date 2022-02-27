require "test_helper"

class RipplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ripple = ripples(:fix_1)
  end

  test "should move forward and move newest" do
    get '/ripples'

    get '/next'
    assert_response :success
    assert_select "p#message", text: "MyString_92"

    get '/newest'
    assert_response :success
    assert_select "p#message", text: "MyString_102"

  end

  test "should go oldest and move back 10" do
    get '/ripples'

    get '/oldest'
    assert_response :success
    assert_select "p#message", text: "MyString_2"

    get '/previous'
    assert_response :success
    assert_select "p#message", text: "MyString_12"
  end

  test "should get index" do
    get ripples_url
    assert_response :success
  end

  test "should get new" do
    get new_ripple_url
    assert_response :success
  end

  test "should create ripple" do
    assert_difference('Ripple.count') do
      post ripples_url, params: { ripple: { message: @ripple.message, name: @ripple.name, url: @ripple.url } }
    end

    assert_redirected_to ripples_url
  end

  test "should show ripple" do
    get ripple_url(@ripple)
    assert_response :success
  end

  test "should get edit" do
#    get edit_ripple_url(@ripple)
#    assert_response :success
  end

  test "should update ripple" do
    patch ripple_url(@ripple), params: { ripple: { message: @ripple.message, name: @ripple.name, url: @ripple.url } }
    assert_redirected_to ripple_url(@ripple)
  end

  test "should destroy ripple" do
#    assert_difference('Ripple.count', -1) do
#      delete ripple_url(@ripple)
#    end

#    assert_redirected_to ripples_url
  end
end

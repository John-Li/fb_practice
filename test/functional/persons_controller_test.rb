require 'test_helper'

class PersonsControllerTest < ActionController::TestCase
  test "should get add_person" do
    get :add_person
    assert_response :success
  end

end

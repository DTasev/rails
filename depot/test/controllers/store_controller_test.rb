require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select '#columns #side li', minumum: 4

    # assert the table has 3 entries (current have 3 entries in product.yml)
    assert_select '#main .entry', 3

    # assert that the table contains this specific book
    assert_select 'h3', 'Programming Ruby 1.9'

    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end

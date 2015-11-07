require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_items = Item.count
    get :index, format: :json
    json_response = JSON.parse(response.body)
    assert_equal number_of_items, json_response.count
  end

  test "#show" do
    item = items(:one)
    get :show, id: item.id, format: :json
    assert_response :success
  end

  test "#show returns the right info" do
    item = items(:two)
    get :show, id: item.id, format: :json
    json_response 
    assert_equal "MyString", json_response["descriptions"]
  end

  test "#create, ummm, creates a new item" do
    new_item ={ name: "Cool item pizza",
        descriptions: "yumyumyum" }

    post :create, format: :json, item: new_item
    assert_response :created
  end

  test "#udpate an item" do
    item = items(:one)
    updated_item ={ name: "Cool item pizza", descriptions: "yumyumyum" }

    put :update, id: item.id, item: updated_item, format: :json
    assert_response :no_content
  end

  def json_response
    JSON.parse(response.body)
  end
end

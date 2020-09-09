require 'test_helper'

class IdeologiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ideology = ideologies(:one)
  end

  test "should get index" do
    get ideologies_url, as: :json
    assert_response :success
  end

  test "should create ideology" do
    assert_difference('Ideology.count') do
      post ideologies_url, params: { ideology: { definition: @ideology.definition, definition_source: @ideology.definition_source, diplomatic_effect: @ideology.diplomatic_effect, economic_effect: @ideology.economic_effect, government_effect: @ideology.government_effect, name: @ideology.name, societal_effect: @ideology.societal_effect } }, as: :json
    end

    assert_response 201
  end

  test "should show ideology" do
    get ideology_url(@ideology), as: :json
    assert_response :success
  end

  test "should update ideology" do
    patch ideology_url(@ideology), params: { ideology: { definition: @ideology.definition, definition_source: @ideology.definition_source, diplomatic_effect: @ideology.diplomatic_effect, economic_effect: @ideology.economic_effect, government_effect: @ideology.government_effect, name: @ideology.name, societal_effect: @ideology.societal_effect } }, as: :json
    assert_response 200
  end

  test "should destroy ideology" do
    assert_difference('Ideology.count', -1) do
      delete ideology_url(@ideology), as: :json
    end

    assert_response 204
  end
end

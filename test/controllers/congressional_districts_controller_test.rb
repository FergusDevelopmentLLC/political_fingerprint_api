require 'test_helper'

class CongressionalDistrictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @congressional_district = congressional_districts(:one)
  end

  test "should get index" do
    get congressional_districts_url, as: :json
    assert_response :success
  end

  test "should create congressional_district" do
    assert_difference('CongressionalDistrict.count') do
      post congressional_districts_url, params: { congressional_district: { geoid: @congressional_district.geoid, latitude: @congressional_district.latitude, longitude: @congressional_district.longitude, name: @congressional_district.name } }, as: :json
    end

    assert_response 201
  end

  test "should show congressional_district" do
    get congressional_district_url(@congressional_district), as: :json
    assert_response :success
  end

  test "should update congressional_district" do
    patch congressional_district_url(@congressional_district), params: { congressional_district: { geoid: @congressional_district.geoid, latitude: @congressional_district.latitude, longitude: @congressional_district.longitude, name: @congressional_district.name } }, as: :json
    assert_response 200
  end

  test "should destroy congressional_district" do
    assert_difference('CongressionalDistrict.count', -1) do
      delete congressional_district_url(@congressional_district), as: :json
    end

    assert_response 204
  end
end

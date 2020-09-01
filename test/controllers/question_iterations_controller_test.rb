require 'test_helper'

class QuestionIterationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_iteration = question_iterations(:one)
  end

  test "should get index" do
    get question_iterations_url, as: :json
    assert_response :success
  end

  test "should create question_iteration" do
    assert_difference('QuestionIteration.count') do
      post question_iterations_url, params: { question_iteration: { content: @question_iteration.content, question_id: @question_iteration.question_id, version: @question_iteration.version } }, as: :json
    end

    assert_response 201
  end

  test "should show question_iteration" do
    get question_iteration_url(@question_iteration), as: :json
    assert_response :success
  end

  test "should update question_iteration" do
    patch question_iteration_url(@question_iteration), params: { question_iteration: { content: @question_iteration.content, question_id: @question_iteration.question_id, version: @question_iteration.version } }, as: :json
    assert_response 200
  end

  test "should destroy question_iteration" do
    assert_difference('QuestionIteration.count', -1) do
      delete question_iteration_url(@question_iteration), as: :json
    end

    assert_response 204
  end
end

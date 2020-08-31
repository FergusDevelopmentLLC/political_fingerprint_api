require 'test_helper'

class QuestionResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_response = question_responses(:one)
  end

  test "should get index" do
    get question_responses_url, as: :json
    assert_response :success
  end

  test "should create question_response" do
    assert_difference('QuestionResponse.count') do
      post question_responses_url, params: { question_response: { delete_question: @question_response.delete_question, explanation: @question_response.explanation, question_iteration_id: @question_response.question_iteration_id, score: @question_response.score } }, as: :json
    end

    assert_response 201
  end

  test "should show question_response" do
    get question_response_url(@question_response), as: :json
    assert_response :success
  end

  test "should update question_response" do
    patch question_response_url(@question_response), params: { question_response: { delete_question: @question_response.delete_question, explanation: @question_response.explanation, question_iteration_id: @question_response.question_iteration_id, score: @question_response.score } }, as: :json
    assert_response 200
  end

  test "should destroy question_response" do
    assert_difference('QuestionResponse.count', -1) do
      delete question_response_url(@question_response), as: :json
    end

    assert_response 204
  end
end

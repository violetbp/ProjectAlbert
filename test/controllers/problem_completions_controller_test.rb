require 'test_helper'

class ProblemCompletionsControllerTest < ActionController::TestCase
  setup do
    @problem_completion = problem_completions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:problem_completions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create problem_completion" do
    assert_difference('ProblemCompletion.count') do
      post :create, problem_completion: { attempt: @problem_completion.attempt, previousOutput: @problem_completion.previousOutput, problemname: @problem_completion.problemname, score: @problem_completion.score, username: @problem_completion.username }
    end

    assert_redirected_to problem_completion_path(assigns(:problem_completion))
  end

  test "should show problem_completion" do
    get :show, id: @problem_completion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @problem_completion
    assert_response :success
  end

  test "should update problem_completion" do
    patch :update, id: @problem_completion, problem_completion: { attempt: @problem_completion.attempt, previousOutput: @problem_completion.previousOutput, problemname: @problem_completion.problemname, score: @problem_completion.score, username: @problem_completion.username }
    assert_redirected_to problem_completion_path(assigns(:problem_completion))
  end

  test "should destroy problem_completion" do
    assert_difference('ProblemCompletion.count', -1) do
      delete :destroy, id: @problem_completion
    end

    assert_redirected_to problem_completions_path
  end
end

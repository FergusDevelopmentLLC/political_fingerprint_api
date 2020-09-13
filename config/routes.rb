Rails.application.routes.draw do
  resources :test_results
  resources :ideologies
  resources :question_feedbacks

  resources :categories do
    resources :questions do
      resources :question_iterations do
        resources :question_feedbacks
      end
    end
  end
  resources :questions do
    resources :question_iterations do
      resources :question_feedbacks
    end
  end

  get 'questions/by_version/:version', to: 'questions#by_version'
end

Rails.application.routes.draw do
  resources :categories do
    resources :questions do
      resources :question_iterations do
        resources :question_responses
      end
    end
  end
  resources :questions do
    resources :question_iterations do
      resources :question_responses
    end
  end
end

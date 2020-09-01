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

  1

  get 'questions/by_version/:version', to: 'questions#by_version'

end

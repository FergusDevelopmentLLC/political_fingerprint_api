Rails.application.routes.draw do
  
  resources :ideologies
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

  get 'questions/by_version/:version', to: 'questions#by_version'

end

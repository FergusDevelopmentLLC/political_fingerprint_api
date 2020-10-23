Rails.application.routes.draw do
  resources :cities
  resources :counties
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

  get '/', to: 'application#welcome'

  get '/test_results_averaged', to: 'test_results#averaged_by_county'

  get 'questions/by_version/:version', to: 'questions#by_version'

  get 'test_results_fake/:limit', to: 'test_results#fake'

  get 'test_result_ideology/:economic/:diplomatic/:civil/:societal', to: 'test_results#get_ideology_matches', constraints: { 
    :economic => /[^\/]+/, 
    :diplomatic => /[^\/]+/,
    :civil => /[^\/]+/,
    :societal => /[^\/]+/,
  }

  patch 'test_results_check', to: 'test_results#test_results_check'

end

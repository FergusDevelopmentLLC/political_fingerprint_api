Rails.application.routes.draw do
  resources :question_responses
  resources :responses
  resources :questions
  resources :question_iterations
  resources :comments
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

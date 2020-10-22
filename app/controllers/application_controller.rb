class ApplicationController < ActionController::API
    def welcome
        render json: "Welcome  to the Politipoint API"
    end
end

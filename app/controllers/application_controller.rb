class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :checked_account
  after_filter :response_allow_origin

  private
    def response_allow_origin
      response.headers['Access-Control-Allow-Origin'] = "*"
    end

    def checked_account
      account = Account.new(:session_token => session_token)
      unless account.authenticate
        redirect_to :login
      end
    end

    def session_token
      params[:session_token] || session[:session_token]
    end
end

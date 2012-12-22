class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :response_allow_origin

  private
    def response_allow_origin
      response.headers['Access-Control-Allow-Origin'] = "*"
    end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "and here we now...again"
  end
end

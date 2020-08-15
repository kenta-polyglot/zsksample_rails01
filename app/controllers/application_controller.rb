class ApplicationController < ActionController::Base
  def hello
    render html: 'hello'
  end
end

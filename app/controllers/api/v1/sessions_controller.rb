class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(username: user_credentials[:username])

    if user && user.authenticate(user_credentials[:password])
      render json: UserSerializer.successful_login(user)
    else
      render json: UserSerializer.unsuccessful_login, status: 400
    end
  end

  private
  def user_credentials
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
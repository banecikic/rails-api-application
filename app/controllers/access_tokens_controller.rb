class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create

  def create
    authenticator = UserAuthenticator.new(params[:code])
    authenticator.perform

    json_token = AccessTokenSerializer.new(authenticator.access_token).serializable_hash.to_json

    render json: json_token, status: :created
  end

  def destroy
    current_user.access_token.destroy
  end
end

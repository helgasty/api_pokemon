module Api
  module V1
    class AuthController < ApplicationController

      include Devise::Controllers::Helpers
      skip_before_action :authenticate_user!

      def login
        if params.has_key?(:user) && params[:user].has_key?(:login) && params[:user].has_key?(:password)

          user = User.find_by_login(params[:user][:login])

          unless user.nil?
            if user.valid_password?(params[:user][:password])
              sign_in(:user, user)
              render json: { status: 'OK', message: t('api.login.login_success'), token: JsonWebToken.encode(user_id: user.id) },  status: 200
            else
              render json: { status: 'KO', message: t('api.login.password_failed')}, status: 403
            end
          else
            render json: { status: 'KO', message: t('api.login.login_failed')}, status: 403
          end
        else
          render json: { status: 'KO', message: t('api.login.bad_request')}, status: 403
        end
      end
    end
  end
end

require 'rails_helper'
require 'devise'

RSpec.describe Api::V1::AuthController, type: :controller do

  describe "check login" do
    user = create(:user, :admin)

    it "login success" do
      post :login, params: { user: { login: user.login, password: user.password } }
      expect(response).to have_http_status(200)
    end

    it "login error" do
      post :login, params: { user: { login: user.login, password: FFaker::Internet.password } }
      expect(response).to have_http_status(403)
    end

    it "login timeout" do
      post :login, params: { user: { login: user.login, password: FFaker::Internet.password } }
      sleep(10)
      expect(response).to have_http_status(403)
    end
  end
end
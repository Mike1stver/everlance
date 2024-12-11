require 'rails_helper'

RSpec.describe "RegistrationsController", type: :request do
  fixtures :users

  describe "POST registrations" do
    let(:valid_user_params) do
      {
        user: {
          email: "newuser@example.com",
          password: "securepassword",
          password_confirmation: "securepassword"
        }
      }
    end

    let(:duplicated_user_params) do
      {
        user: {
          email: users(:valid_user).email,
          password: "securepassword",
          password_confirmation: "securepassword"
        }
      }
    end

    context "when there is a valid parameters" do
      it "creates a new user, return success and the user created" do
        expect {
          post '/registrations', params: valid_user_params
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body["email"]).to eq(valid_user_params[:user][:email])
      end
    end

    context "when there is a invalid user" do
      it "do not create user adn returns error" do
        expect {
          post '/registrations', params: duplicated_user_params
        }.not_to change(User, :count)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
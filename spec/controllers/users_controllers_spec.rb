require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    { email: "user@example.com", password: "password123", name: "John Doe", profile_id: profile.id, status: 0 }
  }

  let(:invalid_attributes) {
    { email: nil, password: nil }
  }

  let!(:profile) { Profile.create!(name: "Admin", description: "Administrator profile") }
  let!(:user) { User.create!(valid_attributes) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.location).to eq(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  # Similar tests for update and destroy actions
end

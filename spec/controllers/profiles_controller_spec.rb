require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:valid_attributes) {
    { name: "Admin", description: "Administrator profile" }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  let!(:profile) { Profile.create!(valid_attributes) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: profile.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Profile" do
        expect {
          post :create, params: { profile: valid_attributes }
        }.to change(Profile, :count).by(1)
      end

      it "renders a JSON response with the new profile" do
        post :create, params: { profile: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.location).to eq(profile_url(Profile.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new profile" do
        post :create, params: { profile: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  # Similar tests for update and destroy actions
end

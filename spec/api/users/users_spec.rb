require "rails_helper"

RSpec.describe "Users API", type: :request do
    let!(:users) { create_list(:user, 10) }
    let(:user_id) { users.first.id }

    describe "GET /users" do
        before { get '/api/v1/users' }

        it "returns users" do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end 

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /users/:id" do
        before { get "/api/v1/users/#{user_id}" }

        context "when the record exists" do
            it "returns the user" do
                expect(json).not_to be_empty
                expect(json["id"]).to eq(user_id)
            end

            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
        end

        context "when the record does not exist" do
            let(:user_id) { 100 }

            it "returns status code 404" do
                expect(response).to have_http_status(404)
            end
        end
    end

    describe "POST /users" do
        let(:valid_attributes) { { username: "johndoe", email: "john@example", phone_no: "0123456789" } }

        context "when the request is valid" do
            before { post "/api/v1/users", params: valid_attributes }

            it "creates a user" do
                expect(json["username"]).to eq("johndoe")
            end

            it "returns status code 201" do
                expect(response).to have_http_status(201)
            end
        end
    end

    describe "PUT /users/:id" do
        let(:valid_attributes) { { username: "johndoe" } }

        before { put "/api/v1/users/#{user_id}", params: valid_attributes }

        context "when the record exists" do
            it "updates the record" do
                expect(json["username"]).to eq("johndoe")
            end

            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end 
        end
    end

    describe "DELETE /users/:id" do
        before { delete "/api/v1/users/#{user_id}" }

        it "returns status code 204" do
            expect(response).to have_http_status(204)
        end
    end
end
require "rails_helper"

RSpec.describe "Posts API", type: :request do
    let!(:users) { create_list(:user, 5) }
    let!(:posts) { create_list(:post, 10) }
    let(:post_id) { posts.first.id }
    let(:user_id) { users.first.id }


    describe "GET /posts" do
        before { get '/api/v1/posts' }

        it "returns posts" do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /posts/:id" do
        before { get "/api/v1/posts/#{post_id}" }

        context "when the record exists" do
            it "returns the post" do
                expect(json).not_to be_empty
                expect(json["id"]).to eq(post_id)
            end

            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
            
        end

        context "when the record does not exist" do
            let(:post_id) { 100 }

            it "returns status code 404" do
                expect(response).to have_http_status(404)
            end

            it "returns a not found message" do
                expect(response.body).to match(/Couldn't find Post/)
            end
        end
    end

    describe "POST /posts" do
        let(:valid_attributes) { { user_id: user_id, description: "Lorem ipsum dolor sit amet" } }

        context "when the request is valid" do
            before { post "/api/v1/posts", params: valid_attributes }

            it "creates a post" do
                expect(json["description"]).to eq("Lorem ipsum dolor sit amet")
            end

            it "returns status code 201" do
                expect(response).to have_http_status(201)
            end
        end
    end

    describe "PUT /posts/:id" do
        let(:valid_attributes) { { description: "Lorem ipsum dolor sit amet" } }

        before { put "/api/v1/posts/#{post_id}", params: valid_attributes } 

        context "when the record exists" do
            it "updates the record" do
                expect(json["description"]).to eq("Lorem ipsum dolor sit amet")
            end

            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
        end
    end

    describe "DELETE /posts/:id" do
        before { delete "/api/v1/posts/#{post_id}" }

        it "returns status code 204" do
            expect(response).to have_http_status(204)
        end
    end
end
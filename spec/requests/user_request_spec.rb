# require "rails_helper"
# require "factories/users"
# RSpec.describe "Users", type: :request do
#   describe "request list of Courses " do
#     let!(:users) { FactoryBot.create_list :user, 2 }

#     it "returns a success response" do
#       get "/users/"
#       expect(response).to be_success
#     end
#     it "assigns @users" do
#       get "/users/"
#       expect(assigns(:users)).to eq(users)
#     end
#     it "renders the index template" do
#       get "/users/"
#       expect(response).to render_template(:index)
#     end
#   end
# end

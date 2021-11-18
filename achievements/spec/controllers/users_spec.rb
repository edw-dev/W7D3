require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:bob){
    User.create!(
      username: 'Bob',
      password: 'password'
    )
  }

  describe "GET /index" do
    it "renders index" do
      get :index
      expect(response).to render_template("index")
    end
  end
  describe "GET /show" do
    it "shows" do
      get :show, params:{id:bob.id}
      expect(response).to render_template("show")
    end
  end

  describe "POST /create" do
    context "valid params" do
      it "redirects to user: show" do
        post :create, params: {
          user: {
            username: "bob",
            password: "passer"
          }
        }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
    context "INvalid params" do
      it "redirects to user: new" do
        post :create, params: {
          user: {
            username: "bob",
            password: "yer"
          }
        }
        expect(response).to render_template("new")
      end
    end
  end

end

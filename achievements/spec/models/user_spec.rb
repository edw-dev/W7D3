require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_length_of(:password).is_at_least(6)}

  describe "user.find_by_credentials" do
    context "with valid credentials" do
      it "should return the user" do

          User.create!(
            username: 'Bob',
            password: 'password'
          )

        expect(User.find_by_credentials('Bob','password')).to eq(:bob)
      end
    end
    context "with invalid credentials" do

        User.create!(
          username: 'Bob',
          password: 'password'
        )
      it "should return nil" do
        expect(User.find_by_credentials('Blah', 'password')).to eq(nil)
      end
    end
  end

end

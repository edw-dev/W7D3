require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_length_of(:password).is_at_least(6)}
  subject(:bob){
    User.create!(
      username: 'Bob',
      password: 'password'
    )
  }
  describe "password encrypted?" do
    it "sets password" do
      expect(bob.password).to eq('password')
    end
    it "sets digest" do
      expect(bob.password_digest).to_not eq(nil)
    end
  end
  describe "user.find_by_credentials" do
    context "with valid credentials" do
      it "should return the user" do
        expect(User.find_by_credentials('Bob','password')).to eq(bob.username)
      end
    end
    context "with invalid credentials" do
      it "should return nil" do
        expect(User.find_by_credentials('Blah', 'password')).to eq(nil)
      end
    end
  end
  describe "is_password?" do
    it "should check if password is correct" do
      expect(bob.is_password?('password')).to be true
    end
    it "should check if password is false" do
      expect(bob.is_password?('yerrr')).to be false
    end
  end
  describe "ensure_session_token" do
    it "token ensured" do
      expect(bob.session_token).to_not eq(nil)
    end
  end
  describe "reset sesh" do
    it "resets sesh" do
      temp=bob.session_token
      expect(bob.reset_session_token).to_not eq(temp)
    end

  end
end

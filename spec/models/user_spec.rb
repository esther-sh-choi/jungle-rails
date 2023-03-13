# rails g rspec:model user

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "user saves when all fields are provided" do
      @user = User.new(name: "Esther", email: "esther@email.com", password: 'password', password_confirmation: 'password')
      expect(@user).to be_valid
    end

    it "user doesn't save when passwords do not match" do
      @user = User.new(name: "Esther", email: "esther@email.com", password: 'password', password_confirmation: 'password234')
      expect(@user).to_not be_valid
    end

    it "user doesn't save when name is nil" do
      @user = User.new(email: "esther@email.com", password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it "user doesn't save when email is nil" do
      @user = User.new(name: "Esther", password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it "user doesn't save when password is nil" do
      @user = User.new(name: "Esther", email: "esther@email.com", password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it "user doesn't save when password confirmation is nil" do
      @user = User.new(name: "Esther", email: "esther@email.com", password: 'password')
      expect(@user).to_not be_valid
    end

    it "user doesn't save if the email already exists" do
      @user1 = User.create(name: "Esther", email: "esther@email.com", password: 'password', password_confirmation: 'password')
      @user2 = User.new(name: "Esther", email: "esther@email.com", password: 'password', password_confirmation: 'password')

      expect(@user2).to_not be_valid
    end

    it "user doesn't save when password length is shorter than the minimum length" do
      @user = User.new(name: "Esther", email: "esther@email.com", password: 'passwor', password_confirmation: 'passwor')
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(name: "Esther", email: "esther@email.com", password: 'password', password_confirmation: 'password')
    end

    it "user authentication successful when all fields are correct" do
      @authenticatedUser = User.authenticate_with_credentials("esther@email.com", "password")
      expect(@authenticatedUser).to_not be(nil)
    end

    it "user authentication returns nil if email is not provided" do
      @authenticatedUser = User.authenticate_with_credentials("", "password")
      expect(@authenticatedUser).to be(nil)
    end

    it "user authentication returns nil if password is not provided" do
      @authenticatedUser = User.authenticate_with_credentials("esther@email.com", "")
      expect(@authenticatedUser).to be(nil)
    end

    it "user authentication returns nil if wrong email is provided" do
      @authenticatedUser = User.authenticate_with_credentials("esthe@email.com", "password")
      expect(@authenticatedUser).to be(nil)
    end

    it "user authentication returns nil if wrong password is provided" do
      @authenticatedUser = User.authenticate_with_credentials("esther@email.com", "password1")
      expect(@authenticatedUser).to be(nil)
    end

    it "user authentication successful even if visitor types few space before and/or after email address " do
      @authenticatedUser = User.authenticate_with_credentials(" esther@email.com    ", "password")
      expect(@authenticatedUser).to_not be(nil)
    end

    it "user authentication successful even if visitor types the wrong case for the email address " do
      @authenticatedUser = User.authenticate_with_credentials("eStHeR@eMAil.cOm", "password")
      expect(@authenticatedUser).to_not be(nil)
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Registration' do 
    it 'must ensure the password and password confirmation fields are used' do 
      @user = User.new(name: "Bob", first_name: "Bob", last_name: "Smith", email: "bob@smith.com", password: '12345678', password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")   
    end

    it 'must ensure password and password confirmation match' do 
      @user = User.new(name: "Bob", first_name: "Bob", last_name: "Smith", email: "bob@smith.com", password: '12345678', password_confirmation: '9101112')
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")     
    end

    it 'must ensure the email is unique, and not already in the db' do 
      @user = User.new(name: "Bob", first_name: "Bob", last_name: "Smith", email: "bob@smith.com", password: '12345678', password_confirmation: '12345678')
      @user.save
      expect(@user.errors.full_messages).to include("Email is already in use")
    end

    it 'must ensure that email is required' do 
      @user = User.new(name: "Bob", first_name: "Bob", last_name: "Smith", email: nil, password: '12345678', password_confirmation: '12345678')
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")      
    end

    it 'must ensure that first name is required' do 
      @user = User.new(name: "Bob", first_name: nil, last_name: "Smith", email: "bob@smith.com", password: '12345678', password_confirmation: '12345678')
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")      
    end

    it 'must ensure that last name is required' do 
      @user = User.new(name: "Bob", first_name: nil, last_name: nil, email: "bob@smith.com", password: '12345678', password_confirmation: '12345678')
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")      
    end

    it 'must ensure that the password has a character length of 8' do  
      @user = User.new(name: "Bob", first_name: "Bob", last_name: "Smith", email: "bob@smith.com", password: '1234', password_confirmation: '1234')
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)") 
    end
  end

  describe '.authenticate_with_credentials' do 
    it 'must ensure the right password is entered' do 
      @user = User.new(name: "Sam", first_name: "Sam", last_name: "Smith", email: "sam@smith.com", password: '12345678', password_confirmation: '12345678')
      @user.save
      incorrect_credentials = User.authenticate_with_credentials("sam@smith.com", "87654321")
      expect(@user).not_to be(incorrect_credentials)
    end

    it 'must standardize the case of the email before testing authentication' do 
      @user = User.new(name: "Sam", first_name: "Sam", last_name: "Smith", email: "sam@smith.com", password: '12345678', password_confirmation: '12345678')
      @user.save
      user_email_misformatted = User.authenticate_with_credentials(" sAm@sMith.com  ", "12345678")
      expect(@user).to eq(user_email_misformatted)
    end

    it 'must standardize the spaces around the email before testing authentication' do 
      @user = User.new(name: "Sam", first_name: "Sam", last_name: "Smith", email: "sam@smith.com", password: '12345678', password_confirmation: '12345678')
      @user.save
      user_email_misformatted = User.authenticate_with_credentials(" sam@smith.com  ", "12345678")
      expect(@user).to eq(user_email_misformatted)
    end
  end
end

# INSERT INTO users (name, email, first_name, last_name, password_digest, created_at, updated_at) VALUES ('Bob', 'bob@smith.com', 'Bob', 'Smith', '$2a$04DCE^ZuPqY6r0TvzMgjR7quN8u.mnjFdJsaM4dmU4j6xc/lqHsE3lK', 'July 17, 2024', 'July 17, 2024');

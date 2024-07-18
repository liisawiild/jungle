class User < ApplicationRecord
  has_secure_password
  validate :passwords_match?
  validate :new_email?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: {minimum: 8}
  validates :password_confirmation, presence: true

  def passwords_match?
    password == password_confirmation
  end

  def new_email?
    if (User.find_by(email: email))
      errors.add(:email, "is already in use")
    end
  end
  
  def self.authenticate_with_credentials(email, password)
    user_email = email.strip.downcase
    # find the user details by email
    user = User.find_by_email(user_email)
    # If the user exists AND the password entered is correct...
    if (user && user.authenticate(password))
      user
    else
      nil
    end
  end

end

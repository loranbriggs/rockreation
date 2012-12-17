class User < ActiveRecord::Base
  ROLES = %w[admin employee client]
  attr_accessible :email, :fname, :lname, :number, :password, :password_confirmation, :role
  has_many :xref_user_reservations

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :number
  validates_presence_of :fname
  validates_presence_of :lname
  validates_presence_of :role

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end

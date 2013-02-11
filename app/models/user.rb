class User < ActiveRecord::Base
  ROLES = %w[admin employee client]
  DETAIL = %w[desk belayer instructor manager team customer]

  attr_accessible :email, :fname, :lname, :phone, :street1, :street2, :city,
    :state, :postcode, :password, :password_confirmation,
    :role, :detail, :membership, :note
  has_many :events
  has_many :shifts

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password, :on => :create
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :phone
  validates_presence_of :street1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :postcode
  validates_presence_of :fname
  validates_presence_of :lname
  validates_presence_of :role
  validates_presence_of :detail

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

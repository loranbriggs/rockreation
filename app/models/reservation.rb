class Reservation < ActiveRecord::Base
  PARTICIPANTS = %w[5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95]
  attr_accessible :date, :name, :participants
  has_many :xref_user_reservations

  validates_presence_of :name
  validates_presence_of :participants
  validates_presence_of :date
  validates_date :date, :on => :create, :after => :today, :after_message => 'must be after today'

end

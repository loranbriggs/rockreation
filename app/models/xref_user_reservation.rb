class XrefUserReservation < ActiveRecord::Base
  attr_accessible :host, :reservation_id, :user_id, :drop_shift

  belongs_to :user
  belongs_to :reservation

  validates_presence_of :reservation_id
end

class Seat < ActiveRecord::Base
  attr_accessible :drop, :user_id, :event_id
  
  belongs_to :user
  belongs_to :event
  
  validates_presence_of :event_id
end

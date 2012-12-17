class XrefUserEvent < ActiveRecord::Base
  attr_accessible :event_id, :host, :user_id

  belongs_to :user
  belongs_to :event

  validates_presence_of :event_id
end

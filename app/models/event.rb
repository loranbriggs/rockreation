class Event < ActiveRecord::Base
  PARTICIPANTS = %w[5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95]
  LOCATION = %w[Los_Angeles Costa_Mesa]
  AGE_GROUP = %w[5-12 12-18 18+ All_Ages]
  TYPE = %w[Party Kids_Climb Climb_Time Class Yoga Other(Specify_In_Notes)]
  PARTY_DETAIL = %w[Birthday Teambuilding Youth_Program Merit_Badge Fight_Gravity_One Other(Specify_In_Notes)]
  All_DETAIL = %w[Birthday Teambuilding Youth_Program Meritit_Badge Fight_Gravity_One Fight_Gravity_Two Fight_Gravity_Three Lead Other(Specify_In_Notes)]
  
  attr_accessible :date, :name, :participants, :event_type, :detail, :note, :ageGroup, :location,
    :cancellation_policy, :parking_policy, :liability_policy, :attendees_policy
  has_many :shifts
  has_many :seats
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :date
  validates_presence_of :participants
  validates_presence_of :event_type
  validates_presence_of :detail
  validates_presence_of :ageGroup
  validates_presence_of :location
  validates_acceptance_of :cancellation_policy
  validates_acceptance_of :parking_policy
  validates_acceptance_of :liability_policy
  validates_acceptance_of :attendees_policy

end

class Event < ActiveRecord::Base
  PARTICIPANTS = %w[5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95]
  DURATION =%w[60 90 120 180 240 270 300]
  HOUR_DURATION = %w[1 2 3 4]
  MIN_DURATION = %w[0 30]
  LOCATION = %w[Los_Angeles Costa_Mesa]
  AGE_GROUP = %w[5-12 12-18 18+ All_Ages]
  TYPE = %w[Party Kids_Climb Climb_Time Class Yoga Other(Specify_In_Notes)]
  PARTY_DETAIL = %w[Birthday Teambuilding Youth_Program Merit_Badge Fight_Gravity_One Other(Specify_In_Notes)]
  All_DETAIL = %w[Birthday Teambuilding Youth_Program Meritit_Badge Fight_Gravity_One Fight_Gravity_Two Fight_Gravity_Three Lead Other(Specify_In_Notes)]
  
  attr_accessible :date, :name, :participants, :event_type, :detail, :note, :ageGroup, :location,
    :cancellation_policy, :parking_policy, :liability_policy, :attendees_policy, :duration
  attr_accessor :validate_date
  has_many :shifts
  has_many :seats
  belongs_to :user
  
  validates_presence_of :name
  validates_presence_of :date
  validates_date :date, :on => :create, :after => lambda { 1.week.from_now }, 
    :after_message => 'must be a week away, call 310-207-7199 or email our
      special event manager Colin at colin@rockreation.com to arrange otherwise.',
      :if => :should_validate_password?
  validates_presence_of :participants
  validates_presence_of :event_type
  validates_presence_of :detail
  validates_presence_of :ageGroup
  validates_presence_of :location
  validates_acceptance_of :cancellation_policy
  validates_acceptance_of :parking_policy
  validates_acceptance_of :liability_policy
  validates_acceptance_of :attendees_policy

  def should_validate_password?
    validate_date
  end
  
end

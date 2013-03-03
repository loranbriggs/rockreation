class Event < ActiveRecord::Base
  #TIMES = %w[10:30 12:00 14:30 17:00 19:30]
  TIMES = { '10:30' => '10:30', '12:00' => '12:00', '14:30' => '2:30', '17:00' => '5:00', '19:30' => '7:30'}
  PARTICIPANTS = { '10' => '5-10', '15' => '11-15', '20' => '16-20', '25' => '21-25', '30' => '26-30'}
  DURATION =%w[60 90 120 180 240 270 300]
  HOUR_DURATION = %w[1 2 3 4]
  MIN_DURATION = %w[0 30]
  LOCATION = %w[Los_Angeles Costa_Mesa]
  AGE_GROUP = %w[5-12 12-18 18+ All_Ages]
  TYPE = %w[Party Kids_Climb Climb_Time Class Yoga Other(Specify_In_Notes)]
  PARTY_DETAIL = %w[Birthday Teambuilding Youth_Program Merit_Badge Fight_Gravity_One Other(Specify_In_Notes)]
  All_DETAIL = %w[Birthday Teambuilding Youth_Program Meritit_Badge Fight_Gravity_One Fight_Gravity_Two Fight_Gravity_Three Lead Other(Specify_In_Notes)]
  
  attr_accessible :date, :name, :participants, :event_type, :detail, :note, :ageGroup, :location,
    :cancellation_policy, :parking_policy, :liability_policy, :attendees_policy, :duration, :time
  attr_accessor :validate_date, :time
  has_many :shifts
  has_many :seats
  belongs_to :user
  
  before_save :convert_time
  
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
  
  def convert_time
    dateString = date.to_s
    dateTime = dateString[0,4] + '-' + dateString[5,2] + '-' + dateString[8,2] + ' ' + time[0,2] + ':' + time[3,2] + ':00'
    self.date = Time.zone.parse(dateTime)
  end
  
end

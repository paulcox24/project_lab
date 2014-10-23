class Project < ActiveRecord::Base
  has_many :tasks
  has_many :project_members
  has_many :users, -> {distinct}, through: :project_members
  has_many :attachments
  belongs_to  :creator, class_name: "User", foreign_key: 'user_id'

  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :project_members, reject_if: :all_blank, allow_destroy: true

  validates :creator, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 50, 
                                    message: 'description must be more than 50 characters'}
  validate :past_due_date

  before_create :add_creator_as_project_member

  def past_due_date
    if due_date_at <=  Time.now
      errors.add(:due_date_at, "can't be in the past")
    end
  end

  def members
    self.users
  end

  def percent_complete
    100.0 * (self.tasks.completed.count / self.tasks.count.to_f)
  end

  private

  def add_creator_as_project_member
    self.users << self.creator
  end
end
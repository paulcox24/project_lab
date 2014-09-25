class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :project_members, dependent: :destroy
  has_many :projects, through: :project_members
  has_many :tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :name, presence: true
  validate :name_is_not_test
  validates :phone, numericality: { greater_than: 0 }, length: { is: 10 }

  def delete_task(task)
    task_to_delete = self.tasks.find_by(id: task.id)
    task_to_delete.destroy if task_to_delete
  end

  private
  def name_is_not_test
    errors.add(:name, 'cannot be test') if self.name == 'test'
  end
end

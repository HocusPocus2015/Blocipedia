class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  validates :user, presence: true
  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 20 }
  # validates :topic, presence: true

  scope :visible_to, -> (user) { user.role == 'admin' || user.role == 'premium' ? all : where(private: false) }
end

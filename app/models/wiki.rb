class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 20 }
  # validates :topic, presence: true

  scope :visible_to, -> (user) { user ? all : where(public: true) }
end

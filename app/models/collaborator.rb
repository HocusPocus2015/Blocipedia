class Collaborator < ActiveRecord::Base

  belongs_to :user
  belongs_to :wiki

  delegate :email, to: :user
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :wiki
  has_many :wikis

  validates :email, presence: true
  # has_many :wikis, through: :collaborations
  #role = [:admin, :premium, :free]

  def self.search(query)
    where("email LIKE ?", "%#{query}%")
  end

  def standard?
    role == 'standard'
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def make_wikis_public
    wikis.each do |wiki|
      if wiki.private == false
        wiki.update_attributes(private: false)
      end
    end
  end
end

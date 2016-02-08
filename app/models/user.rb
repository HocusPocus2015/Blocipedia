class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis
  has_many :collaborators, through: :wikis

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

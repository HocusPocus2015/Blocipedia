class WikiPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if @user.role == 'admin'
        scope.all 
      elsif user.role == 'premium'
        scope.where('private = ? OR user_id = ?', false, user.id)
      else # this is the lowly standard user and guest
        scope.where(private: false)
      end
    end
  end

  def show?
    record != :private || user.present?
  end

  def make_private?
    user_is?('premium', 'admin')
  end
end

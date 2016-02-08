class WikiPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      wikis = []
      if @user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        wikis = scope.where(private: false)
      end
      wikis # return the wikis array we've built up
    end
  end

  def show?
    record != :private || user.present?
  end

  def make_private?
    user_is?('premium', 'admin')
  end
end

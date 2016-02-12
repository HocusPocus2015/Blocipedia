class CollaboratorsController < ApplicationController

  def edit
    raise
    @wiki = nil
  end

  def collaborators
    @wiki = Wiki.find(params[:id])
  end

 def create
   wiki = Wiki.find(params[:wiki_id])
   collaborator = current_user.collaborators.build(wiki: wiki)

   if collaborator.save
     flash[:notice] = "Collaborator added."
   else
     flash[:alert] = "Collaborator was not added."
   end

   redirect_to :back
 end


 def destroy
  wiki = Wiki.find(params[:id])
  collaborator = current_user.collaborators.find(params[:id])
   if collaborator.destroy
     flash[:notice] = "Collaborator removed."
   else
     flash[:alert] = "Collaborator was not removed."
   end
   redirect_to :back
 end
end

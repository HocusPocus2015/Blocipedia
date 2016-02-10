class CollaboratorsController < ApplicationController


 def create
   wiki = Wiki.find(params[:wiki_id])
   collaborator = current_user.collaborator.build(wiki: wiki)

   if collaborator.save
     flash[:notice] = "Collaborator added."
   else
     flash[:alert] = "Collaborator was not added."
   end

   redirect_to [wiki]
 end

 def destroy
   wiki = Wiki.find(params[:wiki_id])
   collaborator = current_user.collaborator.find(params[:id])

   if collaborator.destroy
     flash[:notice] = "Collaborator removed."
   else
     flash[:alert] = "Collaborator was not removed."
   end
   redirect_to [wiki]
 end
end

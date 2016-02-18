class CollaboratorsController < ApplicationController

  def create
    @collaborator = Collaborator.new({ wiki_id: params[:wiki_id], user_id: params[:user_id]} )
    if @collaborator.save
      flash[:error] = "Error adding collaborator "
    end
      redirect_to :back
    end

#sort this to work
 def destroy
   @collaborator = Collaborator.find(params[:id])
   email = @collaborator.email
   if @collaborator.destroy
     flash[:error] = "There was an error. Please try again."
   end
    redirect_to :back
 end
 

end

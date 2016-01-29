class WikisController < ApplicationController
#  before_action :require_sign_in, except: :show
#  before_action :authorize_user, except: [:show, :new, :create]

  def new
    @wiki = Wiki.new
    # @topics = Topic.all
  end


  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
      if @wiki.save
        flash[:notice] = "Congrats! Wiki was saved."
        redirect_to @wiki
      else
        flash[:error] = "Uh-oh. There was an error. Please try again."
        redirect_to :new
      end
  end


  # def create
    # @topic = Topic.all
    # @wiki = @topic.wikis.build(wiki_params)
    # @wiki.user = current_user

    # @wiki = current_user.wikis.create(wiki_params)
    # @wiki = current_user.wikis.create(wiki_params)
    # @topic = Topic.all

  def show
    @wiki = Wiki.find(params[:id])
    # @topics = Topic.find(params[:topic_id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
    # @wiki = current_user.wiki.find(params[:id])
  end

  def update
     @wiki = Wiki.find(params[:id])
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:error] = "There was an error saving the wiki. Please try again."
       redirect_to :edit
     end
   end


  def destroy
    @wiki = Wiki.find(params[:id])
    # @topics = Topic.find(params[:id])
      if @wiki.destroy
        flash[:notice] = "Done! Your Wiki has been deleted."
        redirect_to wikis_path
      else
        flash[:error] = "Oh dear. There was an error. Please try again."
        render :show
      end
  end


  def index
    @wiki = Wiki.visible_to(current_user)
  end

  private
      def wiki_params
        params.require(:wiki).permit(:title, :body)
      end

      def authorize_user
        wiki = Wiki.find(params[:id])
        unless current_user == wiki.user || current_user.admin?
          flash[:alert] = "Soz. You're not authorized to do that."
          redirect_to welcome
        end
      end
end
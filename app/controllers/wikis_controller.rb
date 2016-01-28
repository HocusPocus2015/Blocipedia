class WikisController < ApplicationController
#  before_action :require_sign_in, except: :show
#  before_action :authorize_user, except: [:show, :new, :create]

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
      @wiki.user = current_user
      if @wiki.save
        redirect_to wiki_path(@wiki), notice: "Congrats! Wiki was saved."
      else
        flash[:error] = "Uh-oh. There was an error. Please try again."
        render :new
      end
    end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wikis = current_user.wikis
  end

  def destroy
    @wiki = Wiki.find(params[:id])
      if @wiki.destroy
        flash[:notice] = "Done! Your Wiki has been deleted."
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
        # params.require(:wiki).permit(:title, :body, :topic)
      end

      def authorize_user
        wiki = Wiki.find(params[:id])
        unless current_user == wiki.user || current_user.admin?
          flash[:alert] = "Soz. You're not authorized to do that."
          redirect_to welcome
        end
      end

end

class WikisController < ApplicationController
#  before_action :require_sign_in, except: :show
#  before_action :authorize_user, except: [:show, :new, :create]
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Congrats! Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "Uh-oh. There was an error. Please try again."
      redirect_to :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end


  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "Done! Your Wiki has been deleted."
      redirect_to wikis_path
    else
      flash[:error] = "Oh dear. There was an error. Please try again."
      render :show
    end
  end

  def collaborators
    @results = User.none
    if params[:search]
      @results = User.search(params[:search])
    end
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])
    unless current_user == wiki.user || current_user.admin?
      flash[:alert] = "Soz. You're not authorized to do that."
      redirect_to welcome
    end
  end
end

class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :update, :show, :delete]
  before_action :authenticate_user!, only: [:show, :new, :edit, :update, :destroy]
  access all: [:index], user: {except: [:destroy]}

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new
    if @article.save(article_params)
      flash[:notice] = "Successfully created article!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Error creating new article!"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:notice] = "Successfully updated article!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Error updating article!"
      render :edit
    end
  end

  def show
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Successfully deleted article!"
      redirect_to articles_path
    else
      flash[:alert] = "Error updating article!"
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :category, :content, :id)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end


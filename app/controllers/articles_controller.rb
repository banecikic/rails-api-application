class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: [:index, :show]

  def index
    articles = Article.recent.page(params[:page]).per(params[:per_page])
    json_articles = ArticleSerializer.new(articles).serializable_hash.to_json
    render json: json_articles
  end

  def show
    article = Article.find(params[:id])
    json_article = ArticleSerializer.new(article).serializable_hash.to_json
    render json: json_article
  end

  def create
    article = current_user.articles.build(article_params)
    article.save!
    render json: article, status: :created
  rescue
    render json: article, adapter: :json_api,
           status: :unprocessable_entity
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update_attributes!(article_params)
    render json: article, status: :ok
  rescue ActiveRecord::RecordNotFound
    authorization_error
  rescue
    render json: article, adapter: :json_api,
           status: :unprocessable_entity
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy
    head :no_content
  rescue
    authorization_error
  end

  private

  def article_params
    params.require(:data).require(:attributes).permit(:title, :content, :slug) ||
      ActionController::Parameters.new
  end
end
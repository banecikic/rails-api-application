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
end
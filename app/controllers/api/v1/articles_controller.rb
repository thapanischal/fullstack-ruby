class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all 
    render json: articles, status:200
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article
    else
      render json:{
        error: "Articleが見つかりません"
      }
    end
  end

  def create
    article = Article.new(
      title:arti_params[:title],
      body:arti_params[:body],
      author:arti_params[:author]
    )
    if article.save
      render json: article
    else
      render json:{
        error:"Article生成出来ません"
      }
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article
      if article.update(arti_params)
        render json: article
      else
        render json: {
          error:"エラーアップデート"
        }
      end
    else
      render json: {
        error: "Article見つかりません"}
    end

  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: "削除できました"
    end
  end

  private
   def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
   end
end

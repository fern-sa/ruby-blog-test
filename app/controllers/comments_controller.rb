class CommentsController < ApplicationController
  before_action :set_article, only:[:create, :index, :destroy, :edit, :update]

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article), notice: "Comment successful"
  end

  def index
    @comments = @article.comments
  end

  def destroy 
    @comment = @article.comments.find(params[:id])
    @comment.destroy 
    redirect_to article_comments_path(@article), notice: "Comment deleted"
  end

  def edit
    @comment = @article.comments.find(params[:id])
  end

  def update 
    @comment = @article.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to article_comments_path(@article), notice: "Comment updated"
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end

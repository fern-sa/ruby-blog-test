class CommentsController < ApplicationController
  before_action :set_article, only:[:create, :index, :destroy, :edit, :update, :show]
  before_action :set_comment, only:[:show, :destroy, :edit, :update]

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article), notice: "Comment successful"
  end

  def index
    @comments = @article.comments
  end

  def show
  end

  def destroy 
    @comment.destroy 
    redirect_to article_comments_path(@article), notice: "Comment deleted"
  end

  def edit
  end

  def update 
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

    def set_comment
      @comment = @article.comments.find(params[:id])
    end
end

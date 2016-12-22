class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = set_comment
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = set_comment
  end

  def create
    @comment = Comment.new(comment_params)
    
    if @comment.save
      redirect_to @comment, notice: 'Comment created.'
    else
      render 'new'
    end
  end

  def update
    @comment = set_comment
    
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @comment = set_comment
    
    @comment.destroy
    redirect_to comments_url, notice: 'Comment destroyed.'
  end

  private
    def set_comment
      Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :ticket_id, :owner_id)
    end
end

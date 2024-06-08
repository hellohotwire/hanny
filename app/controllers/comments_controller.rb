class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @feature = Feature.find(params[:feature_id])
    @comment = @feature.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @feature, notice: 'Comment was successfully created.'
    else
      redirect_to @feature, alert: 'Failed to add comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @feature = @comment.feature
    @comment.destroy
    redirect_to @feature, notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

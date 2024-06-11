class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feature
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @feature.comments.build(comment_params.merge(user: current_user))
    @nesting_level = @comment.parent ? 1 : 0

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @feature, notice: 'Comment was successfully created.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to @feature, alert: 'Failed to add comment.' }
        format.turbo_stream
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @feature, notice: 'Comment was successfully updated.'
    else
      redirect_to @feature, alert: 'Failed to update comment'
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @feature, notice: 'Comment was successfully destroyed.' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("comment_#{@comment.id}_container")
      end
    end

  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_feature
    @feature = Feature.find(params[:feature_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end

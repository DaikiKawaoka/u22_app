class CommentsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user,   only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.thing_id = params[:thing_id]
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_to @comment.thing
    else
      @thing = Thing.find(params[:thing_id])
      @comments = @thing.comments
      render template: 'things/show'
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_to @comment.thing
  end

 private
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
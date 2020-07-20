class CommentsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user,   only: :destroy

  def create
    unless(guest_user?)
      @thing = Thing.find(params[:thing_id])
      #投稿に紐づいたコメントを作成
      @comment = @thing.comments.build(comment_params)
      @comment.user_id = current_user.id
      @coment_thing = @comment.thing
      if @comment.save
        #通知の作成
        @thing.create_notification_comment!(current_user, @comment.id)
        flash[:success] = 'コメントしました'
        redirect_to @comment.thing
      else
        @thing = Thing.find(params[:thing_id])
        flash[:danger] = 'コメントに失敗しました（空文字または140文字を超えています）'
        @comments = @thing.comments
        @user = @thing.user
        redirect_to @thing
      end
    else
      redirect_to "/login"
    end
  end

  def destroy
    unless(guest_user?)
      @comment = Comment.find(params[:id])
      @comment.destroy
      flash[:success] = 'コメントを削除しました'
      redirect_to @comment.thing
    else
      redirect_to "/login"
    end
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
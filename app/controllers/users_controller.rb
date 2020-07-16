class UsersController < ApplicationController

  #index,edit,updateの前にlogged_in_userを実行するよのコード
  before_action :logged_in_user, only: [:index ,:edit, :update,
                           :following, :followers,:show]

  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    if (current_user?(@user))
      # 自分が投稿したもの
      @things = @user.things.paginate(page: params[:page]).order(created_at: :desc)
      @mark="calendar_tag"
    else
      @things = @user.things.paginate(page: params[:page]).order(created_at: :desc).where(thing_shear: true)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_new)
    if @user.save
      #　性別ごとに画像挿入
      @user.icon_image
      @user.send_activation_email
      flash[:info] = "メールを確認して、アカウントを有効にしてください"
      redirect_to root_url
      # log_in @user
      # flash[:success] = "ユーザ作成成功！"
      # redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    unless(guest_user?)
      @user = User.find(params[:id])
    else
      flash[:success] = "ログインしてください。"
      redirect_to "/login"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      flash[:success] = "プロフィールを更新しました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def kensaku
    if(user=User.find_by(user_name: params[:user_name]))
      flash[:success] = "検索成功"
      redirect_to user
    else
      redirect_back(fallback_location: root_path)
      flash[:danger] = '検索失敗'
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following.all
    @follow = "フォロー中 "
    @follow_count = @user.following.count
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @follow = "フォロワー "
    @follow_count = @user.followers.count
    render 'show_follow'
  end

  def like
    @user = User.find(params[:id])
    @mark="like_tag"
    redirect_to root_url and return unless @user.activated?
    if (current_user?(@user))
      @things = @user.things.paginate(page: params[:page]).order(created_at: :desc)
      # like一覧
      like_array = []
      likes = Like.where(user_id: params[:id]).order(created_at: :desc)
      likes.each{|like|
        like_array << like.thing_id
      }
      @things = Thing.where(id: like_array)
    else
      redirect_to root_url
    end
    render "like"
  end

  def keep
    @user = User.find(params[:id])
    @mark="keep_tag"
    redirect_to root_url and return unless @user.activated?
    if (current_user?(@user))
      @things = @user.things.paginate(page: params[:page]).order(created_at: :desc)
      # keep一覧
      keep_array = []
      keeps = Keep.where(user_id: params[:id]).order(created_at: :desc)
      keeps.each{|keep|
        keep_array << keep.thing_id
      }
      @things = Thing.where(id: keep_array)
    else
      redirect_to root_url
    end
    render "keep"
  end

  private

    def user_params_new
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation,:sex,:user_name,:image,:user_notification)
    end

    def user_params_update
      # if params[:user_image]
      #   #データベースに保存するファイル名はユーザーのid.jpgとする
      #   @user.user_image = "#{@user.id}.jpg"
      #   image = params[:user_image]
      #   File.binwrite("public/user_images/#{@user.user_image}",image.read)
      # end
      params.require(:user).permit(:name, :email,:sex,:user_name,:user_comment,:image,:user_notification)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end

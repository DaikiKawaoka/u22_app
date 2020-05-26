class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update]
  before_action :correct_user,   only: [:edit, :update]


  def index
    
  end

  def show
    @user = User.find(params[:id])
    @things = @user.things.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_new)
    if @user.save
      log_in @user
      flash[:success] = "ユーザ作成成功！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
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

  private

    def user_params_new
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation,:sex,:user_name)
    end

    def user_params_update
      # if params[:user_image]
      #   #データベースに保存するファイル名はユーザーのid.jpgとする
      #   @user.user_image = "#{@user.id}.jpg"
      #   image = params[:user_image]
      #   File.binwrite("public/user_images/#{@user.user_image}",image.read)
      # end
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation,:sex,:user_name,:user_comment,:image)
    end

   # beforeアクション

    #  ログイン済みユーザーかどうか確認   applicationControllerに移動したよ
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "ログインしてください"
    #     redirect_to login_url
    #   end
    # end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end

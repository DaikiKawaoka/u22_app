class ThingsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy,:edit]

    def index

    end

    def show
      @thing = Thing.find(params[:id])
      user = @thing.user
      @comment =Comment.new #新規コメント用
      @comments =@thing.comments #コメント表示用投稿に関連づくコメントの取得
    end

    def new
      @thing = current_user.things.build if logged_in?
    end

    def create
      @thing = current_user.things.new(thing_params_new)
      if @thing.save
        flash[:success] = "物登録完了しました"
        redirect_to root_url
      else
        render 'new'
      end
    end

    def edit
      @thing = Thing.find(params[:id])
    end

    def update
      @thing = Thing.find(params[:id])
      if @thing.update(thing_params_update)
        flash[:success] = "投稿を更新しました！"
        redirect_to @thing
      else
        render 'edit'
      end
    end

    def destroy
      Thing.find(params[:id]).destroy
      flash[:success] = "削除しました。"
      redirect_to user_path(current_user)
    end


 private
    #データベースに登録
    def thing_params_new
      params.require(:thing).permit(:thing_name, :thing_comment,:thing_assessment,:thing_type,:thing_shear,
                                    :thing_favorite,:thing_price,:thing_maker,:thingImage)
    end

    def thing_params_update
      params.require(:thing).permit(:thing_name, :thing_comment,:thing_assessment,:thing_type,:thing_shear,
                                    :thing_favorite,:thing_price,:thing_maker,:thingImage)
    end
end

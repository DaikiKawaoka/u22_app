class ThingsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy,:edit]

    def index

    end

    def show
      @thing = Thing.find(params[:id])
      @user = @thing.user
      @comment =Comment.new #新規コメント用
      @comments =@thing.comments #コメント表示用投稿に関連づくコメントの取得
    end

    def new
      unless(guest_user?)
        @thing = current_user.things.build if logged_in?
      else
        flash[:success] = "ログインしてください。"
        redirect_to "/login"
      end
    end

    def create
      unless(guest_user?)
        @thing = current_user.things.new(thing_params_new)
        if @thing.save
          flash[:success] = "物登録完了しました"
          redirect_to root_url
        else
          render 'new'
        end
      else
        flash[:success] = "ログインしてください。"
        redirect_to "/login"
      end
    end

    def edit
      unless(guest_user?)
        @thing = Thing.find(params[:id])
      else
        redirect_to "/login"
      end
    end

    def update
      unless(guest_user?)
        @thing = Thing.find(params[:id])
        if @thing.update(thing_params_update)
          flash[:success] = "投稿を更新しました！"
          redirect_to @thing
        else
          render 'edit'
        end
      else
        flash[:success] = "ログインしてください。"
        redirect_to "/login"
      end
    end

    def destroy
      unless(guest_user?)
        Thing.find(params[:id]).destroy
        flash[:success] = "削除しました。"
        redirect_to root_url
      else
        flash[:success] = "ログインしてください。"
        redirect_to "/login"
      end
    end


 private
    #データベースに登録
    def thing_params_new
      params.require(:thing).permit(:thing_name, :thing_comment,:thing_assessment,:thing_type,:thing_shear,
                                    :thing_price,:thing_maker,:thingImage,:thing_purchase_place,:thing_price,:purchase_date)
    end

    def thing_params_update
      params.require(:thing).permit(:thing_name, :thing_comment,:thing_assessment,:thing_type,:thing_shear,
                                    :thing_price,:thing_maker,:thingImage,:thing_purchase_place,:thing_price,:purchase_date)
    end
end

class ThingsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
  
    def create
      @thing = current_user.things.new(thing_params_new)
      if @thing.save
        flash[:success] = "物登録完了しました"
        redirect_to root_url
      else
        render 'static_pages/home'
      end
    end
  
    def destroy
    end


 private
    #データベースに登録
    def thing_params_new
      params.require(:thing).permit(:thing_name, :thing_comment, :thing_frequency,
                                  :thing_assessment,:thing_type,:thing_shear,:thing_favorite,:thing_price,
                                  :thing_number,:thing_purchase_place,:thing_maker,:thingImage)
    end
end

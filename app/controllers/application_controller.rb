class ApplicationController < ActionController::Base
  before_action :set_current_user
  include SessionsHelper

  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    #共有をtrueにしている物だけ
    def thing_share
      @things = Thing.where(thing_shear: true).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    end

end

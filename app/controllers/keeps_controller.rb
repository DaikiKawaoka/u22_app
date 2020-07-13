class KeepsController < ApplicationController
  before_action :logged_in_user
    def create
      unless(guest_user?)
      @thing = Thing.find(params[:thing_id])
      unless @thing.keep?(current_user)
        @thing.keep(current_user)
        @thing.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to "/login"
    end
  end

  def destroy
    unless(guest_user?)
      @thing = Keep.find(params[:id]).thing
      if @thing.keep?(current_user)
        @thing.unkeep(current_user)
        @thing.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to "/login"
    end
  end
end

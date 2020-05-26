class StaticPagesController < ApplicationController
  def home
    @thing = current_user.things.build if logged_in?
  end

  def help
    
  end

  def about
    
  end

end

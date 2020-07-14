class StaticPagesController < ApplicationController
  #地球ページ
  def home
    if current_user
    # following_ids = "SELECT followed_id FROM relationships
    #                  WHERE follower_id = :user_id"
    # @things=Thing.where("user_id IN (#{following_ids})
    #                  OR user_id = :user_id", user_id: current_user.id)
  #  @things =Thing.all
    @things=thing_share()
    end
  end
#地球絞り込みページ
  def home_narrow
    if current_user
      thing_type = params[:id]
      @thing_type_name = check_thing_type(thing_type)
      #タイプかつ共有している物
      @things=Thing.where(thing_type: thing_type,thing_shear: true).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    end
  end

  #管理ページ
  def index
    if current_user
      @now_user = current_user
      @things=current_user.things.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    end
  end

#管理絞り込みページ
  def index_narrow
    if current_user
      @now_user = current_user
      thing_type = params[:id]
      @thing_type_name = check_thing_type(thing_type)
      @things=Thing.where(thing_type: thing_type,user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    end
  end

  private

  def check_thing_type(thing_type)
    case thing_type
    when "1"
      "Fashion"
    when "2"
      "Book"
    when "3"
      "Game"
    when "4"
      "Cosmetics"
    when "5"
      "Electrical Appliances"
    when "6"
      "Food"
    when "7"
      "Music"
    when "8"
      "Everyday Items"
    when "9"
      "Drug"
    when "10"
      "Stationery"
    when "11"
      "Sport & Outdoor"
    when "12"
      "Vehicle"
    when "13"
      "Baby & Toy"
    when "14"
      "Furniture"
    when "15"
      "PC & Office Supplies"
    else
      "Other"
    end
  end
end

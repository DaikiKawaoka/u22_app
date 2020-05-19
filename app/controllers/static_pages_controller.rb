class StaticPagesController < ApplicationController
  def home
    render html: "ホームページだよ"
  end

  def help
    render html: "ヘルプページだよ"
  end

  def about
    render html: "アバウトページだよ"
  end

end

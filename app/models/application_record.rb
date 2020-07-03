class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 表示用のりサイズ済み画像を返す
  #header_icon
  def display_image2
    image.variant(combine_options:{resize:"27x27^",crop:"27x27+0+0",gravity: :center}).processed
  end

  def display_image3
    image.variant(combine_options:{resize:"45x45^",crop:"45x45+0+0",gravity: :center}).processed
  end

  #profile_icon
  def display_image_profile2
    image.variant(combine_options:{resize:"240x240^",crop:"240x240+0+0",gravity: :center}).processed
  end

end

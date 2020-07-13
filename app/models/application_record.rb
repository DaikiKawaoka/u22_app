class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 表示用のりサイズ済み画像を返す
  #header_icon
  def display_image2
    image.variant(resize_to_fill: [27, 27])
  end

  def display_image3
    image.variant(resize_to_fill: [45, 45])
  end

  #profile_icon
  def display_image_profile2
    image.variant(resize_to_fill: [240, 240])
  end

  def display_image_profile300
    image.variant(resize_to_fill: [500, 500])
  end

end

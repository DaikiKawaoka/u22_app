class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 表示用のりサイズ済み画像を返す
  def display_image2
    image.variant(resize_to_limit: [27, 27])
  end
end

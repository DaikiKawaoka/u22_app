module UsersHelper
  def image_show(user)
   if user.image.attached?
     image_tag user.display_image2 if user.image.attached?
   end
  end
end

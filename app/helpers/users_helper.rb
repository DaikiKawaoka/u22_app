module UsersHelper
  def image_show(user)
   if user.image.attached?
     image_tag user.display_image2 if user.image.attached?
   end
  end

  def follow_image_show(user)
   if user.image.attached?
     image_tag user.display_image3 if user.image.attached?
   end
  end

  def name_print(name)
      if name.encode("EUC-JP").bytesize >= 18
          return name.truncate(13)
      end
      return name
  end

  def user_name_print(name)
      if name.encode("EUC-JP").bytesize >= 25
          return name.truncate(20)
      end
      return name
  end

  def user_name_print_thing(name)
      if name.encode("EUC-JP").bytesize >= 20
          return name.truncate(19)
      end
      return name
  end
end

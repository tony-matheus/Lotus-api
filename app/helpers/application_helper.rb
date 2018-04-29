module ApplicationHelper

  def render_json(code,msg)
      render :json => {
       :status => code,
       :message => msg
      }
  end

  def profile_permission(user_id)
      @@profile = Profile.find_by(user_id: user_id)
      if @@profile.function == 1
          return true
      end
      return false
  end

  def find_exist(value)
      @@response = Store.exists?(value)
      if @@response
         return
      end
      return @@response
  end

  def images_params
      @@images = params[:images]
      @@image = {
          @index => @index_id,
          :image => @@images
      }
      return @@image
  end

end

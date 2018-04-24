module ApplicationHelper

  def render_json(code,msg)
      render :json => {
       :status => code,
       :message => msg
      }
  end

  def profile_permission(user)
      profile = Profile.find_by(user_id: user.id)
      if profile.function == 1
          return true
      end
      false
  end

  def find_store_by_user_id
      user_store = UsersStore.find_by(user_id: current_user.id)
      store = Store.find(user_store.store_id)
      store
  end

end

class UserController < ApplicationController
    before_action :authenticate_user

    def user_data_update
        if current_user()
            @user = current_user()
            @user.email = current_user.email
            @user.name = params[:name]
            @user.gender = params[:gender]
            @user.birthday = params[:birthday]
            @user.cpf = params[:cpf]

            @user.update()
        end
    end

    def user_avatar
        if current_user()
            user = User.find(current_user.id)
            user.update_attribute(:avatar, params[:avatar])
        end
    end
end

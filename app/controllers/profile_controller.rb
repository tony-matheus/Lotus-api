class ProfileController < ApplicationController
  before_action :authenticate_user!

  def profile
      if current_user
          @profile = Profile.find_by_user_id(current_user)
          render_json(200,@profile)
      end
  end

  def create
    if current_user
      @name = params[:name]
      @cpf = params[:cpf]
      @gender = params[:gender]
      @birthday = params[:birthday]
      @profile = Profile.new(:user_id => current_user.id, :cpf => @cpf, :gender => @gender, :birthday => @birthday, :name => @name)
      if @profile.save
        @contactsCreate = contacts_create
        if @contactsCreate.save
            render_json(200, msg = { :msg1 => @profile, :msg2 => @contactsCreate})
        else
            render_json(400,"Algo deu errado no cadastro de contatos")
        end
      else
        render_json(400,"Algo deu errado na criação do usuario")
      end
    else
      render_json(401,"Usuario nao logado!")
    end
  end

  def contacts_create
      @phoneNumber = params[:phone]
      @cellPhoneNumber = params[:cellphone]
      @email = params[:email]
      @contact = Contact.new(:profile_id => @profile.id, :phone => @phoneNumber, :cellphone =>@cellPhoneNumber, :email => current_user.email)
  end

end

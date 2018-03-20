class ProfileController < ApplicationController
  before_action :authenticate_user!

  def profile
      if current_user
          @profile = Profile.find(current_user.id)
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
      Contact.new(:profile_id => @profile.id, :phone => @phoneNumber, :cellphone =>@cellPhoneNumber, :email => current_user.email)
  end

  def address_create
      @address = {
          :profile_id => @profile.id,
          :street => params[:street],
          :neighborhood => params[:neighborhood],
          :public_place => params[:public_place],
          :number => params[:number],
          :city => params[:city],
          :state => params[:state],
          :country => params[:country],
          :complement => params[:complement],
          :cep => params[:cep]
      }
      Address.new(
          @address
      )
  end
end

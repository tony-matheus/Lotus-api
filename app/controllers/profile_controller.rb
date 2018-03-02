class ProfileController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user
      @name = params[:name]
      @cpf = params[:cpf]
      @gender = params[:gender]
      @birthday = params[:birthday]
      @profile = Profile.new(:user_id => current_user.id, :cpf => @cpf, :gender => @gender, :birthday => @birthday, :name => @name)
      if @profile.save
        render_json(200,@profile)
      else
        render_json(400,"Algo deu errado!")
      end
    else
      render_json(401,"Usuario nao logado!")
    end
  end

  def profile
    if current_user
      @profile = Profile.find_by_user_id(current_user)
      render_json(200,@profile)
    end
  end

end

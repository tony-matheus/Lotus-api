module Api::V1
   class ProfileController < ApiController
        before_action :authenticate_user!
        before_action :set_profile, only: [:update, :show, :destory]
        def index
            @profiles = Profile.all
            render json: @profiles, inclue[:user, :contacts, :addresses]
        end

        def show
            render json: @profile, include: [:user, :contacts, :addresses]
        end
        
        def create
            @profile = Profile.new(profile_params)
            if @profile.save
                render json: @profile, include: [:user, :contacts, :addresses]
            else
                render json: @persona.errors.full_messages, status: :unprocessable_entity
            end
        end
        
        def update
            if @profile.update(profile_params)
                render json: @profile, include: [:user, :contacts, :addresses]
            else
                render json: @persona.errors.full_messages, status: :unprocessable_entity
            end            
        end
        
        def destroy
            if @profile.destroy
                render json: :destroyed
            else
                render json: @persona.errors.full_messages, status: :unprocessable_entity
            end 
        end

        private 

        def set_profile
            @profile = Profile.find(params[:id])
        end

        def profile_params
            params.require(:profile).permit(
                :profile_type,
                :function,
                :current_store,
                :full_name,
                :cpf,
                :birthday,
                :gender,
                user_attributes:[
                    :email,
                    :password,
                    :password_confirmation,
                    :type_user
                    ],            
                contacts_attributes:[
                    :phone,
                    :type_phone,
                    :email
                ],
                addresses_attributes:[
                    :street,
                    :neighborhood,
                    :public_place,
                    :number,
                    :neighborhood,
                    :city,
                    :state,
                    :country,
                    :complement,
                    :cep
                ]
            )
        end
   end 
end
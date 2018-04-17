module Overrides
    class RegistrationsController < DeviseTokenAuth::RegistrationsController

        def create
            User.transaction do
                @resource            = resource_class.new(sign_up_params)
                @resource.uid        = sign_up_params[:email]
                @resource.provider   = "email"

                # success redirect url is required
                unless params[:confirm_success_url]
                    return render json: {
                        status: 'error',
                        data:   @resource,
                        errors: ["Missing `confirm_success_url` param."]
                        }, status: 403
                end

                begin
                # override email confirmation, must be sent manually from ctrl
                # User.skip_callback("create", :after, :send_on_create_confirmation_instructions)
                if @resource.save

                    unless @resource.confirmed?
                        # user will require email authentication
                        @resource.send_confirmation_instructions({
                            client_config: params[:config_name],
                            redirect_url: params[:confirm_success_url]
                        })
                    else
                        # email auth has been bypassed, authenticate user
                        @user      = @resource
                        @client_id = SecureRandom.urlsafe_base64(nil, false)
                        @token     = SecureRandom.urlsafe_base64(nil, false)

                        @user.tokens[@client_id] = {
                          token: BCrypt::Password.create(@token),
                          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
                        }

                        @user.name = params[:name]
                        @user.cpf = params[:cpf]
                        @user.birthday = params[:birthday]
                        @user.gender = params[:gender]

                        @user.save!

                        @profile = Profile.new(:user_id => current_user.id, :function => 1, :profile_type =>1)
                        @profile.save!

                        update_auth_header
                    end

                    render json: {
                        status: 'success',
                        data:   @resource.as_json
                    }
                else
                    clean_up_passwords @resource
                    render json: {
                        status: 'error',
                        data:   @resource,
                        errors: @resource.errors
                     }, status: 403
                end
                rescue ActiveRecord::RecordNotUnique
                clean_up_passwords @resource
                render json: {
                  status: 'error',
                  data:   @resource,
                  errors: ["An account already exists for #{@resource.email}"]
                }, status: 403
                end
            end
        end



    end
end

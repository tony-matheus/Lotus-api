class InformationsController < ApplicationController
    before_action :authenticate_user!

    def create
        if current_user
            @user_id = current_user.id
            @contact = contacts_create
            @address = address_create

            if @contact.save! && @address.save!
                render_json(200,msg = {:msg1 => @contact, :msg2 => @address})
            else
                render_json(400,msg = {:msg1 => @contact, :msg2 => @address, :msg3 => "Algo deu errado no cadastro de contatos"})
            end
        end
    end

    def update
        if current_user
            contact = Contact.find_by(user_id: current_user.id)
            address = Address.find_by(user_id: current_user.id)

            if contact.update(contact_params)
                if address.update(address_params)
                    render_json(200,msg = {:msg1 => contact, :msg2 => address})
                else
                    render_json(500,msg = { :contact => @contact,:error => "update address fail" })
                end
            else
                render_json(500,"error at update contact")
            end
        end
    end

    def show
        if current_user
            @contacts = Contact.find_by(user_id: current_user.id, rating: 4)
            @address = Address.find_by(user_id: current_user.id, rating: 4)

            render_json 302, msg = { :contacts => @contacts, :address => @address}
        end
    end

    private

    def contacts_create
        contact_data = contact_params

        Contact.new(contact_data)
    end

    def address_create
        address_data = address_params
        Address.new(address_data )
    end

    # def contacts_update
    #     Address.find_by(user_id: current_user.id)
    # end

    def contact_params
        contact_data = {
            :user_id => current_user.id,
            :phone => params[:phone],
            :email => params[:email],
            :cellphone => params[:cellphone],
        }
        contact_data
    end

    def address_params
        address_data = {
            :user_id => current_user.id,
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

        address_data
    end

end

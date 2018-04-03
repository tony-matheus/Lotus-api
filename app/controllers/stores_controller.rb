class StoresController < ApplicationController
    before_action :authenticate_user!

    def method
        #crud da loja
        #qual a loja current_user ?
        # salvou a loja ficar com o id
        # salvar as imagens codigo image_service controller
    end

    def create
        if current_user
            @store = Store.new(store_params())
            if profile_permission(current_user)
                # if @store.save! && store_images
                if @store.save!
                    render_json(200,@store)
                else
                    render_json(400, msg ={msg1: @store, msg2: "failed to save store" })
                end
            else
                render_json(203, "Profile has no permission")
            end
        end
        user_store_create()
    end

    def update
        if current_user
            @userStore = UsersStore.find_by(user_id: current_user.id)
            @store_id = @userStore.store_id
            @store = Store.find(storeId)
            if profile_permission(current_user)
                if @store.update
                    render_json(200,msg = {:store => store, :msg => "success"})
                else
                    render_json(400, "store not register")
                end
            else
                render_json(203, "Profile has no permission")
            end
        end
    end

    def show_stores
        if current_user
            @userStore = UsersStore.find(current_user.id).all
            render_json(200,@userStore)
        end
    end

    def select_store
        if current_user
            @store_id = params[:store_id]
            if verify_store
                session[:store_id] = @store_id
            else
                render_json(400,"this store don't belongs to this user, probably it's a hacker")
            end
        end
    end


    def show
        if current_user
            @stores = Store.all
            render_json(200,@stores)
        end
    end


    private

    def verify_store
        @userStoreExists = UsersStore.where(user_id: current_user.id, store_id: @store_id).exists?
        if @userStoreExists
            return true
        else
            return false
        end
    end

    def store_params
        store = {
            :name => params[:name],
            :CNPJ => params[:CNPJ],
            :category => params[:category],
            :longitude => params[:longitude],
            :latitude => params[:latitude]
        }

        store
    end

    def store_images
        count = 0
        @images = params[:images]
        @images.each do |image|
            count = count + 1
            @image = ImagesStore.new(:store_id => @store.id, :image=> image)
            unless @image.save
                render_json(500, "failed to save image#{count}")
            end
        end
        true
    end

    def user_store_create
        user_store = UsersStore.new(
                                    :user_id => current_user.id,
                                    :store_id => @store.id)
        user_store.save
    end
end

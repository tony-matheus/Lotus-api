class StoresController < ApplicationController
    before_action :authenticate_user!, except: [:show_stores,:show]

    def create
        if current_user()
            @store = Store.new(store_params())
            if profile_permission(current_user)
                # if @store.save! && store_images
                if @store.save!
                    @user_store = user_store_create()
                    if @user_store.save!
                        session[:store_id] = @store.id
                        render_json(200, msg = { msg1: @store, msg2: @user_store })
                    else
                        render_json(400, msg = { msg1: @user_store, msg2: "failed to save store" })
                    end
                else
                    render_json(400, msg = { msg1: @store, msg2: "failed to save store" })
                end
            else
                render_json(203, "Profile has no permission")
            end
        end
    end

    def update
        if current_user()
            if profile_permission(current_user)
                @userStore = UsersStore.find_by(user_id: current_user.id)
                @store_id = @userStore.store_id
                @store = Store.find(storeId)
                if @store.update
                    render_json(200, msg = { :store => store, :msg => "success"})
                else
                    render_json(400, "store not register")
                end
            else
                render_json(203, "Profile has no permission")
            end
        end
    end

    def show_stores
        if current_user()
            @store = Store.find(session[:store_id])
            render_json(200,@store)
        end
    end

    def select_store
        if current_user()
            @store_id = params[:store_id]
            if verify_store()
                session[:store_id] = @store_id
            else
                render_json(400,"this store don't belongs to this user, probably it's a hacker")
            end
        end
    end


    def show
        if current_user()
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
            name: params[:name],
            CNPJ: params[:CNPJ],
            category: params[:category],
            longitude: params[:longitude],
            latitude: params[:latitude]
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
            user_store
    end
end

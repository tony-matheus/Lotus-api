class StoresController < ApplicationController
    before_action :authenticate_user!, except: [:show_stores,:show]
    before_action :duplicateStore?, only:[:create]

    def create
        if current_user()
            if profile_permission(current_user.id && !duplicateStore?())
                Store.transaction do
                    @store = Store.new(store_params())
                    if @store.save!
                        @user_store = UsersStore.new(user_store_params())
                        if @user_store.save!
                            session[:store_id] = @store.id
                            render_json(200, msg = { msg1: @store, msg2: @user_store })
                        else
                            render_json(400, msg = { msg1: @user_store, msg2: "failed to save store" })
                        end
                    else
                        render_json(203, "Profile has no permission")
                    end
                end
            end
        end
    end

    def update
        if current_user()
            if profile_permission(current_user())
                @userStore = UsersStore.find_by(user_id: current_user.id)
                @@store_id = @userStore.store_id
                #session please
                @store = Store.find_by(:store_id => @@store_id)
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
            @stores = Store.all
            render_json(200,@stores)
        end
    end

    def show_user_stores
        if current_user()
            @@stores = Store.find_by(:user_id => current_user.id).all
            render_json(200,@store)
        end
    end

    def current_store
        if current_user()
            @store = Store.find(session[:store_id])
            render_json(200,@store)
        end
    end

    def select_store
        if current_user()
            @@store_id = params[:store_id]
            if verify_store()
                session[:store_id] = @@store_id
            else
                render_json(400,"this store don't belongs to this user, probably it's a hacker")
            end
        end
    end

    def save_images
        @index = :store_id
        @index_id = session[:store_id]
        @imageStore = ImagesStore.new(images_params())
        if @imageStore.save
            render_json(200,@imageStore.image.url(:medium))
        else
            render_json(500, msg = {msg1: @image, msg2: @imageStore})
        end
    end

    def update_images
        @imagesUpdate = ImagesStore.find_by(store_id: session[:store_id])
        if @imagesUpdate.update_attribute(:image_file_name, params[:images])
            #continue here
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
        @@store = {
            name: params[:name],
            CNPJ: params[:CNPJ],
            category: params[:category],
            longitude: params[:longitude],
            latitude: params[:latitude]
        }
        return @@store
    end

    def user_store_params
        @@user_store = {
            :user_id => current_user.id,
            :store_id => @store.id
        }
        return @@user_store
    end

    def duplicateStore?
        @@store_name = params[:CNPJ]
        @@store = Store.find_by(CNPJ: @@store_name)
        if @@store == nil
            return false
        end
        return true
    end
end

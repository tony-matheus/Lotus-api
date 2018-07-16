class ServicesController < ApplicationController
    before_action :authenticate_user!

    
























    def create_service
        if current_user()
            @service = Service.new(service_params())
            if @service.save!
                render_json(200, "service has been create")
            else
                render_json(500, "failed to save service")
            end
            has_product = params[:has_product]
            if has_product
                create_product()
            end
        end
    end

    def update_service
        if current_user()
            @service_id = params[:service_id]
            @service = Service.find(@service_id)
            if @service.update(service_params())
                render_json(200,@service)
            else
                render_json(500,"error to update service")
            end
        end
    end

    def show_service
        if current_user()
            begin
                screen = params[:screen]
                if screen == 1
                    @store = find_store_by_user_id(current_user())
                    @services = Service.find(store.id).all()
                else
                    @services = Service.all()
                end
            rescue ActiveRecord::RecordNotFound
                @services = nil
            end
            if nil?(@services)
                render_json(404,"Não existe serviço")
            else
                render_json(302, @services)
            end
        end
    end

    # ERRRROOOORRRR #

    def destroy_service
        if current_user()
            @store_id = params[:store_id]
            if @store_id == nil
                Store.find_by(user_id: current_user.id).destroy()
            else
                @store = Store.find(@store_id).destroy()
            end
            render_json(200, "Store has been destruid pnc do rafael")
        end
    end

    #
    # Products
    #

    def create_products
        Product.transaction do
            ServicesProduct.transaction do
                count = 0
                @products = params[:products]
                @products.each do |product|
                    count += 1
                    @product_new = Product.new(product_params(product))
                    if @product_new.save
                        if product_images()
                            unless create_service_product(product.id)
                                render_json(500, "failed to save ServicesProduct")
                            end
                        else
                            render_json(500, "failed to save image product")
                        end
                    end
                    render_json(500,"failed to save a product")
                end
            end
        end
    end

    def update_products
        @product_id = params[:product_id]
        @product = Product.find(@product_id)
        if product.update(product_params())
            render_json(200, @product)
        end
    end

    def show_all_products
        @store_id = session[:store_id]
        @products = Product.find_by(:store_id => store_id).all()
        render_json(302,@products)
    end

    def show_products_by_services
        @service = params[:service]
        @service_products = ServicesProduct.find_by(:service_id => @service).all()
        @products = []
        count = 0
        @services_products.each do |service_product|
            @products[count] = service_product.product_id
            count += 1
        end
        render_json(302,@products)
    end

    def destroy_products
        @product_id = params[:product_id]
        if Product.find(@product_id).destroy()
            render_json(200, "product has been deleted")
        else
            render_json(500, "failed to delete product")
        end
    end

    def service_images
        @index = :service_id
        @index_id = params[:service_id]
        @imageService = ImagesService.new(images_params(@@service_id))
        if @imageService.save
            render_json(200,@imageService.image.url(:medium))
        else
            render_json(500, msg = {msg1: @image, msg2: @imagesService})
        end
    end

    def product_images
        @index = :product_id
        @index_id = params[:product_id]
        @imageProduct = ImagesService.new(product_images_params(@@product_id))
        if @imageProduct.save
            render_json(200,@imageProduct.image.url(:medium))
        else
            render_json(500, msg = {msg1: @image, msg2: @imageProduct})
        end
    end

    private

    def create_service_product(product_id)
        service_id = params[:service_id]
        service_product = ServicesProduct.new(
            :services_id => service_id,
            :products_id => product_id
        )
        if service_product.save
            return true
        end
        return false
    end

    def service_params
        @@service = {
            :store_id => session[:store_id],
            :title => params[:title],
            :name => params[:name],
            :description => params[:description],
            :price => params[:price],
            :time => params[:time],
            :type => params[:type]
        }
        return @@service
    end

    def product_params(product)
        @@product_data = {
            :store_id => session[:store_id],
            :name => product.name,
            :amount => product.amount,
            :price => product.price
        }
        return @@product_data
    end
end

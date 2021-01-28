class Api::V1::VehiclesController < ApplicationController
    before_action :vehicle_params, only: [:show, :update, :destroy]
    before_action :find_vehicle, only: [:show, :update, :destroy]

    # GET /api/v1/vehicles
    def index
        @vehicles = Vehicle.all
        render json: @vehicles
    end

    # GET /api/v1/vehicles/:id
    def show
        if @vehicle
            render json: @vehicle
        else
            render json: { error: 'Unable to find user.' }, status: 400
        end
    end

    # POST /api/v1/vehicles
    def create
        @vehicle = Vehicle.new(vehicle_params)
        puts @vehicle[:max_speed]
        if is_max_speed? @vehicle[:max_speed]
            if @vehicle.save
                render json: { message: 'Vehicle successfully created.' }, status: 200
            else
                render json: { error: 'Unable to create vehicle.' }, status: 400
            end
        else
            render json: { error: 'Max speed must be lower 100.000.' }, status: 400
        end
    end

    # PUT /api/v1/vehicles/:id
    def update
        if @vehicle
            if is_max_speed? vehicle_params[:max_speed]
                @vehicle.update(vehicle_params)
                render json: { message: 'Vehicle successfully updated.' }, status: 200
            else
                render json: { error: 'Max speed must be lower 100.000.' }, status: 400
            end
        else
            render json: { error: "Vehicle doesn't exists." }, status: 400
        end
    end

    # DELETE /api/v1/vehicles/:id
    def destroy
        if @vehicle
            @vehicle.destroy
            render json: { message: 'Vehicle successfully deleted.' }, status: 200
        else
            render json: { error: 'Unable to delete vehicle.' }, status: 400
        end
    end

    # private methods
    private

    def vehicle_params
        params.require(:vehicle).permit(:user_id, :vehicle_type, :color, :brand, :model, :max_speed, :air_conditioning, :turbo, :electric)
    end

    def find_vehicle
        @vehicle = Vehicle.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { message: "Vehicle  couldn't be found.", error: e.to_s }, status: :not_found
    end

    def is_max_speed?(speed)
        speed <= 10000 ? true : false
    end
    
end

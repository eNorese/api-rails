class Api::V1::UsersController < ApplicationController
    before_action :user_params, only: [:show, :update, :destroy]
    before_action :find_user, only: [:show, :update, :destroy]
    before_action :new_user, only: [:create]

    # GET /api/v1/users
    def index
        @users = User.all
        render json: @users
    end

    # GET /api/v1/users/:id
    def show
        if @user
            render json: @user
        else
            render json: { error: 'User not found.' }, status: 400 
        end
    end

    # POST /api/v1/users
    def create
        if is_adult? @new_user[:age]
            if @new_user.save
                render json: { message: 'User successfully saved.' }, status: 200
            else
                render json: { error: 'Unable to save user.' }, status: 400 
            end
        else
            render json: { error: 'User must be older 18.' }, status: 400
        end
    end

    # PUT /api/v1/users/:id
    def update
        if @user
            if is_adult? params[:age]
                @user.update(user_params)
                render json: { message: 'User successfully updated.'}, status: 200
            else
                render json: { error: 'Unable to update user.' }, status: 400
            end
        else
            render json: { error: 'Unable to update user.' }, stauts: 400
        end
    end

    # DELETE /api/v1/users/:id
    def destroy
        if @user
            @user.destroy
            render json: { message: 'User successfully deleted.' }, status: 200
        else
            render json: { error: 'Unable to delete user.' }, status: 400
        end
    end

    # private methods
    private

    def user_params
        params.require(:user).permit(:username, :password, :name, :lastname, :email, :age, :covid)
    end

    def find_user
        @user = User.find(params[:id])
    end

    def new_user
        @new_user = User.new(user_params)
    end

    def is_adult?(age)
        age >= 18 ? true : false
    end

end

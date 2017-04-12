class UsersController < ApplicationController
  before_action :set_user,     only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [       :edit, :update]
  before_action :logged_in?,   only: [:show, :edit]

  def home
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end


  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Stellar!"
      redirect_to @user
    else
      redirect_to 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :bio, :email, :password, :avatar)
    end

    def correct_user
      redirect_to(root_path) unless current_user?(@user)
    end

end

class UsersController < ApplicationController

  def new
    @user = User.new(user_params)
  end

  def create
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @task
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

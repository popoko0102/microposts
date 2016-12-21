class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show # 追加
   @user = User.find(params[:id])
  end

  def new
    @user = User.new
    #> User.new
    #<User id: nil, name: nil, email: nil, password_digest: nil, created_at: nil, updated_at: nil> 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正 。redirect_to user_path(@user)　と同じ
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    #> User.find(1)
    #User Load (0.5ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT 1  [["id", 1]]
    #<User id: 1, name: "あいうえお", email: "aiueokakikukeko@gmails.com", password_digest: "$2a$10$CzS7jLUYD1ZHWsMpLtkc.eE2YROaodJfg5m.O2fXSZZ...", created_at: "2016-12-16 00:47:55", updated_at: "2016-12-16 00:47:55"> 
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update Profile"
      redirect_to @user # ここを修正 。redirect_to user_path(@user)　と同じ
    else
      render 'edit'
    end
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

end

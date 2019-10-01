class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:edit, :update]}
  before_action :forbid_login_user,{only: [:new, :login, :create]}
  before_action :ensure_correct_user,{only: [:edit, :update]}

  def new
    @user = User.new
  end

  def create
      @user = User.new(name: params[:name], email: params[:email], password: params[:password])
      if @user.save
        flash[:notice] = "ユーザー登録が完了しました"
        session[:user_id] = @user.id
        redirect_to("/users/#{@user.id}")
      else
        render("users/new")
      end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      redirect_to("/date/input")
      session[:user_id] = @user.id
    else
      @error_message = "メールアドレスもしくはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("/users/login_form")
    end
  end

  # def login
  #     @user = User.find_by(email: params[:email],password: params[:password])
  #     if @user
  #       flash[:notice] = "ログインしました"
  #       redirect_to("/date/input")
  #       session[:user_id] = @user.id
  #     else
  #       @error_message = "メールアドレスもしくはパスワードが間違っています"
  #       @email = params[:email]
  #       @password = params[:password]
  #       render("/users/login_form")
  #     end
  # end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
    flash[:notice] = "ログアウトしました"
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      redirect_to("/users/#{@user.id}")
      flash[:notice] = "ユーザー情報を編集しました"
    else
      render("/users/edit")
    end
  end
  
end

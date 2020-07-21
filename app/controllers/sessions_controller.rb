class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def create_with_gmail
    response = request.env["omniauth.auth"]
    if (User.find_by(email: response[:info][:email]))
      flash[:success] = "dang nhap thanh cong bang email"
      log_in User.find_by(email: response[:info][:email])
      redirect_to root_url
    else
      random_password = User.new_token
      name = response[:info][:email].split("@")[0]
      user = User.new(name: name, email: response[:info][:email], avatar: response[:info][:image], activated: 1, password: random_password, password_confirmation: random_password)
      if user.save
        flash[:success] = "dang nhap thanh cong bang email"
        log_in user
        redirect_to root_url
      else
        flash[:danger] = "dang nhap khong thanh cong bang email"
        redirect_to login_path
      end
    end
  end

  def create_with_facebook
    response = request.env["omniauth.auth"]
    email = response[:extra][:raw_info][:id] + "@facebook.com"
    if (User.find_by(email: email))
      flash[:success] = "dang nhap thanh cong bang FaceBook"
      log_in User.find_by(email: email)
      redirect_to root_url
    else
      random_password = User.new_token
      name = response[:info][:name]
      email = response[:extra][:raw_info][:id] + "@facebook.com"
      user = User.new(name: name, email: email, avatar: response[:info][:image], activated: 1, password: random_password, password_confirmation: random_password)
      if user.save
        flash[:success] = "dang nhap thanh cong bang FaceBook"
        log_in user
        redirect_to root_url
      else
        flash[:danger] = "dang nhap khong thanh cong bang FaceBook"
        redirect_to login_path
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

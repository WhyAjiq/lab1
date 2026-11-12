class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username]
    password = params[:password]
    authenticated = false

    File.foreach(Rails.root.join('Password.txt')) do |line|
      user, pass, role = line.chomp.split(',').map(&:strip)
      if user == username && pass == password
        authenticated = true
        break
      end
    end

    if authenticated
      session[:user_id] = username
      flash[:notice] = "Login successful! Welcome, #{username}."
      redirect_to root_path 
    else
      flash[:error] = "Invalid username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to login_path
  end
end
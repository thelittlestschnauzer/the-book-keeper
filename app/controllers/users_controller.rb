class UsersController < ApplicationController

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  get "/signup" do
    if !logged_in?
      erb :"/users/signup"
    else
      redirect to "/booklists"
    end
  end

  post "/signup" do
    @user = User.new(:username => params[:username], :email => params[:email], :password => [:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to "/booklists"
      else
        redirect to "/signup"
    end
  end

  get "/login" do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/booklists"
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/booklists"
    else
      redirect to "/signup"
    end
  end

  get "/logout"
    if loggin_in?
      session.destroy
      redirect to "/login"
    else
      redirect to "/"
    end
  end 
end

class TabusersController < ApplicationController
  def login
     uname=params[:tabuser][:uName]
     upass=params[:tabuser][:uPass]
     session[:tabuser]=nil
     user=Tabuser.find_by_uName_and_uPass(uname,upass)
    if user
      session[:tabuser]=user
      session[:tabuserId]=user.id
      @tabuser=session[:tabuser]
      redirect_to :action=>"index",:controller=>"tabflowers"
    else
      session[:tabuser]=nil
      flash[:notice]="denglushibai!"
    end
  end

  def register
  end

  def registerUser
    @new_user=Tabuser.new()
    @new_user.uName=params[:tabuser][:name]
    @new_user.uPass=params[:tabuser][:pass]
    @new_user.uTname=params[:tabuser][:tname]
    @new_user.uAddress=params[:tabuser][:address]
    @new_user.uCode=params[:tabuser][:code]
    @new_user.uPhone=params[:tabuser][:phone]
    @new_user.uEmail=params[:tabuser][:email]
    @new_user.uAddressType=params[:tabuser][:type]
    if @new_user.save
      redirect_to :action=>"register"
      flash[:notice]="恭喜您"+@new_user.uName+"，会员注册成功!"    
    end
  end

  def exit
    session[:tabuser]=nil
    redirect_to :action=>"index",:controller=>"tabflowers"
  end
end

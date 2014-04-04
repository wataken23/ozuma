# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  skip_before_filter :check_logined, :only => ['newext', 'createext']
  before_filter :edit_check, :only => ['new', 'create', 'edit', 'destroy', 'acception']
  before_filter :mypage_check, :only => ['mypage', 'chpass', 'show']

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @roles = Role.all
    @role = Hash::new
    @roles.each do |role|
      @role["#{role.id}"] = role.position 
    end
    @user_waiting = User.find(:all, :conditions => {:acception => 'f', :owner => current_user.account.to_s} )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @role = Role.find(@user.role_id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @role = Role.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def newext
    @user = User.new
    @role = Role.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
#    @role = Role.find(@user.role_id)
    @role = Role.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @role = Role.all
    @user.acception = 't'
#    respond_to do |format|
      if @user.save
#        @repbody = @user.create_repbody( :user_id => @user.id )
        redirect_to users_path, :notice => '【メッセージ】ユーザは正しく作成されました.'
        #        format.html { redirect_to @user, notice: 'User was successfully created.' }
        #        format.json { render json: @user, status: :created, location: @user }
#render "new"
      else
        render "new"
        #        format.html { render action: "new" }
        #        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  def createext
    @user = User.new(params[:user])
    @role = Role.all
    @owner = User.find_by_account(@user.owner)
    @user.acception = 'f'
    @user.role_id = 4
#    @user.role_id = 925085493

#    respond_to do |format|
      if @user.save
#        @repbody = @user.create_repbody( :user_id => @user.id )
#        mail = Usermail.newuser(@owner.username, @user.username, @owner.email, @user.email)
#        mail.deliver
        render 'accept'
      else
        render 'newext'
      end
    end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: '【メッセージ】ユーザ情報は正しく更新されました.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def mypage
    @user = User.find(params[:id])
    @roles = Role.all
#    @role = Role.find(@user.role_id)
    @role = Hash.new
    @roles.each do |role|
      @role["#{role.id}"] = role.position 
    end

#    if current_user.id.to_i == params[:id].to_i
    respond_to do |format|
      format.html # mypage.html.erb
      format.json { render json: @user }
#      end
    end
  end

  def chpass
    @user = User.find(params[:id])
#    @role = Role.find(@user.role_id)
    @role = Role.all
  end

  def acception
    @user = User.find(params[:id])
    @user.acception = 't'
    @owner = User.find_by_account(@user.owner)
    respond_to do |format|
      if @user.save
        mail = Usermail.accepteduser(@owner.username, @user.username, @owner.email, @user.email)
        mail.deliver
        format.html { redirect_to users_url, notice: '【メッセージ】ユーザを承認しました' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def edit_check
    @roles = Role.all
    @role = Hash.new
    @roles.each do |role|
      @role["#{role.id}"] = role.position 
    end
    if @role["#{current_user.role_id}"] == '受講生' 
      redirect_to mypage_path(current_user.id) , :notice => "【警告】#{request.path}にはアクセスできません. だめです." 
    end 
  end 
  def mypage_check
    @roles = Role.all
    @role = Hash.new
    @roles.each do |role|
      @role["#{role.id}"] = role.position 
    end
    if current_user.id.to_i != params[:id].to_i && @role["#{current_user.role_id}"] == '受講生' 
      redirect_to mypage_path(current_user.id) , :notice => "【警告】#{request.path}にはアクセスできません. 悪いこと考えますね." 
    end 
  end 


end

# -*- coding: utf-8 -*-
class AccountsController < ApplicationController

  # GET '/login'
  def login
    @account = Account.new

    respond_to do |format|
      format.html # login.html.erb
      format.json { render json: @account }
    end
  end

  # POST '/login'
  def authenticate
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.authenticate
        format.html { redirect_to memos_url }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "login" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end
end

class BankAccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bank_account, only: [:edit, :update]
  
    def new
      @bank_account = current_user.build_bank_account
    end
  
    def create
      @bank_account = current_user.build_bank_account(bank_account_params)
      if @bank_account.save
        redirect_to profile_path, notice: 'Bank account was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @bank_account.update(bank_account_params)
        redirect_to profile_path, notice: 'Bank account was successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def set_bank_account
      @bank_account = current_user.bank_account
    end
  
    def bank_account_params
      params.require(:bank_account).permit(:bank_name, :account_number)
    end
  end
  
class BankAccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bank_account

    def index
      @bank_accounts = current_user.bank_accounts
    end
  
    def show
    end

    def new
      @bank_account = current_user.build_bank_account
    end
  
    def create
      @bank_account = current_user.build_bank_account(bank_account_params)
      if @bank_account.save
        redirect_to payment_methods_path, notice: 'Bank account was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @bank_account = current_user.bank_account
    end
  
    def update
      if @bank_account.update(bank_account_params)
        redirect_to payment_methods_path, notice: 'Bank account was successfully updated.'
      else
        render :edit
      end
    end
  

    private
  
    def set_bank_account
      @bank_account = current_user.bank_account
    end
  
    def bank_account_params
      params.require(:bank_account).permit(:bank_name,:iban, :swift_code, :account_number)
    end
  end
  
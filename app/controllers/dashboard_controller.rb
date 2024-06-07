class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @answered_surveys = current_user.surveys.distinct
    end

    def payment_methods
      @bank_account = current_user.bank_account
      @wallet = current_user.wallet
    end
    
end

# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_transaction, only: [:show]
  
    def index
      @transactions = current_user.sent_transactions + current_user.received_transactions
    end
  
    def show
    end
  
    def new
      @transaction = Transaction.new
    end
  
    def create
      @transaction = Transaction.new(transaction_params)
      @transaction.sender = current_user
  
      if params[:transaction][:transaction_type] == 'pay_for_survey'
        handle_pay_for_survey
      elsif params[:transaction][:transaction_type] == 'answer_survey'
        handle_answer_survey
      else
        flash[:alert] = 'Invalid transaction type'
        render :new
        return
      end
    end
  
    private
  
    def handle_pay_for_survey
      if current_user.bank_account || current_user.wallet
        if params[:transaction][:payment_method] == 'bank_account' && current_user.bank_account.present?
          process_transaction(@transaction, current_user.bank_account)
        elsif params[:transaction][:payment_method] == 'wallet' && current_user.wallet.present?
          process_transaction(@transaction, current_user.wallet)
        else
          flash[:alert] = 'Invalid payment method'
          render :new
        end
      else
        flash[:alert] = 'User must have a bank account or wallet'
        render :new
      end
    end
  
    def handle_answer_survey
      if current_user.admin?
        if params[:transaction][:payment_method] == 'bank_account' && @transaction.receiver.bank_account.present?
          process_transaction(@transaction, @transaction.receiver.bank_account)
        elsif params[:transaction][:payment_method] == 'wallet' && @transaction.receiver.wallet.present?
          process_transaction(@transaction, @transaction.receiver.wallet)
        else
          flash[:alert] = 'Invalid payment method'
          render :new
        end
      else
        flash[:alert] = 'Only admins can pay for answered surveys'
        render :new
      end
    end
  
    def process_transaction(transaction, payment_method)
      ActiveRecord::Base.transaction do
        if payment_method.is_a?(BankAccount)
          # Process bank account transaction logic here
        elsif payment_method.is_a?(Wallet)
          if transaction.sender == current_user
            payment_method.withdraw(transaction.amount)
          elsif transaction.receiver == current_user
            payment_method.deposit(transaction.amount)
          end
        end
        transaction.save!
      end
  
      flash[:notice] = 'Transaction was successfully created.'
      redirect_to transaction_path(transaction)
    rescue ActiveRecord::RecordInvalid
      flash[:alert] = 'Transaction failed'
      render :new
    end
  
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
  
    def transaction_params
      params.require(:transaction).permit(:receiver_id, :amount, :transaction_type, :payment_method)
    end
  end
  
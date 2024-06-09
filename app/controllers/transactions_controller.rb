# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.order(created_at: :desc)
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    @transaction.survey = Survey.find(params[:transaction][:survey_id])
    @transaction.amount = @transaction.survey.reward
    @transaction.status = 'completed'
    if @transaction.save
      # Update user's wallet or bank account balance
      if @transaction.payment_method == 'wallet'
        current_user.wallet.update(balance: current_user.wallet.balance + @transaction.amount)
      elsif @transaction.payment_method == 'bank'
        # Update bank account balance logic here
      end
      render json: { success: true }, status: :ok
    else
      render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payment_method, :survey_id)
  end
end

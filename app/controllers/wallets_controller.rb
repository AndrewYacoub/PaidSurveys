# app/controllers/wallets_controller.rb
class WalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wallet, only: [:edit, :update, :destroy]

  def new
    @wallet = current_user.build_wallet
  end

  def create
    @wallet = current_user.build_wallet(wallet_params)
    if @wallet.save
      redirect_to payment_methods_path, notice: 'Wallet was successfully created.'
    else
      render :new
    end
  end


  def edit
  end

  def update
    if @wallet.update(wallet_params)
      redirect_to payment_methods_path, notice: 'Wallet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @wallet.destroy
    redirect_to payment_methods_path, notice: 'Wallet was successfully deleted.'
  end

  private

  def set_wallet
    @wallet = current_user.wallet
  end

  def wallet_params
    params.require(:wallet).permit(:wallet_number, :provider)
  end
end

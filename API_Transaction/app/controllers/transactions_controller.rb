require 'uri'
require 'net/http'
class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show destroy ]
  # before_action :convert, only: %i[  ]

  # GET /transactions
  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    sender = User.find(@transaction.sender_id)

    # Verificar que el usuario que envía tiene suficiente en su wallet
    balance_validation = !sender.validate_balance(@transaction.coin_to_send, @transaction.amount_to_send)
    if balance_validation
      render json: { error: 'Balance insuficiente' }, status: 400
    else
      if @transaction.save
        render json: @transaction, status: :created, location: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy!
  end

  def convert
    url = URI("https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["x-cg-demo-api-key"] = 'CG-VHP6bnz5YWxJcGGpEJiJUiw7'

    response = http.request(request)
    response = JSON.parse(response.read_body)
    @usd_convert = response['bitcoin']['usd']
    render json: response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.expect(transaction: [ :coin_to_send, :coin_to_receive, :amount_to_send, :amount_to_receive, :sender_id, :receiver_id ])
    end
end

require 'uri'
require 'net/http'
class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show destroy ]
  before_action :convert, only: %i[ create ]

  # GET /transactions
  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  # GET /transactions/1
  def show
    # render json: @transaction
    render json: {
      transaction: {
        sender: {
          id: @transaction.sender_id,
          name: @transaction.sender.name
        },
        receiver: {
          id: @transaction.receiver_id,
          name: @transaction.receiver.name
        },
        coin_to_send: @transaction.coin_to_send,
        coin_to_receive: @transaction.coin_to_receive,
        amount_to_send: @transaction.amount_to_send,
        amount_to_receive: @transaction.amount_to_receive
      }
    }
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
      coin_to_send = @transaction.coin_to_send
      coin_to_receive = @transaction.coin_to_receive
      amount_to_send = @transaction.amount_to_send

      # Es posible hacer una transferencia de la misma moneda
      if coin_to_send == coin_to_receive
        @transaction.amount_to_receive = amount_to_send
      
      # Si la moneda que se envía es diferente a la que se recibe, hay que hacer la conversión
      # Y usar la API CoinGecko
      else
        if coin_to_receive == 'btc'
          # Para convertir de usd a btc se multiplica la cantidad que se envía por 1 entre el valor de conversión
          @transaction.amount_to_receive = amount_to_send * (1.0 / @usd_convert)
        else
          # Para convertir de btc a usd se multiplica la cantidad que se envía por el valor de conversión
          @transaction.amount_to_receive = amount_to_send * @usd_convert
        end
      end

      if @transaction.save
        # Update de wallet de sender
        sender.update_wallet(coin_to_send, true, amount_to_send)
        # Update de wallet de receiver
        @transaction.receiver.update_wallet(coin_to_receive, false, @transaction.amount_to_receive)

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

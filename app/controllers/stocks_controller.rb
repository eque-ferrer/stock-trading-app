class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_api

  def search
    @stock = Stock.new
  end

  def create
    @quote = @client.quote(stock_params)
    @stock = Stock.find_or_create_by(symbol: params[:symbol],
                                    name: @client.company(stock_params).company_name)
    @stock.current_price = @quote.latest_price  
    if @stock.save
      redirect_to stocks_show_path(@stock)
    else
      render :search
    end
  end
  
  def show
    @stock = Stock.find(stock_id)
  end

  def add
    @stock = Stock.find(stock_id)
    @stock.users << current_user
    @stock.save
    redirect_to stocks_show_path(@stock)  
  end

  private 

  def get_api
    @client = IEX::Api::Client.new(
      publishable_token: ENV['PUBLISHABLE_TOKEN'],
      secret_token: ENV['SECRET_TOKEN'],
      endpoint: 'https://sandbox.iexapis.com/v1' #'https://cloud.iexapis.com/v1'
    )
  end

  def stock_params
    params[:symbol]
  end

  def stock_id
    params[:id]
  end

  def has_stock?
    @stock = Stock.find(stock_id)
    current_user.stocks.include?(@stock)
  end
end

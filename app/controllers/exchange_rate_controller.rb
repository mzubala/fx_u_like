require 'exchange_rate'

class ExchangeRateController < ApplicationController

  def index
    set_exchange_params
    @currencies = ExchangeRate.currencies
    @rate = ExchangeRate.at(@exchange_params[:date], @exchange_params[:from_currency], @exchange_params[:to_currency])
    unless @rate.nil?
      @value = @exchange_params[:amount].to_f * @rate
    else
      @notice = "No #{@exchange_params[:from_currency]}/#{@exchange_params[:to_currency]} rate for #{@exchange_params[:date].to_s}"
    end
  end

  private

  def set_exchange_params
    @exchange_params = params[:exchange] || {
      from_currency: "USD",
      to_currency: "GBP",
      amount: 100,
      date: Time.zone.now.to_date
    }
    parse_date
  end

  def parse_date
    if @exchange_params["date(1i)"]
      @exchange_params[:date] = Date.parse("#{@exchange_params["date(1i)"]}-#{@exchange_params["date(2i)"]}-#{@exchange_params["date(3i)"]}")
    end
  end


end

require 'spec_helper'

describe ExchangeRateController do

  let(:value) { 999.0 }

  describe "GET index" do

    it "should calculate default exchange rate" do
      ExchangeRate.should_receive(:at).with(Time.zone.now.to_date, "USD", "GBP").and_return(value)
      get :index
      exchange_params = assigns(:exchange_params)
      exchange_params.should_not be_nil
      exchange_params.should == {
        "from_currency" => "USD",
        "to_currency" => "GBP",
        "amount" => 100,
        "date" => Time.zone.now.to_date
      }
      assigns(:value).should == value * exchange_params["amount"]
    end

  end

  describe "POST index" do

    let(:exchange_params) do
      {
        "from_currency" => "PLN",
        "to_currency" => "EUR",
        "amount" => "200",
        "date(1i)" => "2013",
        "date(2i)" => "01",
        "date(3i)" => "02"
      }
    end

    let(:date) { Date.parse("2013-01-02") }

    it "should calculate exchange rate based on params" do
      ExchangeRate.should_receive(:at).with(date, "PLN", "EUR").and_return(value)
      post :index, exchange: exchange_params
      assigns(:value).should == value * exchange_params["amount"].to_i
      assigns(:exchange_params).should == exchange_params.merge("date" => date)
    end

    it "should show assign notice when no rate for a given date" do
      ExchangeRate.should_receive(:at).with(date, "PLN", "EUR").and_return(nil)
      post :index, exchange: exchange_params
      assigns(:value).should be_nil
      assigns(:notice).should == "No PLN/EUR rate for #{date.to_s}"
    end

  end

end
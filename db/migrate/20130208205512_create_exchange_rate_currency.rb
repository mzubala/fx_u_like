class CreateExchangeRateCurrency < ActiveRecord::Migration
  def self.up
    create_table :exchange_rate_currency do |t|
      t.string :code
      t.timestamps
    end
  end

  def self.down
    drop_table :exchange_rate_currency
  end
end
class CreateExchangeRateEurRate < ActiveRecord::Migration
  def self.up
    create_table :exchange_rate_eur_rate do |t|
      t.integer :currency_id
      t.float :rate
      t.date :rate_date
      t.timestamps
    end
  end

  def self.down
    drop_table :exchange_rate_eur_rate
  end
end
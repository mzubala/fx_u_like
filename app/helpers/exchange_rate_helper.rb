module ExchangeRateHelper

  def money_s v, curr = nil
    "#{sprintf("%.4f", v)} #{curr}"
  end

end

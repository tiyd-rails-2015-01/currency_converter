class CurrencyConverter
  attr_reader :conversion_rates

  def initialize
    #conversion rates from USD
    @conversion_rates = { :usd => 1.00,
      :eur => 0.86589,
      :gbp => 0.66039,
      :inr => 61.7156,
      :aud => 1.22469,
      :cad => 1.21076,
      :zar => 11.5976,
      :nzd => 1.30916,
      :jpy => 118.565}
      #usd / 1 = eur / 0.86
  end
end

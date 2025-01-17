module PlayersHelper
  SUITS = %w[clubs diamonds hearts spades].freeze

  def random_suit
    SUITS[Random.rand(4)]
  end
end

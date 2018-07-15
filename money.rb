class Money
  def initialize
  @level = 0
  @money = {
    0 => "$100",
    1 => "$200",
    2 => "$300",
    3 => "$500",
    4 => "$1,000",
    5 => "$2,000",
    6 => "$4,000",
    7 => "$8,000",
    8 => "$16,000",
    9 => "$32,000",
    10 => "$64,000",
    11 => "$125,000",
    12 => "$250,000",
    13 => "$500,000",
    14 => "$1,000,000"
  }
  end

  def get_money
    puts "You've won #{@money[@level]}"
    @level += 1
  end

  def purse_value
    @money[@level]
  end

  def increment_value
    @level += 1
  end
end

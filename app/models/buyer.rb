class Buyer < ActiveRecord::Base
  def buyer_number
    self.id + 100
  end
end

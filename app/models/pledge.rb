class Pledge < ActiveRecord::Base
  belongs_to :buyer

  before_save :validate_buyer

  def self.total_for_buyer(buyer)
    Pledge.where(:buyer_id => buyer.id).sum(:amount)
  end

  private

  def validate_buyer
    buyer = Buyer.find_by_id(self.buyer_id-100)
    if buyer
      self.buyer = buyer
      return true
    else
      errors.add(:buyer, "doesn't exist")
      return false
    end
  end
end

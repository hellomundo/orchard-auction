class Pledge < ActiveRecord::Base
  belongs_to :buyer
  validates :buyer_number, :amount, :presence => true

  def self.event_total_for_buyer(event, buyer)
    where(event_id: event.id, buyer_id: buyer.id).sum(:amount)
  end

  def self.by_event(event)
    where(event_id: event.id)
  end

  def buyer_number=(buyer_num)
    buyer = Buyer.find_by_buyer_number(buyer_num)
    if buyer
      self.buyer = buyer
    else
      errors.add(:buyer, "doesn't exist")
    end
  end

  def buyer_number
    self.buyer.present? ? self.buyer.buyer_number : nil
  end

end

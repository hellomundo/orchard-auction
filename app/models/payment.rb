class Payment < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :event

  enum form: {
      cash: 0,
      check: 1,
      credit: 2
    }


  def self.event_total_for_buyer(event, buyer)
    where(event_id: event.id, buyer_id: buyer.id).sum(:amount)
  end

end

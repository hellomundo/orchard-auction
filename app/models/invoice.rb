class Invoice < ActiveRecord::Base
  belongs_to :invoice_status

  has_many :pledges
  has_many :wins

  before_create :initialize_order_status
  before_save :calculate_subtotal

  enum status: {
      unpaid: 0,
      paid: 1
    }

  private

  initialize_order_status
    self.status = :unpaid
  end

  calculate_subtotal
    # add up wins
    # add up pledges
    self.subtotal = 0
  end

end

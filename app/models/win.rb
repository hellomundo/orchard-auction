class Win < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :lot
  # belongs_to :winnable, polymorphic: true

  before_save :validate_single_owner, :validate_lot, :validate_buyer

  def self.total_for_buyer(buyer)
    Win.where(:buyer_id => buyer.id).sum(:price)
  end

  private

    def validate_lot
      lot = Lot.find_by_id(self.lot_id-100)
      if lot
        self.lot = lot
        return true
      else
        # error
        errors.add(:lot, "doesn't exist.")
        return false
      end
    end

    def validate_single_owner
      win = Win.where(:lot_id => self.lot_id-100)
      if win.count > 0
        # This lot has been won before
        if win.count >= win.first.lot.quantity_available
          errors.add(:lot, "This lot has already been won.")
          return false
        end
      end
      return true
    end

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

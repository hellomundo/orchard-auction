class Win < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :item

  before_save :validate_single_owner, :validate_item, :validate_buyer

  def self.total_for_buyer(buyer)
    Win.where(:buyer_id => buyer.id).sum(:price)
  end

  private

    def validate_item
      item = Item.find_by_id(self.item_id)
      if item
        # self.item = item
        return true
      else
        # error
        errors.add(:item, "doesn't exist.")
        return false
      end
    end

    def validate_single_owner
      item = Win.where(:item_id => self.item_id)
      if item.count > 0
        errors.add(:item, "This item has already been won.")
        return false
      end
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

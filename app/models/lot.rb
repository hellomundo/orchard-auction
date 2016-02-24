class Lot < ActiveRecord::Base
  has_many :items, dependent: :nullify
  # has_one :win, as: :winnable
  has_one :win #, as: :winnable
  has_one :buyer, through: :wins

  #should do this on save
  def calculated_fmv
    if(self.items.size > 0)
      self.items.sum(:fmv)
    else
      0
    end
  end

  def opening_price
    self[:opening_price] || calculate_opening
  end

  def bid_increment
    self[:opening_price] || calculate_increment
  end

  def lot_number
    self.id + 100
  end

  def description
    if self[:description].blank?
      if self.items.blank?
        return nil
      else
        return self.items.first.description
      end
    end
  end

  def name
    if self[:name].blank?
      if self.items.blank?
        return nil
      else
        return self.items.first.name
      end
    else
      return read_attribute(:name)
    end
  end

  private

  def calculate_opening
    (calculated_fmv * 0.25 / 5.0).floor * 5.0
  end

  def calculate_increment
    if(calculated_fmv > 0)
      # round down to the nearest 5
      increment = (calculated_fmv * 0.1 / 5.0).floor * 5.0
      increment = increment < 5.0 ? 5.0 : increment
    else
      increment = 0
    end

    increment
  end
end

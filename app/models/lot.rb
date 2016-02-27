class Lot < ActiveRecord::Base
  has_many :items, dependent: :nullify
  # has_one :win, as: :winnable
  has_one :win #, as: :winnable
  has_one :buyer, through: :wins

  before_save :default_values

  #should do this on save
  def calculated_fmv
    if(self.items.size > 0)
      self.items.sum(:fmv)
    else
      0
    end
  end

  def calculated_opening_price
    self.opening_price || calculate_opening
  end

  def calculated_bid_increment
    self.opening_price || calculate_increment
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


  def self.to_csv
    attributes = %w{id name description fmv calculated_opening_price calculated_bid_increment table_number items }

    CSV.generate do |csv|
      csv << attributes
      all.each do |lot|
        if lot.items.any?
          row = [lot.lot_number, lot.name, lot.description, lot.calculated_fmv, lot.calculated_opening_price, lot.calculated_bid_increment, lot.table_number ]
          other = lot.items.collect { |o| o.name }.join("\n")
          row << other
          csv << row
        else
          csv << [lot.lot_number, lot.name, lot.description, lot.calculated_fmv, lot.calculated_opening_price, lot.calculated_bid_increment, lot.table_number, nil ]
        end
      end
    end
  end

  private

  def default_values
    self.quantity_available ||= 1
  end

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

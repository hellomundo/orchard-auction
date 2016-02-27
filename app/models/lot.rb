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

  def calculated_description
    if self.description.blank?
      if self.items.blank?
        return nil
      else
        return self.items.first.description
      end
    else
      return self.description
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
    attributes = %w{id name description fmv opening_price bid_increment table_number items donor }

    CSV.generate do |csv|
      csv << attributes
      all.each do |lot|
        if lot.items.any?
          row = [lot.lot_number, lot.name, lot.calculated_description, lot.calculated_fmv, lot.calculated_opening_price, lot.calculated_bid_increment, lot.table_number ]
          items = lot.items.collect { |o| o.name + " ($" + sprintf('%02.f', o.fmv) + ") from " + o.donor.company }.join("\n")

          if lot.items.count == 1
            # there is only one donor
            donor = lot.items.first.donor.company
          else
            donor = nil
          end
        else
          row = [lot.lot_number, lot.name, lot.calculated_description, lot.calculated_fmv, lot.calculated_opening_price, lot.calculated_bid_increment, lot.table_number ]
          items = nil
          donor = nil
        end
        row << items
        row << donor
        csv << row
      end
    end
  end

  private

  def default_values
    self.quantity_available ||= 1
  end

  def calculate_opening
    (calculated_fmv * 0.40 / 5.0).floor * 5.0
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

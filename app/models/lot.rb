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
    self.bid_increment || calculate_increment
  end

  def lot_number
    self.id + 100
  end

  def default_bin
    # buy it now price is 75% of FMV
    bin = (calculated_fmv * 0.75 / 5.0).floor * 5.0;
    # if the calculated bin = fmv, then make it $5 less
    # bin == calculated_fmv ? calculated_fmv - 5.0 : bin
  end

  def has_been_won
    # bad code - Lot has to know about Win
    return Win.where(:lot_id => self.id).exists?
  end

  def winner
    if has_been_won
      my_win.buyer
    end
  end

  def my_win
    if has_been_won
      return Win.where(:lot_id => self.id).first
    end
  end

  def winning_price
    if has_been_won
      my_win.price
    end
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

  def item_list
    items.collect { |o| o.name + " ($" + sprintf('%02.f', o.fmv) + ") from " + o.donor.company }.join(", ")
  end

  def donor_list
    items.collect { |i| i.donor.company }.join(", ")
  end

  def self.to_csv
    attributes = %w{id name description fmv buy_now_price opening_price bid_increment table_number items donor }

    CSV.generate do |csv|
      csv << attributes
      all.each do |lot|
        if lot.items.any?
          row = [lot.lot_number, lot.name, lot.calculated_description, lot.calculated_fmv, lot.buy_now_price, lot.calculated_opening_price, lot.calculated_bid_increment, lot.table_number ]
          items = lot.items.collect { |o| o.name + " ($" + sprintf('%02.f', o.fmv) + ") from " + o.donor.company }.join(", ")

          if lot.items.count == 1
            # there is only one donor
            donor = lot.items.first.donor.company
          else
            donor = lot.items.collect { |i| i.donor.company }.join(", ")
          end
        else
          row = [lot.lot_number, lot.name, lot.calculated_description, lot.calculated_fmv, lot.buy_now_price, lot.calculated_opening_price, lot.calculated_bid_increment, lot.table_number ]
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

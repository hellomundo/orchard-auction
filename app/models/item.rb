require 'csv'

class Item < ActiveRecord::Base
  include ItemCategories
  include ItemFormats

  belongs_to :donor
  belongs_to :event
  belongs_to :lot

  # add parent_id to migration
  #t.references :parent, index: true
  #belongs_to :parent, :class_name => 'Item'
  #has_many :children, :class_name => 'Item', :foreign_key => :parent_id
  #
  # or... has_ancestry

  # enum format: { "physical" => 0, "gift" => 1 }
  # enum category: {"Art" => 0,
  #                 "Event/Experience" => 1,
  #                 "Activity/Class" => 2,
  #                 "Tickets for Family Activity" => 3,
  #                 "Wine/Spirits" => 4,
  #                 "Wellness/Beauty" => 5,
  #                 "Accommodations" => 6,
  #                 "Apparel/Accessories" => 7,
  #                 "Jewelry" => 8,
  #                 "Home and Garden" => 9,
  #                 "Furniture" => 10,
  #                 "Electronics/Technology" => 11,
  #                 "Gift Basket" => 12,
  #                 "Food/Beverages" => 13,
  #                 "Dining" => 14,
  #                 "Sports/Recreation Equipment" => 15,
  #                 "Toys/Games/Books for Family" => 16 }

  def self.to_csv
    attributes = %w{name description fmv donor_id format opening_price category restrictions}
    CSV.generate do |csv|
      csv << attributes
      all.each do |item|
        csv << item.attributes.values_at(*attributes)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # only fill certain rows
      d = Item.new ({  :name => row['name'],
                        :description => row['description'],
                        :fmv => row['fmv'],
                        :donor_id => row['donor_id'],
                        :format => row['format'].to_i,
                        :opening_price => row['opening_price'],
                        :category => row['category'].to_i,
        })
      # check to see if donor has donated before
      d.save
    end
  end

  def self.all_for_event(event)
  end

  def self.all_for_donor_and_event(donor, event)
  end

end

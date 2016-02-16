class Item < ActiveRecord::Base
  belongs_to :donor
  belongs_to :lot
  has_one :win
  has_one :buyer, through: :wins

  # add parent_id to migration
  #t.references :parent, index: true
  #belongs_to :parent, :class_name => 'Item'
  #has_many :children, :class_name => 'Item', :foreign_key => :parent_id
  #
  # or... has_ancestry

  enum format: { "physical" => 0, "gift" => 1 }
  enum category: {"Art" => 0,
                  "Event/Experience" => 1,
                  "Activity/Class" => 2,
                  "Tickets for Family Activity" => 3,
                  "Wine/Spirits" => 4,
                  "Wellness/Beauty" => 5,
                  "Accommodations" => 6,
                  "Apparel/Accessories" => 7,
                  "Jewelry" => 8,
                  "Home and Garden" => 9,
                  "Furniture" => 10,
                  "Electronics/Technology" => 11,
                  "Gift Basket" => 12,
                  "Food/Beverages" => 13,
                  "Dining" => 14,
                  "Sports/Recreation Equipment" => 15 }

end

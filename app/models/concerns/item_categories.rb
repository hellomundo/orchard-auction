module ItemCategories
  extend ActiveSupport::Concern

  included do
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
                    "Sports/Recreation Equipment" => 15,
                    "Toys/Games/Books for Family" => 16 }
  end
end

class Item < ActiveRecord::Base
  belongs_to :donor
  belongs_to :lot

  enum format: { "physical" => 0, "gift" => 1 }

end

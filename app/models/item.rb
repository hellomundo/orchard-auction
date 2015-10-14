class Item < ActiveRecord::Base
  belongs_to :donor
  belongs_to :lot
end

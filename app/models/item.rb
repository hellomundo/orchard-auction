class Item < ActiveRecord::Base
  belongs_to :donor
  belongs_to :lot

  # add parent_id to migration
  #t.references :parent, index: true
  #belongs_to :parent, :class_name => 'Item'
  #has_many :children, :class_name => 'Item', :foreign_key => :parent_id
  #
  # or... has_ancestry
  
  enum format: { "physical" => 0, "gift" => 1 }

end

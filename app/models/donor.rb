class Donor < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :items, dependent: :destroy
  
  enum status: { "uncalled" => 0, "called" => 1, "needs_callback" => 2, "opted_out" => 3, "donated" => 4 }
end

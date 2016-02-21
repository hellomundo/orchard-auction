class Buyer < ActiveRecord::Base

  has_many :wins
  has_many :items, through: :wins

  validates :first_name, :last_name, :presence => true

  def buyer_number
    self.id + 100
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def reverse_name
    self.last_name + ", " + self.first_name
  end
end

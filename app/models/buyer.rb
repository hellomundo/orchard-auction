class Buyer < ActiveRecord::Base

  has_many :wins , dependent: :destroy
  has_many :lots, through: :wins
  has_many :pledges

  validates :first_name, :last_name, :presence => true

  def buyer_number
    self.id + 100
  end

  def total_wins
    Win.total_for_buyer(self)
  end

  def total_pledges
    Pledge.total_for_buyer(self)
  end

  def total_purchase
    self.total_wins + self.total_pledges
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def reverse_name
    self.last_name + ", " + self.first_name
  end

  def toggle_paid
    update_attribute(:is_paid, !self.is_paid)
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # only fill certain rows
      d = Buyer.new ({  :first_name => row['first_name'],
                        :last_name => row['last_name'],
                        :telephone => row['telephone'],
                        :guests => row['guests']
        })
      d.save
    end
  end

end

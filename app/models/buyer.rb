class Buyer < ActiveRecord::Base

  has_many :wins , dependent: :destroy
  has_many :lots, through: :wins
  has_many :pledges
  has_many :payments

  validates :first_name, :last_name, :presence => true

  def buyer_number
    self.id + 100
  end

  def event_wins(event)
    wins.where(event_id: event.id)
  end

  def event_pledges(event)
    pledges.where(event_id: event.id)
  end

  def event_total_wins(event)
    Win.event_total_for_buyer(event, self)
  end

  def event_total_pledges(event)
    Pledge.event_total_for_buyer(event, self)
  end

  def event_payments(event)
    payments.where(event_id: event.id)
  end

  def event_total_purchase(event)
    self.event_total_wins(event) + self.event_total_pledges(event)
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

  def self.find_by_buyer_number(buyer_num)
    begin
      Buyer.find_by_id(buyer_num.to_i - 100)
    rescue ActiveRecord::RecordNotFound
      nil
    end
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

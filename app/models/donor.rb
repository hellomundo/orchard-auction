class Donor < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :items, dependent: :destroy
  
  enum status: { "uncalled" => 0, "called" => 1, "needs_callback" => 2, "opted_out" => 3, "donated" => 4 }
  
  def self.to_csv
    attributes = %w{company first_name last_name phone address1 address2 state zip has_donated}
    CSV.generate do |csv|
      csv << attributes
      all.each do |donor|
        csv << donor.attributes.values_at(*attributes)
      end
    end
  end
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      d = Donor.new row.to_hash
      d.status = 0;
      d.save
    end
  end

end

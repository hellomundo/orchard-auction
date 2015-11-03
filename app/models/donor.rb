class Donor < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :items, dependent: :destroy

  enum status: { "uncalled" => 0, "called" => 1, "needs_callback" => 2, "opted_out" => 3, "donated" => 4 }

  def self.to_csv
    attributes = %w{company first_name last_name phone address1 address2 city state zip has_donated}
    CSV.generate do |csv|
      csv << attributes
      all.each do |donor|
        csv << donor.attributes.values_at(*attributes)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # only fill certain rows
      d = Donor.new ({  :company => row['company'],
                        :address1 => row['address'],
                        :city => row['city'],
                        :state => row['state'],
                        :zip => row['zip'],
                        :phone => row['phone'],
                        :website => row['website']
        })
      # check to see if donor has donated before
      if row['donated2013'] == 'x' or row['donated214'] == 'x'
        d.has_donated = true;
      end

      #set the status to 0 - fix this in the validations
      d.status = 0;
      d.save
    end
  end

end

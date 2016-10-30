class Donor < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :items, dependent: :destroy
  has_one :stage, class_name: "Status"

  enum status: { "uncalled" => 0, "called" => 1, "needs_callback" => 2, "opted_out" => 3, "donated" => 4 }

  def self.search_by_name(name)
    where("lower(company) LIKE ?", "%#{name.downcase}%")
  end

  def self.search_by_name_and_cat(name, cat)
    where(status: cat).where("lower(company) LIKE ?", "%#{name.downcase}%")
  end

  def self.filter_by_cat(cat)
    where(status: cat)
  end

  def self.for_event_at_stage(event_id, stage)
    joins(:stage).where('statuses.event_id = ? AND statuses.stage = ?', event_id, stage)
  end

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
                        :first_name => row['first_name'],
                        :last_name => row['last_name'],
                        :address1 => row['address1'],
                        :address2 => row['address2'],
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
      if row['has_donated' == "TRUE"]
        d.has_donated = true;
      end
      #set the status to 0 - fix this in the validations
      d.status = 0;
      d.save
    end
  end

  def items_for_event(event)
    self.items.where(event_id: event.id)
  end

  def contacts_for_event(event)
    self.contacts.where(event_id: event)
  end

  def set_stage(the_stage, event)
    s = my_status(event)
    s.stage = the_stage
    s.save
  end

  def get_stage(event)
    my_status(event).stage
  end

  private

  def my_status(event)
    s = Status.where(donor_id: id, event_id: event.id).first
    if s.blank?
      s = Status.create(donor_id: id, event_id: event.id)
    end
    return s
  end

end

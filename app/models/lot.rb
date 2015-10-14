class Lot < ActiveRecord::Base
  has_many :items
  
  def name 
    if read_attribute(:name).blank?
      if self.items.blank?
        return nil
      else
        return self.items.first.name
      end
    else 
      return read_attribute(:name)
    end
  end
end

class Lot < ActiveRecord::Base
  has_many :items
  
  #should do this on save
  def calculated_fmv
    if(self.items.size > 0)
      self.items.sum(:fmv)
    else
      0
    end
  end
  
  def lot_number
    self.id + 100
  end
  
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

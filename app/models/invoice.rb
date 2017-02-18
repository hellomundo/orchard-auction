class Invoice < ActiveRecord::Base
  belongs_to :invoice_status

  has_many :pledges
  has_many :wins

  private

end

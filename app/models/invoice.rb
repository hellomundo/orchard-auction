class Invoice < ActiveRecord::Base
  belongs_to :invoice_status
end

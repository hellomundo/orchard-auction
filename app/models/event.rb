class Event < ActiveRecord::Base
  has_many :items
  has_many :contacts
end

class Event < ActiveRecord::Base
  has_many :items
end

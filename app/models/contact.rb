class Contact < ActiveRecord::Base
  belongs_to :donor
  belongs_to :event
  belongs_to :user

  enum channel: { "phone" => 0, "email" => 1, "in_person" => 2, "social_media" => 3, "snail mail" => 4 }
end

class Status < ActiveRecord::Base
  belongs_to :donor

  enum stage: { "uncalled" => 0, "called" => 1, "needs_callback" => 2, "opted_out" => 3, "donated" => 4 }

end

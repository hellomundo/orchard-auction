module ItemFormats
  extend ActiveSupport::Concern

  included do
    enum format: { "physical" => 0, "gift" => 1 }
  end
end

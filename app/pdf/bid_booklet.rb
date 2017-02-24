class BidBooklet < BidSheet
  def initialize(view)
    super(view)
  end

  def build_document(lots)
    lots.each do |lot|
      header(lot)
      if lot.items.count > 1
        items(lot)
      else
        donor(lot)
      end
      grid(lot)
      #new page
      start_new_page
    end
  end
end

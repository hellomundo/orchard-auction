class BidSheet < Prawn::Document
  def initialize(view)
    super(right_margin: 342)
    @view = view

  end

  def build_sheet(lot)
    header(lot)
    if lot.items.count > 1
      items(lot)
    else
      donor(lot)
    end
    grid(lot)
  end

  def header(lot)
    # lot number align right
    text "##{lot.lot_number}", align: :right, size: 14, style: :bold
    # group number align right
    if(lot.table_number != nil)
      text "GROUP #{lot.table_number}", align: :right, size: 9
    end
    # name of Item
    move_down 12
    text "#{lot.name}", align: :left, size: 12, style: :bold
    # description
    move_down 6
    text "#{lot.calculated_description}", align: :left, size: 10
    # valued at
    move_down 6
    text "Valued at #{@view.number_to_currency(lot.calculated_fmv)}", align: :left, size: 10, style: :bold
  end

  def donor(lot)
    # donated by
    move_down 12
    text "DONATED BY:", align: :left, size: 9
    text "#{lot.donor_list}", size: 10
  end

  def items(lot)
    # items included
    move_down 12
    text "INCLUDED ITEMS:", align: :left, size: 9
    text "#{lot.item_list}", size: 10
  end

  def grid(lot)
    # remember the current location
    move_down 20
    myy = cursor
    move_down 12
    # figure out how much room we have left
    mytop = cursor
    myhalf = bounds.right / 2
    rep = ((mytop - bounds.bottom) / 24.0).floor
    mybot = mytop - rep * 24 + 24
    myline = mytop
    rep.times do
      horizontal_line 0, bounds.right, at: myline
      myline -= 24
    end
    # round down to the nearest cell height
    # draw three vertical lines, one on the left bounds, one on the right, and one in the middle
    line_width 0.5
    stroke_color "000000"

    stroke do
      vertical_line mytop, mybot, at: 0
      vertical_line mytop, mybot, at: myhalf
      vertical_line mytop, mybot, at: bounds.right
    end
    # draw the remaining horizontal rules
    # th bidder number above left column
    text_box "Bidder Number",
      at: [0, myy],
      height: 20,
      width: myhalf,
      align: :center,
      size: 10
    # th big increment above right column, align right
    text_box "Bid Increment: #{@view.number_to_currency(lot.calculated_bid_increment)}",
      at: [myhalf, myy],
      height: 20,
      width: myhalf,
      align: :right,
      size: 10
    # starting bid in first row
    text_box "#{@view.number_to_currency(lot.calculated_opening_price)}",
      at: [myhalf, myy - 20],
      height: 20,
      width: myhalf - 5,
      align: :right,
      size: 14
  end
end

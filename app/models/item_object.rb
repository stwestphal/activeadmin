class ItemObject < ApplicationRecord
  belongs_to :book
  belongs_to :item_type

  def myname
    Book.select{|i| i.id == book_id}.name
  end
end

class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :item_objects
  accepts_nested_attributes_for :item_objects, :allow_destroy => true

  # after_validation :price_sum_up

  def price_sum_up
    price=0
    book_id = self.id
    ite_array = ItemObject.select{|i| i.book_id==book_id}
    if ite_array.count == 0
      # binding.pry
      price= self.price
    else
      ite_array.each do |a|
        price+=a.netto_price
      end

    end


    price
  end

end

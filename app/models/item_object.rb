class ItemObject < ApplicationRecord

  belongs_to :book
  belongs_to :item_type

end

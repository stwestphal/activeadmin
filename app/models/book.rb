class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :item_objects
  accepts_nested_attributes_for :item_objects, :allow_destroy => true

end

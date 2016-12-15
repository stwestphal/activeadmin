class Author < ActiveRecord::Base

  has_many :books

  def to_s
    "#{first_name} #{last_name}"
  end

  def display_name
    "#{first_name} #{last_name}"
  end

end
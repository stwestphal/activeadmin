# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

humor = Genre.create! :name => "Humor"
gnovel = Genre.create! :name => "Graphic Novel"
crime = Genre.create! :name => "Crime"
fantasy = Genre.create! :name => "Fantasy"

collins = Author.create! :first_name => "Suzanne", :last_name => "Collins"
ohba = Author.create! :first_name => "Tsugumi", :last_name => "Ohba"

Book.create! :name => "The Hunger Games", :price => 20.00, :author => collins, :genre => fantasy
Book.create! :name => "Death Note", :price => 20.00, :author => ohba, :genre => crime

ItemType.create! :name => "Grundgebühr", :accounting_number => 7060110
ItemType.create! :name => "Einrichtungsgebühr", :accounting_number => 7060510
ItemType.create! :name => "Transaktionsumsatz", :accounting_number => 7060610
ItemType.create! :name => "nachträgliche Änderungen", :accounting_number => 7080550

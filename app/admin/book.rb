ActiveAdmin.register Book do
  permit_params  :name, :price, :author, :genre, :author_id, :genre_id
  #menu priority: 1
  #menu parent: "Authors"
#defines the generated html-colums:
  index do
    column :name
    column :author
    column :genre
    column :price
    actions
  end

end

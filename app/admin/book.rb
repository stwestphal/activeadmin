ActiveAdmin.register Book do
  permit_params  :name, :price, :author, :genre, :author_id, :genre_id, :id

  #menu priority: 1
  #menu parent: "Authors"

  # button:
  # action_item :view, only: :show do
  #   link_to book.name, publish_admin_post_path(post), method: :put
  # end

  the_path_to_aprove="books"

  action_item :view, only: :show do # or any page, where you need this button
    link_to 'Approve', the_path_to_aprove
  end


  member_action :approve, method: :post do
    if resource.approve
      redirect_to somewhere_path, notice: "This have been approved!"
    else
      redirect_to somewhere_else_path, alert: "Sorry, not all requirements were met for approving"
    end
  end

  # This code is evaluated within the controller class
  controller do
    def approve
    #... any logic here, for example:
      update(status: 'Approved')
    end
  end

  # defines the generated html-colums for index-page:
  index do
    column :name
    column :author
    column :genre
    column :price
    selectable_column
    actions
  end

 rows=""
  # ite =proc {ItemObject.distinct.pluck :item_type.to_s}
  ite =ItemObject.distinct.pluck :item_type, :netto_price
           ite.each do |a|
              rows+=a
           end
  # ite =ItemObject.select(:item_type)
  # rows = @book.item_objects
  # orders.select{ |o| o.customer.id == customer_id }
  # rows = ItemObject.select{ |i| i.book.id == book_id}
  # count = ItemObject.all.params[:ids].count

  # neues eigenes form fuer die view-funktion
  show do
    book_id = Book.find(params[:id]).id

    attributes_table do
      row :id
      row :name
      row :price
      row :author
      row :genre
      row "items" do
        table do
          (0..2).each do |r|
            tr do
              th ite.to_s
              td book_id
            end
          end
        end
      end

      row :created_at
      row :updated_at
    end
  end

  # eigenes form fuer new + edit-funktion
  form do |f|
    f.inputs "Details" do
      f.input :name, :label => "Title"
      f.action :submit, label: "Create Featured Product", url: "some_url_for_create(@product)"
    end
  end

end

ActiveAdmin.register Book do
  permit_params  :name, :price, :author, :genre, :author_id, :genre_id, :id, :order, :item_objects,
                 item_objects_attributes: [:id, :item_type_id, :netto_price, :amount, :position, :description, :_destroy]

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
  #ite = ItemObject.pluck :item_type_id, :book_id, :position, :netto_price, :amount, :description
  # ite =ItemObject.select(:item_type)
  # rows = @book.item_objects
  # orders.select{ |o| o.customer.id == customer_id }
  # rows = ItemObject.select{ |i| i.book.id == book_id}
  # count = ItemObject.all.params[:ids].count

  # neues eigenes form fuer die view-funktion
  show do
    book_id = Book.find(params[:id]).id
    ite = ItemObject.select{ |i| i.book_id == book_id}
    itemtype_id = 1
    itemtype = ItemType.select{ |i| i.id == itemtype_id}
    itemtype = ItemType.find(params[:id]).name
    ite = ite.pluck :item_type_id, :book_id, :position, :netto_price, :amount, :description
     ite.each do |a|
      rows+=a.to_s
    end

    attributes_table do
      row :id
      row :name
      row :price_sum_up
      row :author
      row :genre
      row :item_objects do |item|
        table_for item.item_objects.order("position").limit(10), sortable: true do
            column :position
            column :item_type_id
            column :netto_price
            column :description
            column :book
            column do |id|
              # "<a href='../item_objects/#{id.id.to_s}/edit'>edit</a>".html_safe
              # link_to id.id, item_object_path(id: id.id) #unless id.id.nil?
             link_to "edit",  edit_admin_item_object_path(id.id)
            end
        end
      end

      row "items" do
        table do
          ite.each do |r|
            tr do
              th r.to_s
              td itemtype.to_s
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
      # f.input :name, :label => "Title"
      f.input :id, :input_html => { :disabled => true }
      f.input :name
      f.input :price_sum_up
      f.input :author
      f.input :genre

      f.has_many :item_objects, allow_destroy: true, new_record: true do |a|
        a.input :id, :input_html => { :disabled => true }
        a.input :item_type
        a.input :netto_price
        a.input :amount
        a.input :position
        a.input :description
        # a.input :created_at, :input_html => { :disabled => true }, :as => :string
        # a.input :updated_at, :input_html => { :disabled => true }, :as => :string
        # a.input :_destroy, :as => :boolean
      end
      # f.para 'text'.html_safe
      f.para "testlabel"
    end
    f.actions
  end
        # f.action :submit, label: "Create Featured Product", url: "some_url_for_create(@product)"
end

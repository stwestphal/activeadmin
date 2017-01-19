ActiveAdmin.register Reporting do
  permit_params  :name, :price, :author, :genre, :author_id, :genre_id, :last_name
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


  index do
    selectable_column
    column "Report: ", :id
    table_for Author.order("id desc").limit(10) do
      column :id
      column "Name", :last_name do |name|
        link_to name.last_name, [:admin, name]
      end
      column "Vorname", :first_name
      column :created_at
      # date_select(:created_at, null,discard_day,null)
      end
  end


end

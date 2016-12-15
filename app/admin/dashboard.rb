ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end



    #action_item :auswertung, only: :show do
      #link to "Auswertung aus CSV", auswertung_admin_users_path
    #end
    #li do
    #  link_to 'Preview', author_admin_panel_posts_path()
    #end
    #collection_action :auswertung, method: :get do

    #end

    section "Authors", :priority =>1 do
      table_for Author.order("id desc").limit(10) do
        column :id
        column "Name", :last_name do |name|
          link_to name.last_name, [:admin, name]
        end
        column "Vorname", :first_name
        column :created_at

      end
    end

    section "Genres", :priority =>1 do
      table_for Genre.order("id desc").limit(10) do
        column :id
        column "Type", :name do |name|
          link_to name.name, [:admin, name]
        end
        column :created_at

      end
    end

    section "Books", :priority =>1 do
      table_for Book.order("id desc").limit(10) do
        column :id
        column "Name", :name do |name|
          link_to name.name, [:admin, name]
        end
        column :author
        column :price
        column :created_at

      end
    end
      # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end

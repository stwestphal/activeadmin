ActiveAdmin.register_page "Report" do

  sidebar :help do
    ul do
      li "Second List First Item"
      li "Second List Second Item"
    end
  end


  content do
    para "einfache gestaltung"
    para "Hier könnte Ihre Werbung stehen!"
    columns do
      column do
        span "Column #1"
      end

      column do
        span "Column #2"
      end
    end

    panel "einfacher table" do
    table_for Author.order("id desc").limit(10) do
      column :id
      column "Name", :id do |id|
        link_to id.last_name, [:admin, id]
      end
      column "Vorname", :first_name
      column :created_at
    end
    end

    para "zusammengesetzte rows"
    columns do
      column do

        rows = [['tata'], ['titi']]
        mystring = "23"

        table_for Author.order("id desc").limit(10) do
          rows[0] << mystring
          column :id
        end

        table_for rows do
          column '' do |row|
            row[0]
          end

          (1..6).each do |m|
            column m  do |row|
              row[m]
            end
          end

        end

      end
    end

    panel "zusammengesetzte cols" do
    columns do
      column do

        cols = [['id'], ['Last_name'], ['First_name']]

        table_for Author.order("id desc").limit(10) do
          (0..6).each do |m|
            #column m  do |row|
            #  cols[m]
          #  end
            column cols[m], :last_name
            column cols[m], :first_name
          end
        end
      end
    end
  end

  end
end
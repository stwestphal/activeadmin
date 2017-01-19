ActiveAdmin.register_page "Report" do

  require 'rubygems'
  require 'pdf/reader'

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

        # get time variables
        if params['year'] && params['year'].to_i > 2010
          year = params['year'].to_i
        else
          year = Time.zone.today.year
          year -= 1 if Time.zone.today.month == 1
        end

        panel "Kunden <a href='?year=#{year - 1}'>#{year - 1}</a> &nbsp;<b>#{year}</b>&nbsp; <a href='?year=#{year + 1}'> #{year + 1}</a>".html_safe do

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

      filename = "data/cairo-unicode.pdf"
      #filename = "data/1066848_Storno_2015-12-02_13253.pdf"
      #filename = "data/0_Vertrag_2016-11-02_13748.pdf"
      panel "pdf lesen:" do

        columns do
          column do

            cols = [['id'], ['Last_name'], ['First_name']]

            PDF::Reader.open(filename) do |reader|
              reader.pages.each do |page|

                para page.text
              end
            end

          end
        end
      end

  end

  end
end
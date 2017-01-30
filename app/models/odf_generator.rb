class OdfGenerator
  def initialize(template)
    @template = template
  end

  def generate_odt(invoice, template_file)
    @customer = invoice

    @total_sum = sum_up(invoice)
    @tax_total_amount = (@total_sum * 0.19).round
    @grand_total_amount = @total_sum + @tax_total_amount

    report = ODFReport::Report.new(template_file) do |r|

      r.add_field :customer_name, @customer.name
      r.add_field :line_one, @customer.author
      r.add_field :line_two, @customer.genre.name
      # r.add_field :zip, @customer.zip
      # r.add_field :city, @customer.city
      r.add_field :invoice_number, invoice.id
      r.add_field :customer_number, invoice.author_id
      # r.add_field :invoice_date, I18n.l(invoice.invoice_date, format: :default)
      r.add_field :invoice_date, Time.zone.today
      r.add_field :delivery_date, Time.zone.today.advance(days: 14)

      r.add_field "Salutation", "Sehr geehrte Damen und Herren"
      # r.add_field :delivery_date, invoice.subject
      # r.add_field :subject, invoice.subject
      # r.add_field :salutation, @customer.briefanrede
      #
      # r.add_field :tax_basis_total, 0 # @invoice.tax_basis_total
      # r.add_field :tax_total_amount, 0 # @invoice.tax_total_amount
      # r.add_field :grand_total_amount, 0 # @invoice.grand_total_amount

       r.add_table("LineItems", @customer.item_objects.order("position"), :header => true) do |t|
        t.add_column(:position, :position)
        t.add_column :description do |i|
            i.item_type.name
        end
        t.add_column(:amount, :amount)
        t.add_column(:netto_price, :netto_price)
        # t.add_column(:item_type, :item_type)
        t.add_column :line_total do |c|
           c.amount * c.netto_price
        end

       end
      # binding.pry
      r.add_field("Total_price", @total_sum)
      r.add_field :tax_total_amount, @tax_total_amount
      r.add_field :grand_total_amount, @grand_total_amount

      r.add_field :total_prepaid_amount_label, 'Anzahlungsbetrag' # @invoice.total_prepaid_amount ? 'Anzahlungsbetrag' : nil
      r.add_field :total_prepaid_amount, 0 # {}"- #{@invoice.total_prepaid_amount}" if @invoice.total_prepaid_amount
      r.add_field :due_payable_amount_label, 'Zahlbetrag' # @invoice.due_payable_amount ? 'Zahlbetrag' : nil
      # r.add_field :due_payable_amount, 0 # @invoice.due_payable_amount

      # r.add_field :closing_text, invoice.closing_text
    end

    report
  end

  def sum_up(invoice)
    total=0
     invoice.item_objects.each do |i|
        sum = i.amount * i.netto_price
       total += sum
     end
    total
  end

  def stream(invoice)
    report = generate_odt(invoice, @template)
    report.generate
  end
end

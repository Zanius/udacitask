module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(options = {})
    @due = options[:due]
    @due ? @due.strftime("%D") : "No due date"
    dates = []
    start_date = options[:start_date].strftime("%D")
    end_date = options[:end_date].strftime("%D")
    dates << start_date + "--"
    dates << end_date
    dates = "N/A" if !dates
  end
end

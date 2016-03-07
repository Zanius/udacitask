module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(first_date, second_date=nil)
    first_date = first_date ? first_date.strftime("%D") : "No due date" 


    dates = first_date
    dates << "--" + second_date.strftime("%D") if second_date
    dates = "N/A" if !dates

    return dates
  end

  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end
end

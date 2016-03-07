class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(type, description, options={})
    @type = type
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    pri = @priority
    unless pri == "low" || pri == "medium" || pri == "high" || pri == nil
      raise UdaciListErrors::InvalidPriorityValue, "Please enter your priority as 'high', 'medium', or 'low'."
    end
  end

  def details
    format_type(@type) +
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end
end

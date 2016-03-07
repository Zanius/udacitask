class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    case type
    when "todo" 
      @items.push TodoItem.new(description, options)
    when "event"
      @items.push EventItem.new(description, options)
    when "link"
      @items.push LinkItem.new(description, options) 
    else
      raise UdaciListErrors::InvalidItemType, "Please enter 'todo', 'event', or 'type'."
    end
  end

  def filter(type)
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length

    case type
    when "event"
      type = EventItem
    when "todo"
      type = TodoItem
    when "link"
      type = LinkItem
    end
    
    @items.each do |item|
      (p item.details) if item.class == type
    end
  end

  def delete(index)
    if index <= @items.length
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize, "Please delete an existing item."
    end
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length

    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end

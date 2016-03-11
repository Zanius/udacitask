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
      @items.push TodoItem.new(type, description, options)
    when "event"
      @items.push EventItem.new(type, description, options)
    when "link"
      @items.push LinkItem.new(type, description, options) 
    else
      raise UdaciListErrors::InvalidItemType, "Please enter 'todo', 'event', or 'link'."
    end
  end

  def filter(type)
    puts "-" * @title.length
    puts "Filtered " + @title
    puts "-" * @title.length

    @items.each do |item|
      (p item.details) if item.type == type
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

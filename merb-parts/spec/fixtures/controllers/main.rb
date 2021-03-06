class Main < Merb::Controller
  
  def index
    part TodoPart => :list
  end
  
  def index2
    part TodoPart => :one    
  end
  
  def index3
    part(TodoPart => :one) + part(TodoPart => :list)
  end
  
  def index4
    provides :xml, :js
    part(TodoPart => :formatted_output)
  end
  
  def part_with_params
    part(TodoPart => :part_with_params, :my_param => "my_value")
  end
  
end
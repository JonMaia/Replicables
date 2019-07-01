class Branch

  attr_accessor :branch_name
  def initialize(branch_name,obj)
    @branch_name = branch_name
    @obj = obj
  end

  def method_missing(msg, *args, &block)
    if @obj.respond_to? msg
      @obj.send(msg, *args, &block)
    else
      super
    end
  end

end

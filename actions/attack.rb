class Actions::Attack < Actions::Base
  def match?
    !warrior.feel.empty?
  end

  def execute
    warrior.attack!
  end
end

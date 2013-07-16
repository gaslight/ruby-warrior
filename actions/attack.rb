class Actions::Attack < Action
  def match?
    !warrior.feel.empty?
  end

  def execute
    warrior.attack!
  end
end

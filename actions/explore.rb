class Actions::Explore < Action

  def match?
    warrior.feel.empty?
  end

  def execute
    warrior.walk!
  end
end

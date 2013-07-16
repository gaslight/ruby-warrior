class Actions::Pivot < Action
  def match?
    warrior.feel.wall?
  end

  def execute
    warrior.pivot!
  end
end

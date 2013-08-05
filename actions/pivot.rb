class Actions::Pivot < Actions::Base
  def match?
    warrior.feel.wall?
  end

  def execute
    warrior.pivot!
  end
end

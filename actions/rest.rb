class Actions::Rest < Action
  def match?
    return false if fully_healed?
    return false if warrior.sense_archer?
    warrior.feel.empty?
  end

  def fully_healed?
    warrior.health == warrior.max_health
  end

  def execute
    warrior.rest!
  end
end

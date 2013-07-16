class Actions::Backup < Action
  def match?
    return false unless warrior.feel(:backward).empty?
    warrior.sense_archer? && warrior.dangerously_damaged? || !warrior.sensed_wall?
  end

  def execute
    warrior.walk!(:backward)
  end
end

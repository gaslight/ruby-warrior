class Actions::Shoot < Action
  def match?
    warrior.sense_wizard?
  end

  def execute
    warrior.shoot!
  end
end

class Actions::Shoot < Action
  def match?
    @backward = warrior.sense_enemy?(:backward)
    @forward = warrior.sense_enemy?(:forward)
    @backward || @forward
  end

  def execute
    if @backward
      warrior.shoot!(:backward)
    elsif @forward
      warrior.shoot!(:forward)
    end
  end
end

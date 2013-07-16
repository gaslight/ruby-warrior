class Actions::RescueCaptive < Action
  def match?
    @backward = warrior.feel(:backward).captive?
    @forward = warrior.feel.captive?
    @backward || @forward
  end

  def execute
    warrior.rescue!(:backward) if @backward
    warrior.rescue!(:forward) if @forward
  end
end

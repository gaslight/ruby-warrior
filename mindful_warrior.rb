class MindfulWarrior
  attr_accessor :previous_health, :warrior

  def to_s
    "health: #{warrior.health}/#{max_health}, previous_health: #{previous_health}\nfound back wall? #{sensed_wall?}"
  end

  def previous_health
    @previous_health || warrior.health
  end

  def dangerously_damaged?
    warrior.health < 8
  end

  def max_health
    20
  end

  def sense_archer?
    (warrior.health < previous_health) &&
      (warrior.feel(:backward).empty? || warrior.feel(:forward).empty?)
  end

  def sense_enemy?(direction = :forward)
    puts warrior.look(direction).inspect
    warrior.look(direction).each do |see|
      next if see.to_s == "nothing"
      next if see.to_s == "wall"
      return false if see.to_s == "Captive"
      return true if see.to_s != "Captive"
    end
    false
  end

  def sensed_wall?
    return true if @found_wall
    @found_wall = warrior.feel(:backward).wall?
  end

  def respond_to_missing?(method)
    warrior.respond_to?(method) || super
  end

  def method_missing(method, *args, &block)
    warrior.send(method, *args, &block) || super
  end
end

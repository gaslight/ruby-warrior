class Player

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

  class Action
    attr_accessor :warrior
    def initialize(warrior)
      self.warrior = warrior
    end
  end

  class Explore < Action

    def match?
      warrior.feel.empty?
    end

    def execute
      warrior.walk!
    end
  end

  class Attack < Action
    def match?
      !warrior.feel.empty?
    end

    def execute
      warrior.attack!
    end
  end

  class Rest < Action
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

  class RescueCaptive < Action
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

  class NoAction < Action
    def match?
      true
    end

    def execute
    end
  end

  class Backup < Action
    def match?
      return false unless warrior.feel(:backward).empty?
      warrior.sense_archer? && warrior.dangerously_damaged? || !warrior.sensed_wall?
    end

    def execute
      warrior.walk!(:backward)
    end
  end

  class Pivot < Action
    def match?
      warrior.feel.wall?
    end

    def execute
      warrior.pivot!
    end
  end

  def actions(warrior)
    [Rest, Pivot, Backup, RescueCaptive, Explore, Attack, NoAction].map do |klass|
      klass.new(warrior)
    end
  end

  def mindful_warrior
    @mindful_warrior ||= MindfulWarrior.new
  end

  def play_turn(warrior)
    mindful_warrior.warrior = warrior
puts mindful_warrior.to_s
    found_action = actions(mindful_warrior).find { |a| a.match? }
    found_action.execute
    mindful_warrior.previous_health = warrior.health
  end
end

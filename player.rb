require 'mindful_warrior'
require 'actions'

class Player
  include Actions

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

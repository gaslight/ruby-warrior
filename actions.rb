class Action
  attr_accessor :warrior
  def initialize(warrior)
    self.warrior = warrior
  end
end


module Actions
  def actions(warrior)
    [Rest, Pivot, Backup, RescueCaptive, Shoot, Explore, Attack, NoAction].map do |klass|
      klass.new(warrior)
    end
  end
end

class Actions::NoAction < Action
  def match?
    true
  end

  def execute
  end
end

require 'actions/rest'
require 'actions/pivot'
require 'actions/rescue_captive'
require 'actions/explore'
require 'actions/attack'
require 'actions/shoot'
require 'actions/backup'

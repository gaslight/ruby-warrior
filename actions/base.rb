class Actions::Base
  attr_accessor :warrior
  def initialize(warrior)
    self.warrior = warrior
  end
end

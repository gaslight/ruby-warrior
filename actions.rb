module Actions
  def actions(warrior)
    [Rest, Pivot, Shoot, Backup, RescueCaptive, Explore, Attack, NoAction].map do |klass|
      klass.new(warrior)
    end
  end
end

require 'actions/base'
require 'actions/rest'
require 'actions/pivot'
require 'actions/rescue_captive'
require 'actions/explore'
require 'actions/attack'
require 'actions/shoot'
require 'actions/backup'
require 'actions/no_action'
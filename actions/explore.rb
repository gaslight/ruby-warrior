class Actions::Explore < Actions::Base

  def match?
    warrior.feel.empty?
  end

  def execute
    warrior.walk!
  end
end

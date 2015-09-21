require_relative 'statewide_testing'
require_relative 'enrollment'
require_relative 'economic_profile'

class District
  attr_reader :name

  def initialize(name, loader=Loader)
    @name = name.upcase
    @loader = loader
  end

  def statewide_testing
    StatewideTesting.new(@name, @loader)
  end

  def enrollment
    Enrollment.new(@name, @loader)
  end

  def economic_profile
    EconomicProfile.new(@name, @loader)
  end

  def ==(other_thing)
    name == other_thing.name
  end
end

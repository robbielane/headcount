require_relative 'loader'

class EconomicProfile
  attr_reader :loader
  def initialize(name, loader=Loader)
    @name = name
    @loader = loader
  end

  def free_or_reduced_lunch_by_year
    data = loader.load_students_reduced_priced_lunch
    binding.pry
  end
end

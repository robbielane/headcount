require_relative 'loader'

class EconomicProfile
  attr_reader :loader
  def initialize(name, loader=Loader)
    @name = name
    @loader = loader
  end

  def free_or_reduced_lunch_by_year
    data = loader.load_students_reduced_priced_lunch
    selected_rows = data.select { |row| row[:location] == @name &&
                                        row[:poverty_level] == "Eligible for Free or Reduced Lunch" &&
                                        row[:dataformat] == "Percent" }
    results = {}
    selected_rows.each do |row|
      results[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    return nil if results.empty?
    results
  end

  def free_or_reduced_lunch_in_year(year)
    data = loader.load_students_reduced_priced_lunch
    selected_rows = data.select { |row| row[:location] == @name &&
                                        row[:timeframe].to_i == year &&
                                        row[:poverty_level] == "Eligible for Free or Reduced Lunch" &&
                                        row[:dataformat] == "Percent" }
    selected_rows[0][:data][0..4].to_f unless selected_rows.empty?
  end

  def school_aged_children_in_poverty_by_year
    data = loader.load_school_aged_children_in_poverty
    selected_rows = data.select { |row| row[:location] == @name &&
                                        row[:dataformat] == "Percent"}
    results = {}
    selected_rows.each do |row|
      results[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    results
  end

  def school_aged_children_in_poverty_in_year(year)
    data = loader.load_school_aged_children_in_poverty
    selected_rows = data.select { |row| row[:location] == @name &&
                                        row[:dataformat] == "Percent" &&
                                        row[:timeframe].to_i == year}
    selected_rows[0][:data][0..4].to_f unless selected_rows.empty?
  end

  def title_1_students_by_year
    data = loader.load_title_one_students
    selected_rows = data.select { |row| row[:location] == @name }
    results = {}
    selected_rows.each do |row|
      results[row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    return nil if results.empty?
    results
  end

  def title_1_students_in_year(year)
    data = loader.load_title_one_students
    selected_rows = data.select { |row| row[:location] == @name &&
                                        row[:timeframe].to_i == year }
    selected_rows[0][:data][0..4].to_f unless selected_rows.empty?
  end

  def median_household_income_by_year
    data = loader.load_median_household_income
    selected_rows = data.select { |row| row[:location].upcase == @name }

    results = {}
    selected_rows.each do |row|
      results[row[:timeframe]] = row[:data].to_i
    end
    results
  end
end

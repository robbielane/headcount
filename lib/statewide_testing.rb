require_relative 'statewide_testing_loader'
require 'csv'

class StatewideTesting
  def initialize(name)
    @name = name
  end

  def proficient_by_grade(grade)
    case grade
    when 3
      data = StatewideTestingLoader.load_proficient_grade_three
    when 4
      data = StatewideTestingLoader.load_proficient_grade_four
    when 8
      data = StatewideTestingLoader.load_proficient_grade_eight
    else
      raise UnknownDataError
    end

    results = data.select { |row| row if row[:location] == @name }
        .group_by { |r| r[:timeframe] }
        .map { |k,v| {k.to_i => v.map { |k| {k[:score].downcase.to_sym=>k[:data].to_f} } } }
    format_results(results)
  end

  def format_results(results)
    formatted_result = {}
    results.each_with_index do |element, index|
      results[index].each do |k,v|
        formatted_result[k] = v[0].merge(v[1]).merge(v[2]).sort
      end
    end
    formatted_result
  end
end
binding.pry
StatewideTesting.new('ACADEMY 20').proficient_by_grade(3)

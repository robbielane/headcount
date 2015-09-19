require_relative 'statewide_testing_loader'
require 'pry'


class UnknownDataError < StandardError
end

class StatewideTesting
  RACES = {asian: "Asian",
           black: "Black",
           pacific_islander: "Hawaiian/Pacific Islander",
           hispanic: "Hispanic",
           native_american: "Native American",
           two_or_more: "Two or more",
           white: "White"}

  SUBJECTS = [:math, :reading, :writing]
  GRADES = [3, 8]


  def initialize(name)
    @name = name
  end

  def proficient_by_grade(grade)
    case grade
    when 3 then data = StatewideTestingLoader.load_proficient_grade_three
    when 8 then data = StatewideTestingLoader.load_proficient_grade_eight
    else
      raise UnknownDataError
    end

    results = data.select { |row| row if row[:location] == @name }
        .group_by { |r| r[:timeframe] }
        .map { |k,v| {k.to_i => v.map { |k| {k[:score].downcase.to_sym=>k[:data][0..4].to_f} } } }
    format_results(results)
  end

  def format_results(results)
    formatted_result = {}
    results.each_with_index do |element, index|
      results[index].each do |k,v|
        formatted_result[k] = v[0].merge(v[1]).merge(v[2])
      end
    end
    formatted_result
  end

  def proficient_by_race_or_ethnicity(race)
    raise UnknownDataError unless RACES.keys.include?(race)

    math = StatewideTestingLoader.load_average_math_prof_by_race
    reading = StatewideTestingLoader.load_average_reading_prof_by_race
    writing = StatewideTestingLoader.load_average_writing_prof_by_race

    results = Hash.new
    results[:math] = math.select { |row| row if row[:location] == @name && row[:race_ethnicity] == RACES.fetch(race) }
    results[:reading] = reading.select { |row| row if row[:location] == @name && row[:race_ethnicity] == RACES.fetch(race) }
    results[:writing] = writing.select { |row| row if row[:location] == @name && row[:race_ethnicity] == RACES.fetch(race) }

    formatted_results = Hash.new

    results.each do |result_type, result_data|
      result_data.each do |row|
        timeframe = row[:timeframe].to_i
        formatted_results[timeframe] ||= Hash.new
        formatted_results[timeframe][result_type] = row[:data][0..4].to_f
      end
    end
    formatted_results
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    #raise UnknownDataError if year not included in data.
    raise UnknownDataError unless SUBJECTS.include?(subject) && GRADES.include?(grade)
    data = proficient_by_grade(grade)
    data_for_year = data.select { |k,v| v if k == year}
    data_for_year[year][subject]
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    #raise UnknownDataError if year not included in data.
    raise UnknownDataError unless SUBJECTS.include?(subject) && RACES.keys.include?(race)
    data = proficient_by_race_or_ethnicity(race)
    data_by_race = data.select { |k,v| v if k == year}
    data_by_race[year][subject]
  end
end



StatewideTesting.new('ACADEMY 20').proficient_by_race_or_ethnicity(:asian)
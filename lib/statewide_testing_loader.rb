require 'csv'
require 'pry'

class StatewideTestingLoader
  def self.load_proficient_grade_three
    grade_three_prof = "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
    data = CSV.open(grade_three_prof, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_proficient_grade_four
    grade_four_prof = "./data/4th grade students scoring proficient or above on the CSAP_TCAP.csv"
    data = CSV.open(grade_four_prof, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_proficient_grade_eight
    grade_eight_prof = "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv"
    data = CSV.open(grade_eight_prof, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def load_proficient_grade_three
    grade_three_prof = "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
    data = CSV.open(grade_three_prof, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def load_average_math_prof_by_race
    average_prof_by_race_math = "..data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv"
    data = CSV.open(average_prof_by_race_math, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end




    average_prof_by_race_reading = "..data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv"
    average_prof_by_race_writing = "..data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
end

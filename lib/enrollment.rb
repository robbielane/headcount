require_relative 'enrollment_loader'

class Enrollment
  RACES = {asian: "Asian Students",
           black: "Black Students",
           pacific_islander: "Native Hawaiian or Other Pacific Islander",
           hispanic: "Hispanic Students",
           native_american: "Native American Students",
           two_or_more: "Two or More Races",
           white: "White Students"}

  def initialize(name)
    @name = name
  end

    def dropout_rate_in_year(year)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_year = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && row[:category] == "All Students"}
      selected_year[0][:data].to_f
    end

    def dropout_rate_by_gender_in_year(year)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_year = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && (row[:category] == "Male Students" || row[:category] == "Female Students")}
      result = {}
      selected_year.each do |row|
        result[:male] = row[:data].to_f if row[:category] == "Male Students"
        result[:female] = row[:data].to_f if row[:category] == "Female Students"
      end
      result
    end

    def dropout_rate_by_race_in_year(year)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_year = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year }
      result = {}
      selected_year.each do |row|
        result[:asian] = row[:data].to_f if row[:category] == "Asian Students"
        result[:black] = row[:data].to_f if row[:category] == "Black Students"
        result[:pacific_islander] = row[:data].to_f if row[:category] == "Native Hawaiian or Other Pacific Islander"
        result[:hispanic] = row[:data].to_f if row[:category] == "Hispanic Students"
        result[:native_american] = row[:data].to_f if row[:category] == "Native American Students"
        result[:two_or_more] = row[:data].to_f if row[:category] == "Two or More Races"
        result[:white] = row[:data].to_f if row[:category] == "White Students"
      end
      result
    end

    def dropout_rate_for_race_or_ethnicity(race)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_race = data.select { |row| row if row[:location] == @name && row[:category] == RACES.fetch(race) }
      result = {}
      selected_race.each { |row| result[row[:timeframe].to_i] = row[:data].to_f }
      result
    end

    def dropout_rate_for_race_or_ethnicity_in_year(race, year)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_row = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && row[:category] == RACES.fetch(race) }
      selected_row[0][:data].to_f
    end

    def graduation_rate_by_year
      data = EnrollmentLoader.load_high_school_graduation_rates
      selected_rows = data.select { |row| row if row[:location] == @name }
      results = {}
      selected_rows.each { |row| results[row[:timeframe].to_i] = row[:data][0..4].to_f }
      results
    end
end

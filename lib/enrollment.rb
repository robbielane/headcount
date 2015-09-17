require_relative 'enrollment_loader'

class UnknownRaceError < StandardError
  UnknownRaceError
end

class Enrollment
  RACES_FOR_DROPOUT = {asian: "Asian Students",
                       black: "Black Students",
                       pacific_islander: "Native Hawaiian or Other Pacific Islander",
                       hispanic: "Hispanic Students",
                       native_american: "Native American Students",
                       two_or_more: "Two or More Races",
                       white: "White Students"}

  RACES_FOR_PARTICI = {asian: "Asian Students",
                       black: "Black Students",
                       pacific_islander: "Native Hawaiian or Other Pacific Islander",
                       hispanic: "Hispanic Students",
                       native_american: "American Indian Students",
                       two_or_more: "Two or more races",
                       white: "White Students"}

  def initialize(name)
    @name = name
  end

    def dropout_rate_in_year(year)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && row[:category] == "All Students"}
      selected_rows[0][:data].to_f if !selected_rows.empty?
    end

    def dropout_rate_by_gender_in_year(year)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && (row[:category] == "Male Students" || row[:category] == "Female Students")}
      results = {}
      selected_rows.each do |row|
        results[:male] = row[:data].to_f if row[:category] == "Male Students"
        results[:female] = row[:data].to_f if row[:category] == "Female Students"
      end
      return nil if results.empty?
      results
    end

    def dropout_rate_by_race_in_year(year)
      data = EnrollmentLoader.load_dropout_rates_by_race
      exclude = ["All Students", "Male Students", "Female Students"]
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && !exclude.include?(row[:category]) }
      results = {}
      selected_rows.each { |row| results[RACES_FOR_DROPOUT.key(row[:category])] =  row[:data][0..4].to_f }
      return nil if results.empty?
      results
    end

    def dropout_rate_for_race_or_ethnicity(race)
      raise UnknownRaceError unless RACES_FOR_DROPOUT.keys.include?(race.to_sym)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_race = data.select { |row| row if row[:location] == @name && row[:category] == RACES_FOR_DROPOUT.fetch(race) }
      results = {}
      selected_race.each { |row| results[row[:timeframe].to_i] = row[:data].to_f }
      results
    end

    def dropout_rate_for_race_or_ethnicity_in_year(race, year)
      raise UnknownRaceError unless RACES_FOR_DROPOUT.keys.include?(race.to_sym)
      data = EnrollmentLoader.load_dropout_rates_by_race
      selected_row = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && row[:category] == RACES_FOR_DROPOUT.fetch(race) }
      selected_row[0][:data].to_f if !selected_row.empty?
    end

    def graduation_rate_by_year
      data = EnrollmentLoader.load_high_school_graduation_rates
      selected_rows = data.select { |row| row if row[:location] == @name }
      results = {}
      selected_rows.each { |row| results[row[:timeframe].to_i] = row[:data][0..4].to_f }
      results
    end

    def graduation_rate_in_year(year)
      data = EnrollmentLoader.load_high_school_graduation_rates
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year }
      selected_rows[0][:data].to_f if !selected_rows.empty?
    end

    def kindergarten_participation_by_year
      data = EnrollmentLoader.load_kidergartners_in_full_day_program
      selected_rows = data.select { |row| row if row[:location] == @name }
      results = {}
      selected_rows.each do |row|
        results[row[:timeframe].to_i] = row[:data][0..4].to_f
      end
      results
    end

    def kindergarten_participation_in_year(year)
      data = EnrollmentLoader.load_kidergartners_in_full_day_program
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year}
      selected_rows[0][:data][0..4].to_f if !selected_rows.empty?
    end

    def online_participation_by_year
      data = EnrollmentLoader.load_online_pupil_enrollment
      selected_rows = data.select { |row| row if row[:location] == @name }
      results = {}
      selected_rows.each { |row| results[row[:timeframe].to_i] = row[:data].to_i }
      results
    end

    def online_participation_in_year(year)
      data = EnrollmentLoader.load_online_pupil_enrollment
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year}
      selected_rows[0][:data].to_i if !selected_rows.empty?
    end

    def participation_by_year
      data = EnrollmentLoader.load_pupil_enrollment
      selected_rows = data.select { |row| row if row[:location] == @name }
      results = {}
      selected_rows.each { |row| results[row[:timeframe].to_i] = row[:data].to_i }
      results
    end

    def participation_in_year(year)
      data = EnrollmentLoader.load_pupil_enrollment
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year}
      selected_rows[0][:data].to_i if !selected_rows.empty?
    end

    def participation_by_race_or_ethnicity(race)
      raise UnknownRaceError unless RACES_FOR_PARTICI.keys.include?(race.to_sym)
      data = EnrollmentLoader.load_pupil_enrollment_by_race_ethnicity
      selected_rows = data.select { |row| row if row[:location] == @name && row[:race] == RACES_FOR_PARTICI.fetch(race) && row[:dataformat] == "Percent" }
      results = {}
      selected_rows.each { |row| results[row[:timeframe].to_i] = row[:data][0..4].to_f }
      results
    end

    def participation_by_race_or_ethnicity_in_year(year)
      data = EnrollmentLoader.load_pupil_enrollment_by_race_ethnicity
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && row[:dataformat] == "Percent" && row[:race] != "Total" }
      results = {}
      selected_rows.each { |row| results[RACES_FOR_PARTICI.key(row[:race])] = row[:data].to_f }
      return nil if results.empty?
      results
    end

    def special_education_by_year
      data = EnrollmentLoader.load_special_education
      selected_rows = data.select { |row| row if row[:location] == @name }
      results = {}
      selected_rows.each {|row| results[row[:timeframe].to_i] = row[:data][0..4].to_f }
      results
    end

    def special_education_in_year(year)
      data = EnrollmentLoader.load_special_education
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year && row[:dataformat] == "Percent" }
      selected_rows[0][:data][0..4].to_f if !selected_rows.empty?
    end

    def remediation_by_year
      data = EnrollmentLoader.load_remediation_in_higher_education
      selected_rows = data.select { |row| row if row[:location] == @name }
      results = {}
      selected_rows.each { |row| results[row[:timeframe].to_i] = row[:data][0..4].to_f }
      results
    end

    def remediation_in_year(year)
      data = EnrollmentLoader.load_remediation_in_higher_education
      selected_rows = data.select { |row| row if row[:location] == @name && row[:timeframe].to_i == year }
      selected_rows[0][:data][0..4].to_f if !selected_rows.empty?
    end

end

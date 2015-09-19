require_relative 'enrollment_loader'

class UnknownRaceError < StandardError
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

  def retrieve_data_from_first_row_unless_empty(selected_rows)
    selected_rows.fetch(0).fetch(:data)[0..4].to_f unless selected_rows.empty?
  end

  def selected_by_district_and_formatted_by_year_and_data(data)
    selected_rows = data.select { |row| row if row.fetch(:location) == @name }
    formatted_results_by_year_and_data(selected_rows)
  end

  def formatted_results_by_year_and_data(selected_rows)
    results = {}
    selected_rows.each { |row| results[row.fetch(:timeframe).to_i] = row.fetch(:data)[0..4].to_f }
    results
  end

  def select_by_district_and_year(data, year)
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:timeframe).to_i == year }
    retrieve_data_from_first_row_unless_empty(selected_rows)
  end

  def dropout_rate_in_year(year)
    data = EnrollmentLoader.load_dropout_rates_by_race
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:timeframe).to_i == year &&
                                               row.fetch(:category) == "All Students"}
    retrieve_data_from_first_row_unless_empty(selected_rows)
  end

  def dropout_rate_by_gender_in_year(year)
    data = EnrollmentLoader.load_dropout_rates_by_race
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:timeframe).to_i == year &&
                                              (row.fetch(:category) == "Male Students" ||
                                               row.fetch(:category) == "Female Students")}
    formatted_results_for_male_and_female_students(selected_rows)
  end

  def formatted_results_for_male_and_female_students(selected_rows)
    results = {}
    return_hash_of_male_and_female_student_data(results, selected_rows)
    return nil if results.empty?
    results
  end

  def return_hash_of_male_and_female_student_data(results, selected_rows)
    selected_rows.each do |row|
      results[:male] = row[:data].to_f if row.fetch(:category) == "Male Students"
      results[:female] = row[:data].to_f if row.fetch(:category) == "Female Students"
    end
  end

  def dropout_rate_by_race_in_year(year)
    data = EnrollmentLoader.load_dropout_rates_by_race
    exclude = ["All Students", "Male Students", "Female Students"]
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:timeframe).to_i == year &&
                                               !exclude.include?(row.fetch(:category)) }
    results = {}
    selected_rows.each { |row| results[RACES_FOR_DROPOUT.key(row.fetch(:category))] =  row.fetch(:data)[0..4].to_f }
    return nil if results.empty?
    results
  end

  def dropout_rate_for_race_or_ethnicity(race)
    raise UnknownRaceError unless RACES_FOR_DROPOUT.keys.include?(race.to_sym)
    data = EnrollmentLoader.load_dropout_rates_by_race
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:category) == RACES_FOR_DROPOUT.fetch(race) }
    formatted_results_by_year_and_data(selected_rows)
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    raise UnknownRaceError unless RACES_FOR_DROPOUT.keys.include?(race.to_sym)
    data = EnrollmentLoader.load_dropout_rates_by_race
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:timeframe).to_i == year &&
                                               row.fetch(:category) == RACES_FOR_DROPOUT.fetch(race) }
    retrieve_data_from_first_row_unless_empty(selected_rows)
  end

  def graduation_rate_by_year
    data = EnrollmentLoader.load_high_school_graduation_rates
    selected_by_district_and_formatted_by_year_and_data(data)
  end

  def graduation_rate_in_year(year)
    data = EnrollmentLoader.load_high_school_graduation_rates
    select_by_district_and_year(data, year)
  end

  def kindergarten_participation_by_year
    data = EnrollmentLoader.load_kidergartners_in_full_day_program
    selected_by_district_and_formatted_by_year_and_data(data)
  end

  def kindergarten_participation_in_year(year)
    data = EnrollmentLoader.load_kidergartners_in_full_day_program
    select_by_district_and_year(data, year)
  end

  def online_participation_by_year
    data = EnrollmentLoader.load_online_pupil_enrollment
    selected_by_district_and_formatted_by_year_and_data(data)
  end

  def online_participation_in_year(year)
    data = EnrollmentLoader.load_online_pupil_enrollment
    select_by_district_and_year(data, year)
  end

  def participation_by_year
    data = EnrollmentLoader.load_pupil_enrollment
    selected_by_district_and_formatted_by_year_and_data(data)
  end

  def participation_in_year(year)
    data = EnrollmentLoader.load_pupil_enrollment
    select_by_district_and_year(data, year)
  end

  def participation_by_race_or_ethnicity(race)
    raise UnknownRaceError unless RACES_FOR_PARTICI.keys.include?(race.to_sym)
    data = EnrollmentLoader.load_pupil_enrollment_by_race_ethnicity
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:race) == RACES_FOR_PARTICI.fetch(race) &&
                                               row.fetch(:dataformat) == "Percent" }
    formatted_results_by_year_and_data(selected_rows)
  end

  def participation_by_race_or_ethnicity_in_year(year)
    data = EnrollmentLoader.load_pupil_enrollment_by_race_ethnicity
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                               row.fetch(:timeframe).to_i == year &&
                                               row.fetch(:dataformat) == "Percent" &&
                                               row.fetch(:race) != "Total" }
    results = {}
    selected_rows.each { |row| results[RACES_FOR_PARTICI.key(row.fetch(:race))] = row.fetch(:data).to_f }
    return nil if results.empty?
    results
  end

  def special_education_by_year
    data = EnrollmentLoader.load_special_education
    selected_by_district_and_formatted_by_year_and_data(data)
  end

  def special_education_in_year(year)
    data = EnrollmentLoader.load_special_education
    selected_rows = data.select { |row| row if row.fetch(:location) == @name &&
                                        row.fetch(:timeframe).to_i == year &&
                                        row.fetch(:dataformat) == "Percent" }
    retrieve_data_from_first_row_unless_empty(selected_rows)
  end

  def remediation_by_year
    data = EnrollmentLoader.load_remediation_in_higher_education
    selected_by_district_and_formatted_by_year_and_data(data)
  end

  def remediation_in_year(year)
    data = EnrollmentLoader.load_remediation_in_higher_education
    select_by_district_and_year(data, year)
  end

end

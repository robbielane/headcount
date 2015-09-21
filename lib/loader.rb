require 'csv'

class Loader
  def self.load_dropout_rates_by_race
    dropout_rates_by_race = "./data/Dropout rates by race and ethnicity.csv"
    data = CSV.open(dropout_rates_by_race, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_high_school_graduation_rates
    dropout_rates_by_race = "./data/High school graduation rates.csv"
    data = CSV.open(dropout_rates_by_race, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_kidergartners_in_full_day_program
    kindergartners_in_full_day_care = "./data/Kindergartners in full-day program.csv"
    data = CSV.open(kindergartners_in_full_day_care, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_online_pupil_enrollment
    online_pupil_erollment = "./data/Online pupil enrollment.csv"
    data = CSV.open(online_pupil_erollment, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_pupil_enrollment_by_race_ethnicity
    pupil_enrollment_by_race_ethnicity = "./data/Pupil enrollment by race_ethnicity.csv"
    data = CSV.open(pupil_enrollment_by_race_ethnicity, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_pupil_enrollment
    pupil_enrollment = "./data/Pupil enrollment.csv"
    data = CSV.open(pupil_enrollment, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_special_education
    special_education = "./data/Special education.csv"
    data = CSV.open(special_education, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_remediation_in_higher_education
    remediation_in_higher_education = "./data/Remediation in higher education.csv"
    data = CSV.open(remediation_in_higher_education, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

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

  def self.load_proficiency_data_by_grade_three
    grade_three_prof = "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
    data = CSV.open(grade_three_prof, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_average_math_prof_by_race
    average_prof_by_race_math = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv"
    math = CSV.open(average_prof_by_race_math, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_average_reading_prof_by_race
    average_prof_by_race_reading = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv"
    reading = CSV.open(average_prof_by_race_reading, {headers: true, header_converters: :symbol})
                 .to_a.map { |row| row.to_hash }
  end

  def self.load_average_writing_prof_by_race
    average_prof_by_race_writing = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
    writing = CSV.open(average_prof_by_race_writing, {headers: true, header_converters: :symbol})
                 .to_a.map { |row| row.to_hash }
  end

  def self.load_median_household_income
    median_household_income = "./data/Median household income.csv"
    data = CSV.open(median_household_income, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_school_aged_children_in_poverty
    school_aged_children_poverty = "./data/School-aged children in poverty.csv"
    data = CSV.open(school_aged_children_poverty, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_students_reduced_priced_lunch
    reduced_price_lunch = "./data/Students qualifying for free or reduced price lunch.csv"
    data = CSV.open(reduced_price_lunch, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end

  def self.load_title_one_students
    title_one_students = "./data/Title I students.csv"
    data = CSV.open(title_one_students, {headers: true, header_converters: :symbol})
              .to_a.map { |row| row.to_hash}
  end
end

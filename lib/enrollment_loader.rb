require 'csv'
require 'pry'

class EnrollmentLoader
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

end

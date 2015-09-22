require 'csv'

class Loader
  def self.load_dropout_rates_by_race
    dropout_rates_by_race = "./data/Dropout rates by race and ethnicity.csv"
    map_csv(dropout_rates_by_race)
  end

  def self.load_high_school_graduation_rates
    graduation_rates = "./data/High school graduation rates.csv"
    map_csv(graduation_rates)
  end

  def self.load_kidergartners_in_full_day_program
    kindergartners_in_full_day_care = "./data/Kindergartners in full-day program.csv"
    map_csv(kindergartners_in_full_day_care)
  end

  def self.load_online_pupil_enrollment
    online_pupil_erollment = "./data/Online pupil enrollment.csv"
    map_csv(online_pupil_erollment)
  end

  def self.load_pupil_enrollment_by_race_ethnicity
    pupil_enrollment_by_race_ethnicity = "./data/Pupil enrollment by race_ethnicity.csv"
    map_csv(pupil_enrollment_by_race_ethnicity)
  end

  def self.load_pupil_enrollment
    pupil_enrollment = "./data/Pupil enrollment.csv"
    map_csv(pupil_enrollment)
  end

  def self.load_special_education
    special_education = "./data/Special education.csv"
    map_csv(special_education)
  end

  def self.load_remediation_in_higher_education
    remediation_in_higher_education = "./data/Remediation in higher education.csv"
    map_csv(remediation_in_higher_education)
  end

  def self.load_proficient_grade_three
    grade_three_prof = "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
    map_csv(grade_three_prof)
  end

  def self.load_proficient_grade_eight
    grade_eight_prof = "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv"
    map_csv(grade_eight_prof)
  end

  def self.load_proficiency_data_by_grade_three
    grade_three_prof = "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
    map_csv(grade_three_prof)
  end

  def self.load_average_math_prof_by_race
    average_prof_by_race_math = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv"
    map_csv(average_prof_by_race_math)
  end

  def self.load_average_reading_prof_by_race
    average_prof_by_race_reading = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv"
    map_csv(average_prof_by_race_reading)
  end

  def self.load_average_writing_prof_by_race
    average_prof_by_race_writing = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
    map_csv(average_prof_by_race_writing)
  end

  def self.load_median_household_income
    median_household_income = "./data/Median household income.csv"
    map_csv(median_household_income)
  end

  def self.load_school_aged_children_in_poverty
    school_aged_children_poverty = "./data/School-aged children in poverty.csv"
    map_csv(school_aged_children_poverty)
  end

  def self.load_students_reduced_priced_lunch
    reduced_price_lunch = "./data/Students qualifying for free or reduced price lunch.csv"
    map_csv(reduced_price_lunch)
  end

  def self.load_title_one_students
    title_one_students = "./data/Title I students.csv"
    map_csv(title_one_students)
  end

  def self.map_csv(file)
    CSV.open(file, {headers: true, header_converters: :symbol})
       .to_a.map { |row| row.to_hash}
  end
end

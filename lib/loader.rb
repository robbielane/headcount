require 'csv'

class Loader
  def inspect
    "#<#{self.class} for ...>"
  end

  def load_dropout_rates_by_race
    dropout_rates_by_race = "./data/Dropout rates by race and ethnicity.csv"
    @dropout_rates_by_race ||= map_csv(dropout_rates_by_race)
  end

  def load_high_school_graduation_rates
    graduation_rates = "./data/High school graduation rates.csv"
    @graduation_rates ||= map_csv_omit_zeros(graduation_rates)
  end

  def load_kidergartners_in_full_day_program
    kindergartners_in_full_day_care = "./data/Kindergartners in full-day program.csv"
    @kindergartners_in_full_day_care ||= map_csv_omit_zeros(kindergartners_in_full_day_care)
  end

  def load_online_pupil_enrollment
    online_pupil_erollment = "./data/Online pupil enrollment.csv"
    @online_pupil_erollment ||= map_csv_omit_zeros(online_pupil_erollment)
  end

  def load_pupil_enrollment_by_race_ethnicity
    pupil_enrollment_by_race_ethnicity = "./data/Pupil enrollment by race_ethnicity.csv"
    @pupil_enrollment_by_race_ethnicity ||= map_csv_omit_zeros(pupil_enrollment_by_race_ethnicity)
  end

  def load_pupil_enrollment
    pupil_enrollment = "./data/Pupil enrollment.csv"
    @pupil_enrollment ||= map_csv_omit_zeros(pupil_enrollment)
  end

  def load_special_education
    special_education = "./data/Special education.csv"
    @special_education ||= map_csv_omit_zeros(special_education)
  end

  def load_remediation_in_higher_education
    remediation_in_higher_education = "./data/Remediation in higher education.csv"
    @remediation_in_higher_education ||= map_csv_omit_zeros(remediation_in_higher_education)
  end

  def load_proficient_grade_three
    grade_three_prof = "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
    @grade_three_prof ||= map_csv_omit_zeros(grade_three_prof)
  end

  def load_proficient_grade_eight
    grade_eight_prof = "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv"
    @grade_eight_prof ||= map_csv_omit_zeros(grade_eight_prof)
  end

  def load_proficiency_data_by_grade_three
    grade_three_prof = "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv"
    @grade_three_prof ||= map_csv_omit_zeros(grade_three_prof)
  end

  def load_average_math_prof_by_race
    average_prof_by_race_math = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv"
    @average_prof_by_race_math ||= map_csv_omit_zeros(average_prof_by_race_math)
  end

  def load_average_reading_prof_by_race
    average_prof_by_race_reading = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv"
    @average_prof_by_race_reading ||= map_csv_omit_zeros(average_prof_by_race_reading)
  end

  def load_average_writing_prof_by_race
    average_prof_by_race_writing = "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
    @average_prof_by_race_writing ||= map_csv_omit_zeros(average_prof_by_race_writing)
  end

  def load_median_household_income
    median_household_income = "./data/Median household income.csv"
    @median_household_income ||= map_csv_omit_zeros(median_household_income)
  end

  def load_school_aged_children_in_poverty
    school_aged_children_poverty = "./data/School-aged children in poverty.csv"
    @school_aged_children_poverty ||= map_csv_omit_zeros(school_aged_children_poverty)
  end

  def load_students_reduced_priced_lunch
    reduced_price_lunch = "./data/Students qualifying for free or reduced price lunch.csv"
    @reduced_price_lunch ||= map_csv_omit_zeros(reduced_price_lunch)
  end

  def load_title_one_students
    title_one_students = "./data/Title I students.csv"
    @title_one_students ||= map_csv_omit_zeros(title_one_students)
  end

  def map_csv_omit_zeros(file)
    CSV.open(file, {headers: true, header_converters: :symbol})
       .to_a.map { |row| row.to_hash unless row[:data].to_f == 0.0 }.compact
  end

  def map_csv(file)
    CSV.open(file, {headers: true, header_converters: :symbol})
       .to_a.map { |row| row.to_hash }
  end
end

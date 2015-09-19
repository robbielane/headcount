require 'csv'

class EconomicProfileLoader
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

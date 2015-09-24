require_relative 'district_repository'
require_relative 'errors'

class HeadcountAnalyst
SUBJECTS = [:math, :reading, :writing]

  attr_reader :all_districts, :repository
  def initialize(repo)
    @repository = repo
    @all_districts = @repository.find_all_districts
    @statewide_testing_results ||= {}
    @district_growths = {}
  end

  def top_statewide_testing_year_over_year_growth_in_3rd_grade(args={:subject=>:all, :top=>1})
    args[:top] = 1 if !args.keys.include?(:top)
    args[:subject] = :all if !args.keys.include?(:subject)
    data = retrieve_results_for_growth(args.fetch(:subject))
    growths = calculate_top_growth(args, data)
    growths = average_subjects() if args.fetch(:subject) == :all
    growths = calculate_top(args, growths)
  end

  def average_subjects
    averages = []
    @district_growths.each do |subject|
      subject[1].each_with_index do |district, index|
        averages << [district[0], district[1]]
      end
    end

  end

  def calculate_top_growth(args, data)
    if args.fetch(:subject) == :all
      SUBJECTS.each { |one_subject| @district_growths[one_subject] = calculate_top_growth({:subject=>one_subject.to_sym, :top=>1}, data) }
    end
    data[args.fetch(:subject)].map { |district, scores| [district, ((scores.values.max - scores.values.min) / (scores.keys.max - scores.keys.min))] if !scores.empty? }.compact
                 .select { |district| !district[1].nan? }
  end

  def calculate_top(args, data)
    data = data.max_by(args.fetch(:top)) { |district| district[1] }
        .map { |row| [row[0], row[1].to_s[0..4].to_f] }
    data = data.flatten if args.fetch(:top) == 1
    data
  end

  def retrieve_results_for_growth(subject)
    if subject == :all
      SUBJECTS.each { |subject| retrieve_results_for_growth(subject) }
    else
      calculate_growth_results(subject)
    end
    @statewide_testing_results
  end

  def calculate_growth_results(subject)
    key = {}
    all_districts.each do |district|
      data_for_district = district.statewide_testing.proficient_by_grade(3)
      value = {}
      data_for_district.each do |row|
        value[row[0]] = row[1].fetch(subject) if row[1].keys.include?(subject)
      end
      key[district.name] = value
      @statewide_testing_results[subject] = key
    end
  end

  def kindergarten_participation_rate_variation(district_name, args)
    district = repository.find_by_name(district_name)
    raise UnknownDataError if district.nil?
    against = repository.find_by_name(args.fetch(:against))
    raise UnknownDataError if against.nil?
    district_average = find_average_of_kidergarten_rates(district)
    against_average =  find_average_of_kidergarten_rates(against)
    difference = district_average / against_average
    difference.to_s[0..4].to_f
  end

  def kindergarten_participation_against_household_income(district_name)
    state = repository.find_by_name("COLORADO")
    district = repository.find_by_name(district_name)
    state_average = calculate_median_income_average(state)
    district_average = calculate_median_income_average(district)
    difference = district_average / state_average.to_f
    kindergarten_rate = kindergarten_participation_rate_variation(district_name, against: 'COLORADO')
    variation = kindergarten_rate / difference
    variation.to_s[0..4].to_f
  end

  def kindergarten_participation_correlates_with_household_income(args)
    if args.fetch(:for).upcase == "COLORADO"
      check_correlation_for_all_districts
    else
      household_income = kindergarten_participation_against_household_income(args.fetch(:for))
      household_income > 0.6 && household_income < 1.5 ? true : false
    end
  end

  def check_correlation_for_all_districts
    disticts_correlate = []
    all_districts.each_with_index do |district, index|
      household_income = kindergarten_participation_against_household_income(district.name)
      disticts_correlate << (household_income > 0.6 && household_income < 1.5) ? true : false
    end

    disticts_correlate.count > (all_districts.count * 0.7) ? false : true
  end

  def calculate_median_income_average(district)
    data = district.economic_profile.median_household_income_by_year
    return 1 if data.values.count == 0
    total = data.values.reduce(0, :+) / data.values.count if data.values.count != 0
  end

  def find_average_of_kidergarten_rates(district)
    data = district.enrollment.kindergarten_participation_by_year
    return 1 if data.values.count == 0
    total = (data.values.reduce(0, :+) / data.keys.count)
  end

end

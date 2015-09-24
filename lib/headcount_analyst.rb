require_relative 'district_repository'

class HeadcountAnalyst
SUBJECTS = [:math, :reading, :writing]

  attr_reader :all_districts, :repository
  def initialize(repo)
    @repository = repo
    @all_districts = @repository.find_all_districts
    @statewide_testing_results ||= {:math=>{},:writing=>{},:reading=>{}, :all=>{}}
    @district_growths = {}
  end

  def top_statewide_testing_year_over_year_growth_in_3rd_grade(args={:subject=>:all, :top=>1})
    args[:top] = 1 if !args.keys.include?(:top)
    args[:subject] = :all if !args.keys.include?(:subject)
    data = retrieve_results(args.fetch(:subject))
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
    binding.pry
  end

  def calculate_top_growth(args, data)
    if args.fetch(:subject) == :all
      SUBJECTS.each { |one_subject| @district_growths[one_subject] = calculate_top_growth({:subject=>one_subject.to_sym, :top=>1}, data) }
    end
    data[args.fetch(:subject)].map { |district, scores| [district, ((scores.values.max - scores.values.min) / (scores.keys.max - scores.keys.min))] if !scores.empty? }.compact
                 .select { |district| !district[1].nan? }
  end

  def calculate_top(args, data)
    data.max_by(args.fetch(:top)) { |district| district[1] }
        .map { |row| [row[0], row[1].to_s[0..4].to_f] }
    data.flatten if args.fetch(:top) == 1
  end

  def retrieve_results(subject)
    if subject == :all
      SUBJECTS.each { |subject| retrieve_results(subject) }
    else
      hash1 = {}
      all_districts.each do |district|
        data_for_district = district.statewide_testing.proficient_by_grade(3)
        hash2 = {}
        data_for_district.each do |row|
          hash2[row[0]] = row[1].fetch(subject) if row[1].keys.include?(subject)
        end
        hash1[district.name] = hash2
        @statewide_testing_results[subject] = hash1
      end
    end
    @statewide_testing_results
  end


end

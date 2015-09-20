require_relative 'district_repository'

class HeadcountAnalyst
  attr_reader :all_districts, :repository
  def initialize(repo)
    @repository = repo
    @all_districts = @repository.find_all_districts
  end

  def top_statewide_testing_year_over_year_growth(subject)
    hash1 = {}
    all_districts.each do |district|
      data_for_district = district.statewide_testing.proficient_by_grade(3)
      hash2 = {}
      data_for_district.each do |row|
        hash2[row[0]] = row[1].fetch(subject)
      end
      hash1[district.name] = hash2
    end
    hash1
  end


end

dr = DistrictRepository.new
dr.load("./data/")
ha = HeadcountAnalyst.new(dr)
binding.pry
ha.top_statewide_testing_year_over_year_growth(:math)

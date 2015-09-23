require_relative 'district_repository'

class HeadcountAnalyst
  attr_reader :all_districts, :repository
  def initialize(repo)
    @repository = repo
    @statewide_testing_results = {:math=>{},:writing=>{},:reading=>{} }
    @all_districts = @repository.find_all_districts
  end

  def top_statewide_testing_year_over_year_growth_in_3rd_grade(subject)
    data = retrieve_results(subject)
    data = data.map { |district, scores| [district, ((scores.values.max - scores.values.min) / (scores.keys.max - scores.keys.min))] if !scores.empty? }.compact
               .select { |district| !district[1].nan? }
               .max_by { |district| district[1] }
    data = [data[0], data[1].to_s[0..4].to_f]
  end


  def retrieve_results(subject)
    hash1 = {}
    all_districts.each do |district|
      data_for_district = district.statewide_testing.proficient_by_grade(3)
      hash2 = {}
      data_for_district.each do |row|
        hash2[row[0]] = row[1].fetch(subject) if row[1].keys.include?(subject)
      end
      hash1[district.name] = hash2
    end
    @statewide_testing_results[subject] = hash1
  end


end

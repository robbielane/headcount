require 'csv'
require_relative 'district'
require_relative 'loader'
require 'pry'


class DistrictRepository
  attr_reader :districts

  def initialize(data)
    @districts = data
    @loader = Loader
  end

  def self.from_csv(dir)
    csvs = Dir.glob(File.join(dir, '*'))
    csvs.each do |file|
      @districts = CSV.open(file, {headers: true, header_converters: :symbol})
                 .to_a.map {|row| row[:location] }
                 .uniq
    end
    DistrictRepository.new(@districts)
  end

  def load(dir)
    csvs = Dir.glob(File.join(dir, '*'))
    csvs.each do |file|
      @districts = CSV.open(file, {headers: true, header_converters: :symbol})
                 .to_a.map {|row| row[:location] }
                 .uniq
    end
  end



  def find_by_name(name)
    @districts.each do |potential_name|
      if name.upcase == potential_name || name.capitalize == "Colorado"
        return District.new(potential_name, @loader)
      end
    end
    nil
  end

  def find_all_matching(name)
    matching = []
    @districts.each do |district_name|
      matching << District.new(district_name) if district_name.upcase.include?(name.upcase)
    end
    matching
  end

  def find_all_districts
    all_districts = []
    @districts.each { |district| all_districts << District.new(district, @loader) }
    all_districts
  end
end

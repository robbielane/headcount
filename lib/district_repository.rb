require 'csv'
require 'json'
require_relative 'district'
require_relative 'loader'
require 'pry'

class JsonLoader
  attr_reader :districts_data
  def initialize(districts_data)
    @districts_data = districts_data
  end

  def district_names
    districts_data.map { |name, district_data| district_data.fetch :name }
  end
end


class DistrictRepository
  attr_reader :districts

  def initialize(district_names, loader)
    @districts = district_names
    @loader    = loader
  end

  def self.from_csv(dir)
    csvs      = Dir.glob(File.join(dir, '*.csv'))
    districts = []
    csvs.each do |file|
      districts = CSV.open(file, {headers: true, header_converters: :symbol})
                     .to_a.map {|row| row[:location] }
                     .uniq
    end
    DistrictRepository.new(districts, Loader.new(dir))
  end

  def self.from_json(dir)
    filename  = File.join(dir, "districts.json")
    json      = File.read(filename)
    districts = JSON.parse(json, symbolize_names: true)
    loader    = JsonLoader.new(districts)
    DistrictRepository.new(loader.district_names, loader)
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

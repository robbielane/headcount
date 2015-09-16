require 'csv'
require_relative 'district'
require 'pry'


class DistrictRepository
  attr_reader :districts

  def initialize
    @districts = []
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
    @districts.each do |district|
      if name.upcase == district
        return District.new(district)
      end
    end
    nil
  end

  def find_all_matching(name)
    @districts.select do |district|
      district if district.include?(name.upcase)
    end
  end
end

dr = DistrictRepository.new
dr.load('./data')

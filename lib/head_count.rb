class DistrictRepository
attr_reader :name

  def initialize
    @district = District.new(name)
  end

  def load(directory)
    data_files = Dir.entries(directory)
    split_into_files(data_files)
  end

  def split_into_files(files)
    files.shift(2)
    files.each do |file|
      open_each_file(file)
    end
  end

  def open_each_file(file)
    rows = File.readlines("./data/#{file}")
    require 'pry'
    binding.pry
    split_into_rows(rows)
  end

  def split_into_rows(rows)
    rows.split(',').map do |row|

    end
  end

  def find_by_name(name)

  end

  def find_all_matching(chunk)

  end
end


class District
  attr_reader :name

  def initialize(name)
    @name = name
  end

end

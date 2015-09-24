class TestHelper < Minitest::Test
  def self.data_dir
    File.expand_path '../data', __dir__
  end

  def self.repo
    @repo ||= DistrictRepository.from_csv(data_dir)
  end

  def repo
    TestHelper.repo
  end

  def example
    repo.find_by_name('ACADEMY 20')
  end
end

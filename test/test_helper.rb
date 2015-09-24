
class TestHelper < Minitest::Test
  def self.data_dir
    File.expand_path '../data', __dir__
  end

  def self.dr
    @dr ||= DistrictRepository.from_csv(data_dir)
  end

  def dr
    TestHelper.dr
  end
end

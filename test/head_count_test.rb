require 'head_count'

class HeadCountTest < Minitest::Test

  def test_district_repository_returns_district_instances_by_name
    district_expected = District.new("ACADEMY 20")
    dr = DistrictRepository.new
    dr.load('./data')
    district = dr.find_by_name("ACADEMY 20")

    assert_equal district_expected, district
  end

  def test_district_repository_returns_all_matching_district_instances_by_fragmented_name
    skip
    district_expected = District.new("ACADEMY 20")
    dr = DistrictRepository.new
    dr.load('./data')
    district = dr.find_by_name("ACAD")

    assert_equal district_expected, district
  end

end

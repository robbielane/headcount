require_relative '../lib/district_repository'

class DistrictRepositoryTest < Minitest::Test
  def setup
    @dr = DistrictRepository.new
    @dr.from_csv('./data')
  end

  def test_find_by_name
    assert_instance_of District, @dr.find_by_name('akron r-1')
  end

  def test_find_by_name_returns_nil_when_not_found
    assert_nil @dr.find_by_name('madison')
  end

  def test_find_all_matching
    assert_equal ["DENVER COUNTY 1", "HAYDEN RE-1"], @dr.find_all_matching('den')
  end

  def test_find_all_matching_returns_empty_array_when_none_match
    assert_equal [], @dr.find_all_matching('xyz')
  end
end

require_relative '../lib/district'

class DistrictTest < Minitest::Test
  def test_name_returns_upcased_string
    district = District.new('DENVER COUNTY 1')

    assert_equal 'DENVER COUNTY 1', district.name
  end

  def test_statewide_testing_returns_instance_of_statewidetesting
    district = District.new('DENVER COUNTY 1')

    assert_instance_of StatewideTesting, district.statewide_testing
  end

  def test_enrollment_testing_returns_instance_of_enrollment
    district = District.new('DENVER COUNTY 1')

    assert_instance_of Enrollment, district.enrollment
  end
end

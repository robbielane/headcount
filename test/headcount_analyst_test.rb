require_relative '../lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  def repo
    repo ||= DistrictRepository.from_csv('./data')
  end

  def ha
    ha ||= HeadcountAnalyst.new(repo)
  end

  def test_where_the_most_growth_is_happening_state_wide
    skip
    assert_equal ["WILEY RE-13 JT", 0.300],
      ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:subject => :math)
  end

  def test_where_the_most_growth_is_happening_state_wide_top_3
    skip
    expected = [["WILEY RE-13 JT", 0.300], ["LA VETA RE-2", 0.162],
                  ["LAKE COUNTY R-1", 0.112]]
    actual = ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(top: 3, subject: :math)

    assert_equal expected, actual
  end

  def test_where_the_most_growth_is_happening_state_wide_returns_average_of_all_subjects
    assert_equal ["Some School", 0.345], ha.top_statewide_testing_year_over_year_growth_in_3rd_grade
  end

end

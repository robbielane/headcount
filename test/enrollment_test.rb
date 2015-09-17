require_relative '../lib/enrollment'
require 'pry'

class StatewideTestingTest < Minitest::Test
  def test_dropout_rate_in_year_returns_float_for_given_year
    example = Enrollment.new("ACADEMY 20")

    assert_equal 0.002, example.dropout_rate_in_year(2011)
  end

  def test_dropout_rate_by_gender_in_year_returns_float_for_given_year
    example = Enrollment.new("ACADEMY 20")
    expected_result = {:female => 0.002, :male => 0.002}

    assert_equal expected_result, example.dropout_rate_by_gender_in_year(2011)
  end

  def test_dropout_rate_by_race_in_year_returns_hash_of_floats_for_given_year
    example = Enrollment.new("ACADEMY 20")
    expected_result = {:asian => 0,
                       :black => 0,
                       :pacific_islander => 0,
                       :hispanic => 0.004,
                       :native_american => 0,
                       :two_or_more => 0,
                       :white => 0.002}


    assert_equal expected_result, example.dropout_rate_by_race_in_year(2011)
  end

  def test_dropout_rate_for_race_or_ethnicity_returns_hash_of_years_and_floats
    example = Enrollment.new("ACADEMY 20")
    expected_result = {2011 => 0.000,
                       2012 => 0.007}

    assert_equal expected_result, example.dropout_rate_for_race_or_ethnicity(:asian)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_float
    example = Enrollment.new("ACADEMY 20")

    assert_equal 0.006, example.dropout_rate_for_race_or_ethnicity_in_year(:hispanic, 2012)
  end

  def test_graduation_rate_by_year_returns_a_hash_with_years_as_keys_pointing_to_floats
    example = Enrollment.new("ACADEMY 20")
    expected_result = {2010 => 0.895,
                       2011 => 0.895,
                       2012 => 0.889,
                       2013 => 0.913,
                       2014 => 0.898,
                       }
    assert_equal expected_result, example.graduation_rate_by_year
  end
end

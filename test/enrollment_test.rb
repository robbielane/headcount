require_relative '../lib/enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test

  def example
    Enrollment.new("ACADEMY 20")
  end

  def test_dropout_rate_in_year_returns_float_for_given_year

    assert_equal 0.002, example.dropout_rate_in_year(2011)
    assert_nil example.dropout_rate_in_year(3030)
  end

  def test_dropout_rate_by_gender_in_year_returns_float_for_given_year
    expected_result = {:female => 0.002, :male => 0.002}

    assert_equal expected_result, example.dropout_rate_by_gender_in_year(2011)
    assert_nil example.dropout_rate_by_gender_in_year(3030)
  end

  def test_dropout_rate_by_race_in_year_returns_hash_of_floats_for_given_year
    expected_result = {:asian => 0,
                       :black => 0,
                       :pacific_islander => 0,
                       :hispanic => 0.004,
                       :native_american => 0,
                       :two_or_more => 0,
                       :white => 0.002}


    assert_equal expected_result, example.dropout_rate_by_race_in_year(2011)
    assert_nil example.dropout_rate_by_race_in_year(3030)
  end

  def test_dropout_rate_for_race_or_ethnicity_returns_hash_of_years_and_floats
    expected_result = {2011 => 0.000,
                       2012 => 0.007}

    assert_equal expected_result, example.dropout_rate_for_race_or_ethnicity(:asian)
    assert_raises UnknownRaceError do example.dropout_rate_for_race_or_ethnicity(:bob) end
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_float
    assert_equal 0.006, example.dropout_rate_for_race_or_ethnicity_in_year(:hispanic, 2012)
    assert_nil example.dropout_rate_for_race_or_ethnicity_in_year(:hispanic, 3030)
    assert_raises UnknownRaceError do example.dropout_rate_for_race_or_ethnicity_in_year(:blue, 2012) end
   end

  def test_graduation_rate_by_year_returns_a_hash_with_years_as_keys_pointing_to_floats
    expected_result = {2010 => 0.895,
                       2011 => 0.895,
                       2012 => 0.889,
                       2013 => 0.913,
                       2014 => 0.898,
                       }
    assert_equal expected_result, example.graduation_rate_by_year
  end

  def test_graduation_rate_in_year_returns_float
    assert_equal 0.895, example.graduation_rate_in_year(2011)
    assert_nil example.graduation_rate_in_year(3030)
  end

  def test_kindergarten_participation_by_year
    expected_result = {2007 =>0.391,
                       2006 =>0.353,
                       2005 =>0.267,
                       2004 =>0.302,
                       2008 =>0.384,
                       2009 =>0.39,
                       2010 =>0.436,
                       2011 =>0.489,
                       2012 =>0.478,
                       2013 =>0.487,
                       2014 =>0.490
                     }
    assert_equal expected_result, example.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year
    assert_equal 0.478, example.kindergarten_participation_in_year(2012)
    assert_nil example.kindergarten_participation_in_year(3030)
  end

  def test_online_participation_by_year
    expected_result = {2011 => 33,
                       2012 => 35,
                       2013 => 341,}
    assert_equal expected_result, example.online_participation_by_year
  end

  def test_online_participation_in_year
    assert_equal 341, example.online_participation_in_year(2013)
    assert_nil example.online_participation_in_year(3030)
  end

  def test_participation_by_year
    expected_result = {2009 => 22620,
                      2010 => 23119,
                      2011 => 23657,
                      2012 => 23973,
                      2013 => 24481,
                      2014 => 24578,}
    assert_equal expected_result, example.participation_by_year
  end

  def test_participation_in_year
    assert_equal 23119, example.participation_in_year(2010)
    assert_nil example.participation_in_year(3030)
  end

  def test_participation_by_race_or_ethnicity
    expected_result = {2007 => 0.05,
                      2008 => 0.054,
                      2009 => 0.055,
                      2010 => 0.04,
                      2011 => 0.036,
                      2012 => 0.038,
                      2013 => 0.038,
                      2014 => 0.037}
    assert_equal expected_result, example.participation_by_race_or_ethnicity(:asian)
    assert_raises UnknownRaceError do example.participation_by_race_or_ethnicity(:joe) end
  end

  def test_participation_by_race_or_ethnicity_in_year
    expected_result = {:asian => 0.038,
                      :black => 0.031,
                      :pacific_islander => 0.004,
                      :hispanic => 0.121,
                      :native_american => 0.004,
                      :two_or_more => 0.053,
                      :white => 0.75}

    assert_equal expected_result, example.participation_by_race_or_ethnicity_in_year(2012)
    assert_nil example.participation_by_race_or_ethnicity_in_year(3030)
  end


  def test_special_education_by_year
    expected_result = {2009 => 0.075,
                      2010 => 0.078,
                      2011 => 0.079,
                      2012 => 0.078,
                      2013 => 0.079,
                      2014 => 0.079,}

    assert_equal expected_result, example.special_education_by_year
  end

  def test_special_education_in_year
    assert_equal 0.078, example.special_education_in_year(2012)
    assert_nil example.special_education_in_year(3030)
  end

  def test_remediation_by_year
    expected_result = {2009 => 0.264,
                       2010 => 0.294,
                       2011 => 0.263,}

    assert_equal expected_result, example.remediation_by_year
  end

  def test_remediation_in_year
    assert_equal 0.263, example.remediation_in_year(2011)
    assert_nil example.remediation_in_year(3030)
  end
end

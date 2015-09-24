require_relative '../lib/enrollment'
require_relative 'test_helper'

class EnrollmentTest < TestHelper
  def test_dropout_rate_in_year_returns_data_for_given_year
    assert_equal 0.002, example.enrollment.dropout_rate_in_year(2011)
    assert_nil example.enrollment.dropout_rate_in_year(3030)
  end

  def test_dropout_rate_by_gender_in_year_returns_data_for_given_year
    expected_result = {:female => 0.002, :male => 0.002}

    assert_equal expected_result, example.enrollment.dropout_rate_by_gender_in_year(2011)
    assert_nil example.enrollment.dropout_rate_by_gender_in_year(3030)
  end

  def test_dropout_rate_by_race_in_year_returns_hash_of_data_for_given_year
    expected_result = {:asian => 0,
                       :black => 0,
                       :pacific_islander => 0,
                       :hispanic => 0.004,
                       :native_american => 0,
                       :two_or_more => 0,
                       :white => 0.002}


    assert_equal expected_result, example.enrollment.dropout_rate_by_race_in_year(2011)
    assert_nil example.enrollment.dropout_rate_by_race_in_year(3030)
  end

  def test_dropout_rate_for_race_or_ethnicity_returns_hash_of_years_and_data
    expected_result = {2011 => 0.000,
                       2012 => 0.007}

    assert_equal expected_result, example.enrollment.dropout_rate_for_race_or_ethnicity(:asian)
    assert_raises UnknownRaceError do example.enrollment.dropout_rate_for_race_or_ethnicity(:bob) end
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year_returns_data_for_given_year_and_ethnicity
    assert_equal 0.006, example.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:hispanic, 2012)
    assert_nil example.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:hispanic, 3030)
    assert_raises UnknownRaceError do example.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:blue, 2012) end
   end

  def test_graduation_rate_by_year_returns_hash_of_years_and_data
    expected_result = {2010 => 0.895,
                       2011 => 0.895,
                       2012 => 0.889,
                       2013 => 0.913,
                       2014 => 0.898,
                       }
    assert_equal expected_result, example.enrollment.graduation_rate_by_year
  end

  def test_graduation_rate_in_year_returns_data_for_given_year
    assert_equal 0.895, example.enrollment.graduation_rate_in_year(2011)
    assert_nil example.enrollment.graduation_rate_in_year(3030)
  end

  def test_kindergarten_participation_by_year_returns_hash_of_years_and_data
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
    assert_equal expected_result, example.enrollment.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year_returns_data_for_given_year
    assert_equal 0.478, example.enrollment.kindergarten_participation_in_year(2012)
    assert_nil example.enrollment.kindergarten_participation_in_year(3030)
  end

  def test_online_participation_by_year_returns_hash_of_year_and_data
    expected_result = {2011 => 33,
                       2012 => 35,
                       2013 => 341,}
    assert_equal expected_result, example.enrollment.online_participation_by_year
  end

  def test_online_participation_in_year_returns_data_for_given_year
    assert_equal 341, example.enrollment.online_participation_in_year(2013)
    assert_nil example.enrollment.online_participation_in_year(3030)
  end

  def test_participation_by_year_returns_hash_of_year_and_data
    expected_result = {2009 => 22620,
                      2010 => 23119,
                      2011 => 23657,
                      2012 => 23973,
                      2013 => 24481,
                      2014 => 24578,}
    assert_equal expected_result, example.enrollment.participation_by_year
  end

  def test_participation_in_year_returns_data_for_given_year
    assert_equal 23119, example.enrollment.participation_in_year(2010)
    assert_nil example.enrollment.participation_in_year(3030)
  end

  def test_participation_by_race_or_ethnicity_returns_hash_of_year_and_data
    expected_result = {2007 => 0.05,
                      2008 => 0.054,
                      2009 => 0.055,
                      2010 => 0.04,
                      2011 => 0.036,
                      2012 => 0.038,
                      2013 => 0.038,
                      2014 => 0.037}
    assert_equal expected_result, example.enrollment.participation_by_race_or_ethnicity(:asian)
    assert_raises UnknownRaceError do example.enrollment.participation_by_race_or_ethnicity(:joe) end
  end

  def test_participation_by_race_or_ethnicity_in_year_returns_data_for_all_ethnicities_for_given_year
    expected_result = {:asian => 0.038,
                      :black => 0.031,
                      :pacific_islander => 0.004,
                      :hispanic => 0.121,
                      :native_american => 0.004,
                      :two_or_more => 0.053,
                      :white => 0.75}

    assert_equal expected_result, example.enrollment.participation_by_race_or_ethnicity_in_year(2012)
    assert_nil example.enrollment.participation_by_race_or_ethnicity_in_year(3030)
  end


  def test_special_education_by_year_returns_hash_of_years_and_data
    expected_result = {2009 => 0.075,
                      2010 => 0.078,
                      2011 => 0.079,
                      2012 => 0.078,
                      2013 => 0.079,
                      2014 => 0.079,}

    assert_equal expected_result, example.enrollment.special_education_by_year
  end

  def test_special_education_in_year_returns_data_for_given_year
    assert_equal 0.078, example.enrollment.special_education_in_year(2012)
    assert_nil example.enrollment.special_education_in_year(3030)
  end

  def test_remediation_by_year_returns_hash_of_years_and_data
    expected_result = {2009 => 0.264,
                       2010 => 0.294,
                       2011 => 0.263,}

    assert_equal expected_result, example.enrollment.remediation_by_year
  end

  def test_remediation_in_year_returns_data_for_given_year
    assert_equal 0.263, example.enrollment.remediation_in_year(2011)
    assert_nil example.enrollment.remediation_in_year(3030)
  end
end

require_relative 'economic_profile'

class EconomicProfileTest < Minitest::Test
  def example
    EconomicProfile.new("ACADEMY 20")
  end

  def test_free_or_reduced_lunch_by_year_returns_data_from_all_years
    expected_result = { 2000 => 0.020,
                        2001 => 0.024,
                        2002 => 0.027,
                        2003 => 0.030,
                        2004 => 0.034,
                        2005 => 0.058,
                        2006 => 0.041,
                        2007 => 0.050,
                        2008 => 0.061,
                        2009 => 0.070,
                        2010 => 0.079,
                        2011 => 0.084,
                        2012 => 0.125,
                        2013 => 0.091,
                        2014 => 0.087,}
    assert_equal expected_result, example.free_or_reduced_lunch_by_year
  end
end

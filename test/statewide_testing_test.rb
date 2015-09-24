require_relative '../lib/statewide_testing'
require 'pry'

class StatewideTestingTest < Minitest::Test
  def example
    dr.find_by_name("ACADEMY 20").statewide_testing
  end

  def dr
    dr ||= DistrictRepository.from_csv("./data")
  end

  def test_proficient_by_grade_returns_formatted_hash_for_given_grade
    result = {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671},
              2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706},
              2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662},
              2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678},
              2012=>{:math=>0.83, :reading=>0.87, :writing=>0.655},
              2013=>{:math=>0.855, :reading=>0.859, :writing=>0.668},
              2014=>{:math=>0.834, :reading=>0.831, :writing=>0.639}}

    assert_equal result, example.proficient_by_grade(3)
    assert_raises UnknownDataError do example.proficient_by_grade(5) end
  end

  def test_proficient_by_race_returns_formatted_hash_for_given_race
    result = {2011=>{:math=>0.816, :reading=>0.897, :writing=>0.826},
              2012=>{:math=>0.818, :reading=>0.893, :writing=>0.808},
              2013=>{:math=>0.805, :reading=>0.901, :writing=>0.81},
              2014=>{:math=>0.8, :reading=>0.855, :writing=>0.789}}

    assert_equal result, example.proficient_by_race_or_ethnicity(:asian)
  end

  def test_it_raises_error_if_race_input_is_false
    assert_raises UnknownDataError do example.proficient_by_race_or_ethnicity(:jack) end
  end

  def test_porficient_for_subject_by_grade_in_year_returns_data
    assert_equal 0.819, example.proficient_for_subject_by_grade_in_year(:math, 3, 2011)
    assert_raises UnknownDataError do example.proficient_for_subject_by_grade_in_year(:history, 3, 2011) end
    assert_raises UnknownDataError do example.proficient_for_subject_by_grade_in_year(:history, 5, 2011) end
  end

  def test_proficient_for_subject_by_race_in_year_returns_data_specific_to_subject_race_and_year
    assert_equal 0.826 , example.proficient_for_subject_by_race_in_year(:writing, :asian, 2011)
    assert_raises UnknownDataError do example.proficient_for_subject_by_race_in_year(:reading, :green, 2011) end
    assert_raises UnknownDataError do example.proficient_for_subject_by_race_in_year(:history, :black, 2011) end
  end

  def test_proficient_for_subject_in_year
    assert_equal 0.680, example.proficient_for_subject_in_year(:math, 2011)
    assert_equal 0.689, example.proficient_for_subject_in_year(:math, 2012)
  end
end

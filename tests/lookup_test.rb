require 'minitest/autorun'
require_relative 'capybara_test_case'

class TestLookup < CapybaraTestCase
  def test_keywords_redirect
    visit "/cgi-bin/lookup.cgi?q=apple&utf8=%E2%9C%93"
    assert_current_path "/cgi-bin/search.cgi?q=apple&utf8=%E2%9C%93"
  end

  def test_utf8_canary_dreampassport3_redirect
    visit "/cgi-bin/lookup.cgi?q=dricas&utf8=%EF%BF%BD%13"
    assert_current_path "/cgi-bin/search.cgi?q=dricas&utf8=%EF%BF%BD%13"
  end

  def test_utf8_canary_safari_jis_redirect
    visit "/cgi-bin/lookup.cgi?q=apple&utf8=%EF%BF%BD%26%2365533%3B"
    assert_current_path "/cgi-bin/search.cgi?q=apple&utf8=%EF%BF%BD%26%2365533%3B"
  end

  def test_empty_parameters
    visit "/cgi-bin/lookup.cgi?q="
    assert_current_path "/cgi-bin/lookup.cgi?q="

    assert_title "Wayback Classic - Error"
    assert_text "A `q` parameter must be supplied, and no other parameters are accepted"
  end

  def test_no_parameters
    visit "/cgi-bin/lookup.cgi"
    assert_current_path "/cgi-bin/lookup.cgi"

    assert_title "Wayback Classic - Error"
    assert_text "A `q` parameter must be supplied, and no other parameters are accepted"
  end

  def test_invalid_parameters
    visit "/cgi-bin/lookup.cgi?q=twitter&utm_medium=evil"
    assert_current_path "/cgi-bin/lookup.cgi?q=twitter&utm_medium=evil"

    assert_title "Wayback Classic - Error"
    assert_text "A `q` parameter must be supplied, and no other parameters are accepted"
  end
end

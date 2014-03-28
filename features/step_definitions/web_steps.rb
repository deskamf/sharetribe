# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.


require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module FillInHelpers
  def fill_in_first(locator, options={})
    # Highly inspired by Capybara's fill_in implementation
    # https://github.com/jnicklas/capybara/blob/80befdad73c791eeaea50a7cbe23f04a445a24bc/lib/capybara/node/actions.rb#L50
    raise "Must pass a hash containing 'with'" if not options.is_a?(Hash) or not options.has_key?(:with)
    with = options.delete(:with)
    first(:fillable_field, locator, options).set(with)
  end

  def fill_in_nth(locator, n, options={})
    # Highly inspired by Capybara's fill_in implementation
    # https://github.com/jnicklas/capybara/blob/80befdad73c791eeaea50a7cbe23f04a445a24bc/lib/capybara/node/actions.rb#L50
    raise "Must pass a hash containing 'with'" if not options.is_a?(Hash) or not options.has_key?(:with)
    with = options.delete(:with)
    results = all(:fillable_field, locator, options)
    if results.size >= n
      results[n - 1].set(with)
    end
  end
end
World(FillInHelpers)

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

When /^(?:|I )press submit(?: within "([^"]*)")?$/ do |selector|
  with_scope(selector) do
    find("[type=submit]").click
  end
end

When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^I remove the focus"?$/ do
  page.execute_script("$('input').blur();")
end

Then /^there should be an active ajax request$/ do
  # WARNING! This step is unreliable!
  # Some ajax requests are faster than the polling interval, thus
  # this step never sees the ajax request and thinks there never
  # were any requests
  expect { page.evaluate_script("$.active") > 0 }.to become_true
end

When /^ajax requests are completed$/ do
  expect { page.evaluate_script("$.active") == 0 }.to become_true
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )fill in (first|second|third) "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |ordinal, field, value, selector|
  nums = {"first" => 1, "second" => 2, "third" => 3}
  n = nums[ordinal]

  with_scope(selector) do
    fill_in_nth(field, n, :with => value)
  end
end

When(/^I send keys "(.*?)" to form field "([^"]*)"$/) do |keys, field|
  find_field(field).native.send_keys "#{keys}"
end

When /^(?:|I )wait for (\d+) seconds?$/ do |arg1|
  sleep Integer(arg1)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      When %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /^(?:|I )check "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|I )uncheck "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

When /^(?:|I )choose "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"(?: within "([^"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, path)
  end
end

Then /^(?:|I )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /^(?:|I )should see "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end
end

Then /^I should see "([^"]*)" in the "([^"]*)" input$/ do |content, field|
  find_field(field).value.should == content
end

Then /^(?:|I )should not see "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
  end
end

Then /^I should see dropdown field with label "([^"]*)"$/ do |label|
  find_field(label).tag_name == "select"
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_xpath('//*', :text => regexp)
    else
      assert page.has_no_xpath?('//*', :text => regexp)
    end
  end
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should contain "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should not contain "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within "([^"]*)")? should be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within "([^"]*)")? should not be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
  
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

# This is a workaround for PhantomJS, which doesn't (or actually WebDriver) support confirm dialogs.
# Use this keyword BEFORE the confirmation dialog appears
Given /^I will(?:| (not)) confirm all following confirmation dialogs if I am running PhantomJS$/ do |do_not_confirm|
  confirm = do_not_confirm != "not"
  if ENV['PHANTOMJS'] then
    page.execute_script("window.__original_confirm = window.confirm; window.confirm = function() { return #{confirm}; };")
  end
end

When /^I confirm alert popup$/ do
  page.driver.browser.switch_to.alert.accept unless ENV['PHANTOMJS']
end

Then /^I should see validation error$/ do
  find("label.error").should be_visible
end

Then /^I should see (\d+) validation errors$/ do |errors_count|
  errors = all("label.error");
  errors.size.should eql(errors_count.to_i)
  all("label.error").each { |error| error.should be_visible }
end

Then /^take a screenshot$/ do
  save_screenshot('screenshot.png')
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I navigate to invitations page$/ do
  steps %Q{
    When I click ".user-menu-toggle"
    When I follow "Invite"
  }
end

When /^I refresh the page$/ do
  visit(current_path)
end

When /^I hover "([^"]*)"$/ do |selector|
  find(selector).hover
end

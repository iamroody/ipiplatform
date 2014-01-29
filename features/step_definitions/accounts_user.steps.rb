When(/^I am not logged in$/) do
  page.should_not have_selector("#user_profile")
end

When(/^I go to create an account$/) do
  find("#create_account").click
end

When(/^I fill in all required account fields$/) do
  step "I fill in \"user_name\" with \"name\""
  step "I fill in \"user_email\" with \"email\""
  step "I fill in \"user_password\" with \"password\""
  step "I fill in \"user_password_confirmation\" with \"password\""
  find(".submitbutton").click
end

Then(/^I should have access to my user profile$/) do
  expect(page.has_css?("#user_profile")).to be_true
end

When(/^I go to log out$/) do
  find("#log_out").click
end

Then(/^I should not have access to my user profile$/) do
  expect(page.has_css?("#user_profile")).to be_false
end

When(/^I change the url to user (.*?) profile page$/) do |user_id|
  @user_profile_page = UsersPage.new(page, user_id)
  @user_profile_page.navigate
end

Then(/^an error message is displayed$/) do
  expect(page.has_xpath?(alert_xpath)).to be_true
end

Then(/^I am on my user profile page/) do
  expect(current_path).to eql("/users/#{@user.id}")
end

Then(/^I should be on the home page$/) do
  expect(current_path).to eql('/')
end

Then(/^I should be on the general value proposition category index page$/) do
  expect(current_path).to eql('/pages/value_proposition_categories')
end


private
  def alert_xpath
    "//*[@class=\"flash\"]"
  end

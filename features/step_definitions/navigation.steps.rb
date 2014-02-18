Given(/^I am on the homepage/) do
  @home_page = HomePage.new(page)
  @home_page.navigate
end

Given(/^I am on the user (.*?) profile page$/) do |user_id|
  @user_profile_page = UsersPage.new(page, user_id)
  @user_profile_page.navigate
end

When(/^I change the url to user (.*?) profile page$/) do |user_id|
  step "I am on the user #{user_id} profile page"
end

When(/^I am on the resources index page$/) do
  @resources_page = ResourcesPage.new
  @resources_page.load
end

Given(/^I am on the add resource page for the last step$/) do
  @new_resource_page = NewResourcePage.new(page, Step.last.id)
  @new_resource_page.navigate
  end

Given(/^I am on the add resource page$/) do
  @new_resource_page = NewResourcePage.new(page, nil)
  @new_resource_page.navigate
end


When (/^I go to the last value proposition show page$/) do
  @show_value_proposition_page = ShowValuePropositionPage.new
  @show_value_proposition_page.load(id: ValueProposition.last.id)
end

When(/^I use the garbage step$/) do
  binding.pry
end

When(/^I navigate to the last resource show page$/) do
  @show_resource_page = ShowResourcePage.new
  @show_resource_page.load(id: Resource.last.id)
end

When(/^I am on the edit step page$/) do
  @edit_step_page = EditStepPage.new
  @edit_step_page.load(id: Step.last.id)
end

When(/^I go to the edit value proposition page for the value proposition$/) do
  @edit_value_proposition_page = EditValuePropositionPage.new
  @edit_value_proposition_page.load(id: @value_proposition.id)
end

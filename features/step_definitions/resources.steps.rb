When(/^I go to the resources index page$/) do
  @resource_page = ResourcePage.new(page)
  @resource_page.navigate
end

When (/^I go to (.*?) color show page$/) do |color|
  @color_show_page = ColorShowPage.new(page)
  @color_show_page.navigate_to_show_page @color.id
end

When(/^I go to one resource's show page$/) do
  step 'I see one resource'
  @resource_page.navigate_to_show_page @resource.id
end

When(/^I visit resource creation page$/) do
  page.find('#new_resource').click
end

When(/^I fill in required resource fields$/) do
  step "I fill in \"resource_name\" with \"name\""
  step "I fill in \"resource_link\" with \"link\""
  step "I fill in \"resource_description\" with \"desc\""
  step "I fill in \"resource_full_description\" with \"full desc\""
  step "I fill in \"resource_source\" with \"source\""
end

When(/^I fill in all resource fields$/) do
  step "I fill in required resource fields"
  step "I fill in \"resource_tag_list\" with \"tag\""
  step "I check the color_id_#{@color.id} box"
  step "I check the phase_id_#{@phase.id} box"
end

When(/^I submit the resource$/) do
  page.find('#submit_resource').click
end

Then(/^I see an error on all required fields$/) do
  expect(page.find('.field_with_errors #resource_name')).to be_true
  expect(page.find('.field_with_errors #resource_link')).to be_true
  expect(page.find('.field_with_errors #resource_description')).to be_true
  expect(page.find('.field_with_errors #resource_full_description')).to be_true
  expect(page.find('.field_with_errors #resource_source')).to be_true
end

When(/^I go to edit the resource$/) do
    page.find("#edit_resource_#{@resource.id}").click
end

When(/^I change the resource name$/) do
  step "I fill in \"resource_name\" with \"#{new_resource_title}\""
end

Then(/^I see one resource$/) do
  @resource = Resource.first if @resource.nil?
  expect(page.has_xpath?(one_resource_xpath)).to be_true
end

Then (/^I see resources of (.*?) colors?$/) do |color_name|
  if color_name.include?('all')
    Resource.all.each do |resource|
      @resource = resource
      expect(page.has_xpath?(one_resource_xpath)).to be_true
    end
  else
    color = Color.find_by_name(color_name)
    color.resources.each do |resource|
      @resource = resource
      expect(page.has_css?("#vp_#{color.id}_#{resource.id}")).to be_true
    end
  end
end

Then(/^I see details about the resource$/) do
  expect(page.has_xpath?(one_resource_title_xpath)).to be_true
end

Then(/^I should be on the new resources page$/) do
  expect(current_path).to eql('/resources/new')
end

Then(/^I see the resource's new name$/) do
  expect(page.has_xpath?(one_resource_title_xpath)).to be_true
  expect(find(:id, "resource_#{@resource.id}_title").text).to eql(new_resource_title)
end

Then(/^I see a notification that the resource was updated$/) do
  expect(page.has_xpath?(notification_xpath)).to be_true
end

Then(/^I am on the resources show page$/) do
  expect(current_path).to eql("/resources/#{@resource.id}")
end


private

def one_resource_xpath
  "//*[@id=\"resource_#{@resource.id}\"]"
end

def one_resource_title_xpath
  "//*[@id=\"resource_#{@resource.id}_title\"]"
end


def one_resource_title_xpath
  "//*[@id=\"resource_#{@resource.id}_title\"]"
end

def new_resource_title
  'Greatest Resource'
end

def notification_xpath
  "//*[@class=\"flash\"]"
end

def current_path
  URI.parse(current_url).path
end
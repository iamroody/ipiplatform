Then(/^I should see one value proposition category$/) do
  expect(page.has_xpath?(one_value_proposition_category_xpath)).to be_true
end

Then(/^I should see one value proposition$/) do
  expect(page.has_xpath?(one_value_proposition_xpath)).to be_true
end

private

  def one_value_proposition_category_xpath
    "//*[@id=\"value_proposition_category_name_#{@value_proposition_category.id}\"]"
  end

  def one_value_proposition_xpath
    "//*[@id=\"value_proposition_id_#{@value_proposition.id}\"]"
  end

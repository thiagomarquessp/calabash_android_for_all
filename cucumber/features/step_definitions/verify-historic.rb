Given(/^I enter on historic screen$/) do
  touch("* id:'btnHistorico'")
end

Then(/^I see the all historic zipcode$/) do
  has_text?("05433001")
end

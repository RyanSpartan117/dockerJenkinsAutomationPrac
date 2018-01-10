Given(/^I am on the iPhone phone page$/) do
	@iphone = Pageobjectclass.new
	@iphone.goToPage
end

Then(/^I can see the image$/) do
	@iphone.findImage
end

And(/^I can go to the iPhone8 phone page$/) do
	@iphone.clickImage

end
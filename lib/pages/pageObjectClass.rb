class Pageobjectclass

	def goToPage
		visit("http://www.three.co.uk/Store/mobile-phones#!?manufacturer=Apple")
	end

	def findImage
		within '.device-list' do
			devices = find_all('.Device')
			devices[0].assert_selector(:link, nil, href: '/iPhone/iPhone-8')
			# page.assert_selector(:link, nil, href: '/razer/phone')
		end
	end

	def clickImage
		link = find('a[href="/iPhone/iPhone-8"]')
		link.click
		expect(page.title).to eql("Buy the new iPhone 8 | Contract deals | Three")

	end
end
require 'spec_helper'

describe "Static pages " do
	subject { page }
	describe "Home page" do
		before { visit 'static_pages/home' }

		it { should have_content('Games,books and anime') }
	end
end

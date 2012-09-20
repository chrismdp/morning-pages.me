require 'spec_helper'

feature "View pages" do
  scenario "viewing homepage" do
    visit '/'
    page.should have_content("Morning Pages")
  end
end


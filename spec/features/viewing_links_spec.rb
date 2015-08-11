require "spec_helper"

feature "Viewing links" do
  scenario "I can go to the viewing links page" do
    visit "/"
    click_link "View links"
    expect(current_path).to eq "/links"
  end
  scenario "I can see existing links on the links page" do
    link = Link.new(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    link.save
    visit "/links"
    expect(page.status_code).to eq 200
    within "ul#links" do
      expect(page).to have_content "Makers Academy"
    end
  end
  scenario "I can visit links by clicking the url" do
    visit "/links/new"
    fill_in 'url',  with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Create link'
    click_link 'http://www.zombo.com/'
    expect(current_url).to eq 'http://www.zombo.com/'
  end
end

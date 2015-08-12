require "spec_helper"

feature "Viewing links" do
  scenario "I can go to the viewing links page" do
    visit "/"
    click_link "View links"
    expect(current_path).to eq "/links"
  end

  before(:each) do
    Link.create(url: "http://www.makersacademy.com", title: "Makers Academy", tags: [Tag.first_or_create(name: "education")])
    Link.create(url: "http://www.google.com", title: "Google", tags: [Tag.first_or_create(name: "search")])
    Link.create(url: "http://www.zombo.com", title: "This is Zombocom", tags: [Tag.first_or_create(name: "bubbles")])
    Link.create(url: "http://www.bubble-bobble.com", title: "Bubble Bobble", tags: [Tag.first_or_create(name: "bubbles")])
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
  scenario "I can filter links by a specified tag" do
    visit "/links"
    our_tag = "ruby"
    fill_in "name", with: our_tag
    click_button "Search"
    expect(current_path).to eq "/tags/#{our_tag}"
  end
  scenario 'I can filter links by tag' do
    visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).not_to have_content("Makers Academy")
      expect(page).not_to have_content("Code.org")
      expect(page).to have_content("This is Zombocom")
      expect(page).to have_content("Bubble Bobble")
    end
  end
end

require_relative("../spec_helper")

describe "User sign in" do

	it "shows the users profile page on success" do
		u = User.create!(user_attributes)
		visit root_url
		click_link "Sign In"

		expect(current_path).to eql(signin_path)
		expect(page).to have_text("Email")
		expect(page).to have_text("Password")

		fill_in "Email",    :with => u.email
		fill_in "Password", :with => u.password

		click_button "Sign In"

		expect(current_path).to eql(user_path(u))
		expect(page).to have_text("Welcome back, #{u.name}!")
		expect(page).to have_link("Sign Out")
		expect(page).not_to have_link("Sign In")
		expect(page).not_to have_link("Sign Up")
	end

	it "redirects a bad sign in" do
		u = User.create!(user_attributes)
		visit root_url
		click_link "Sign In"

		expect(current_path).to eql(signin_path)
		expect(page).to have_text("Email")
		expect(page).to have_text("Password")

		fill_in "Email",    :with => u.email
		fill_in "Password", :with => "wrong"

		click_button "Sign In"

		# expect(current_path).to eql(signin_path)
		expect(page).to have_text("Invalid email/password combination!")
	end

	it "shows users name in nav while logged in" do
		u = User.create!(user_attributes)
		visit root_url
		click_link "Sign In"

		fill_in "Email",    :with => u.email
		fill_in "Password", :with => u.password
		click_button "Sign In"

		visit root_url

		expect(page).to have_text("Example User")
		expect(page).to have_link("Sign Out")
		expect(page).not_to have_text("Sign In")
		expect(page).not_to have_text("Sign Up")
	end

	it "gets to Edit User from Account Settings link" do
		u = User.create!(user_attributes)
		visit root_url
		click_link "Sign In"

		fill_in "Email",    :with => u.email
		fill_in "Password", :with => u.password
		click_button "Sign In"

		visit root_url

		click_link "Account Settings"

		expect(current_path).to eql(edit_user_path(u))
	end
end

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

end
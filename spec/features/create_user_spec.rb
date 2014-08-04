require_relative("../spec_helper")

describe "Creating a user" do

	before(:all) do
	end

	it "generates a new user with good input" do
		visit root_url
		click_link "Sign Up"

		expect(current_path).to eql(signup_path)

		fill_in "Name", 						:with => "Test"
		fill_in "Email", 						:with => "test@example.com"
		fill_in "Username", 				:with => "tester"
		fill_in "Password", 				:with => "secret"
		fill_in "Confirm Password", :with => "secret"

		click_on "Create Account"

		expect(current_path).to eql(user_path(User.last))
		expect(page).to have_text("Test")
		expect(page).to have_text("Thanks for signing up!")
	end

	it "does not save the user if invalid" do
		visit signup_url

		expect {
			click_button "Create Account"
		}.not_to change(User, :count)

		expect(page).to have_text("error")
	end

end

require_relative("../spec_helper")

describe "Editing a user" do
	
	before(:all) do
	end

	it "Changes a users name" do
		visit signup_url
		
		fill_in "Name", 						:with => "Test"
		fill_in "Email", 						:with => "test@example.com"
		fill_in "Username",					:with => "tester"
		fill_in "Password", 				:with => "secret"
		fill_in "Confirm Password", :with => "secret"

		click_on "Create Account"

		click_on "Edit Account"

		fill_in "Name", :with => "Test2"

		click_on "Update Account"

		expect(current_path).to eql(user_path(User.last))
		expect(page).to have_text("Test2")
		expect(page).to have_text("Account successfully updated!")
	end

end
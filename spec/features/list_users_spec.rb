require_relative("../spec_helper")

describe "Viewing the list of users" do
	
	before(:all) do
	end

	it "displays all users" do
		u1 = User.create!(:name                  => "Dan",
                  		:email                 => "dan@example.com",
                      :username              => "dadidas07",
                  		:password              => "secret",
                  		:password_confirmation => "secret"
                  		)
		u2 = User.create!(:name                  => "Kelly",
                  		:email                 => "kelly@example.com",
                      :username              => "kelculator87",
                  		:password              => "secret",
                  		:password_confirmation => "secret"
                  		)
		u3 = User.create!(:name                  => "Pepper",
                      :email                 => "pepper@example.com",
                      :username              => "pepperman",
                      :password              => "secret",
                      :password_confirmation => "secret"
                      )

    visit users_url

    expect(page).to have_link(u1.name)
    expect(page).to have_link(u2.name)
    expect(page).to have_link(u3.name)
	end

end
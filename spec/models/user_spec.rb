require_relative("../spec_helper")

describe "A user" do

  before(:all) do
    @test_user = User.new(user_attributes)
  end
  
  context "::new" do
    it "requires a name email and password" do
      expect(@test_user.valid?).to be_true
    end

    it "rejects no name" do
      no_name_user = User.new(:name                  => "",
                              :email                 => "dan@example.com",
                              :username              => "dadidas07",
                              :password              => "secret",
                              :password_confirmation => "secret"
                              )
      expect(no_name_user.valid?).to be_false
    end
    
    it "rejects no email" do
      no_email_user = User.new(:name                  => "Dan",
                               :email                 => "",
                               :username              => "dadidas07",
                               :password              => "secret",
                               :password_confirmation => "secret"
                              )
      expect(no_email_user.valid?).to be_false
    end

    it "rejects duplicate emails" do
      User.create!(user_attributes)
      dup_user = User.new(:name                  => "Mike",
                          :email                 => "user@example.com",
                          :username              => "mikey",
                          :password              => "secret",
                          :password_confirmation => "secret"
                          )
      expect(dup_user.valid?).to be_false
    end
  
    it "rejects no password" do
      no_pass_user = User.new(:name                  => "Dan",
                              :email                 => "user@example.com",
                              :username              => "dadidas07",
                              :password              => "",
                              :password_confirmation => ""
                              )
      expect(no_pass_user.valid?).to be_false
    end

    it "rejects password shorter than 4" do
      sh_pass_user = User.new(:name                  => "Dan",
                              :email                 => "user@example.com",
                              :username              => "dadidas07",
                              :password              => "123",
                              :password_confirmation => "123"
                              )
      expect(sh_pass_user.valid?).to be_false
    end    

    it "rejects missing password confirmation" do
      no_conf_user = User.new(:name                  => "Dan",
                              :email                 => "user@example.com",
                              :username              => "dadidas07",
                              :password              => "secret",
                              :password_confirmation => ""
                              )
      expect(no_conf_user.valid?).to be_false
    end

    it "rejects passwords dont match" do
      bad_pass_user = User.new(:name                  => "Dan",
                               :email                 => "dan@example.com",
                               :username              => "dadidas07",
                               :password              => "secret",
                               :password_confirmation => "mismatch"
                              )
      expect(bad_pass_user.valid?).to be_false
    end

    it "rejects blank username" do
      blank_username_user = User.new(:name                  => "Dan",
                                     :email                 => "user@example.com",
                                     :username              => "",
                                     :password              => "123",
                                     :password_confirmation => "123"
                                    )
      expect(blank_username_user.valid?).to be_false
    end

    it "rejects duplicate username" do
      User.create!(user_attributes)
      u2 = User.new(:name                  => "Dan",
                    :email                 => "dan@example.com",
                    :username              => "examplord",
                    :password              => "secret",
                    :password_confirmation => "secret"
                    )

      expect(u2.valid?).to be_false
    end

    it "encrypts password into digest attribute" do
      expect(@test_user.password_digest).to be_present
    end
  end

  context "#authenticate" do
    before do
      @user = User.create!(user_attributes)
    end

    it "returns not true if the email isn't found" do
      expect(User.authenticate("nomatch", @user.password)).not_to be_true
    end

    it "returns not true if the password isn't found" do
      expect(User.authenticate(@user.email, "nomatch")).not_to be_true
    end

    it "returns user obj if pass and email match" do
      expect(User.authenticate(@user.email, @user.password)).to eql(@user)
    end

    it "returns user obj if username and email match" do
      expect(User.authenticate(@user.username, @user.password)).to eql(@user)
    end
  end

  context "reviews" do
    it "creates and has reviews" do
      user    = User.new(user_attributes)
      movie1  = Movie.new(movie_attributes(:title => "Iron Man"))
      movie2  = Movie.new(movie_attributes(:title => "Superman"))
      
      review1 = movie1.reviews.new(:stars => 5, :comment => "Two thumbs up!")
      review1.user = user
      review1.save!
      review2 = movie1.reviews.new(:stars => 3, :comment => "Cool!")
      review2.user = user
      review2.save!

      expect(user.reviews).to include(review1)
      expect(user.reviews).to include(review2)
    end
  end

  context "favorites" do
    it "has movies that the user is a fan of" do
      movie1 = Movie.new(movie_attributes(:title => "Forest Gump"))
      movie2 = Movie.new(movie_attributes(:title => "Harry Potter"))
      user   = User.new(user_attributes)

      user.favorites.new(:movie => movie1)
      user.favorites.new(:movie => movie2)

      expect(user.favorite_movies).to include(movie1)
      expect(user.favorite_movies).to include(movie2)
    end
  end

  context "all users by name query" do
    it "returns names sorted alphabetically" do
      user1 = User.create!(user_attributes(:name     => "Emilio", 
                                           :email    => "emilio@crossfaderking.com",
                                           :username => "Emilio"))
      user2 = User.create!(user_attributes(:name     => "Matt", 
                                           :email    => "matt@crossfaderking.com",
                                           :username => "Matt"))
      user3 = User.create!(user_attributes(:name     => "Ben", 
                                           :email    => "ben@crossfaderking.com",
                                           :username => "Ben"))

      expect(User.by_name).to eq([user3, user1, user2])      
    end
  end

  context "non-admins only query" do
    it "returns names sorted alphabetically" do
      user1 = User.create!(user_attributes(:name     => "Emilio", 
                                           :email    => "emilio@crossfaderking.com",
                                           :username => "Emilio"))
      user2 = User.create!(user_attributes(:name     => "Matt", 
                                           :email    => "matt@crossfaderking.com",
                                           :username => "Matt"))
      user3 = User.create!(user_attributes(:name     => "Ben", 
                                           :email    => "ben@crossfaderking.com",
                                           :username => "Ben"))
      user4 = User.create!(user_attributes(:name     => "Dan", 
                                           :email    => "dan@crossfaderking.com",
                                           :username => "Dan",
                                           :admin    => true))

      expect(User.no_admins_by_name).to eq([user3, user1, user2])
    end
  end

end

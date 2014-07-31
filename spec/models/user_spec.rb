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
                              :password              => "secret",
                              :password_confirmation => "secret"
                              )
      expect(no_name_user.valid?).to be_false
    end
    
    it "rejects no email" do
      no_email_user = User.new(:name                  => "Dan",
                               :email                 => "",
                               :password              => "secret",
                               :password_confirmation => "secret"
                              )
      expect(no_email_user.valid?).to be_false
    end

    it "rejects duplicate emails" do
      dup_user = User.new(:name                  => "Dan",
                          :email                 => "",
                          :password              => "secret",
                          :password_confirmation => "secret"
                          )
      expect(dup_user.valid?).to be_false
    end
  
    it "rejects no password" do
      no_pass_user = User.new(:name                  => "Dan",
                              :email                 => "user@example.com",
                              :password              => "",
                              :password_confirmation => ""
                              )
      expect(no_pass_user.valid?).to be_false
    end

    it "rejects password shorter than 4" do
      sh_pass_user = User.new(:name                  => "Dan",
                              :email                 => "user@example.com",
                              :password              => "123",
                              :password_confirmation => "123"
                              )
      expect(sh_pass_user.valid?).to be_false
    end    

    it "rejects missing password confirmation" do
      no_conf_user = User.new(:name                  => "Dan",
                              :email                 => "user@example.com",
                              :password              => "secret",
                              :password_confirmation => ""
                              )
      expect(no_conf_user.valid?).to be_false
    end

    it "rejects passwords dont match" do
      bad_pass_user = User.new(:name                  => "Dan",
                               :email                 => "dan@example.com",
                               :password              => "secret",
                               :password_confirmation => "mismatch"
                              )
      expect(bad_pass_user.valid?).to be_false
    end

    it "encrypts password into digest attribute" do
      expect(@test_user.password_digest).to be_present
    end

  end

  context "::update" do
    it "no password required when updating"
  end

end
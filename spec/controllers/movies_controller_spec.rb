require_relative("../spec_helper")

describe MoviesController do

  before do
    @movie = Movie.create!(movie_attributes)
  end

  context "when not signed in as admin" do
  	before do
  		@user        = User.create!(user_attributes)
  		session[:user_id] = @user.id
  	end

    it "cannot access new" do
    	get :new
    	expect(response).to redirect_to(root_url)
    end

    it "cannot access create" do
    	post :create
    	expect(response).to redirect_to(root_url)
    end

    it "cannot access edit" do
    	get :edit, :id => @movie
    	expect(response).to redirect_to(root_url)
    end

    it "cannot access update" do
    	patch :update, :id => @movie
    	expect(response).to redirect_to(root_url)
    end

    it "cannot access delete" do
    	delete :destroy, :id => @movie
    	expect(response).to redirect_to(root_url)
    end
  end

end
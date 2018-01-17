describe "App" do

  describe "GET '/'" do
    it 'returns a 200 status code' do
      get '/'
      expect(last_response.status).to eq(200)
    end

    it 'returns contains a login and signup links' do
      get '/'
      expect(last_response.body).to include('Please <a href="/signup">Sign Up</a> or <a href="/login">Log In</a> to continue')
    end
  end

  describe "GET '/signup'" do
    it 'returns a 200 status code' do
      get '/signup'
      expect(last_response.status).to eq(200)
    end

    it 'returns contains a form to login' do
      visit '/signup'
      expect(page).to have_selector("form")
      expect(page).to have_field(:username)
      expect(page).to have_field(:password)
    end
  end

  describe "GET '/login'" do
    it 'returns a 200 status code' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'loads a form to login' do
      visit '/login'
      expect(page).to have_selector("form")
      expect(page).to have_field(:username)
      expect(page).to have_field(:password)
    end
  end




  describe "GET '/failure'" do
    it 'displays failure message' do
      visit '/failure'

      expect(page.body).to include("Houston, We Have a Problem")
    end
  end

end

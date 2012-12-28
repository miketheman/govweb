helpers do
  def username
    session[:identity] ? session[:identity] : 'Unknown user'
  end
end

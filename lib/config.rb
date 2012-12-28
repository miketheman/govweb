configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
end

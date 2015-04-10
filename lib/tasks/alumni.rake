namespace :data do
  desc "Output all the User Data"
  task :output do
    @user = User.all

  end
end

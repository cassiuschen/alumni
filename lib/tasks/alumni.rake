namespace :data do
  desc "Output all the User Data"
  task :output => :environment do
    @users = User.all
    puts "Found #{@users.size} Users"
    @file = File.open "user_data_#{Time.now.year}#{Time.now.month.to_s.rjust(2,'0')}#{Time.now.day.to_s.rjust(2,'0')}.txt", "w"
    @content = ""
    @users.each do |user|
      @content += "#{user.BdfzerId.rjust(12,' ')} #{user.name.rjust(4,' ')} #{user.graduate_at.rjust(4,' ')} #{user.profile.sexual.rjust(7,' ')} #{user.profile.default_contact.rjust(6,' ')} #{user.profile.phone.rjust(13,' ')} #{user.profile.email.rjust(18,' ')} #{user.profile.wechat.rjust(20,' ') || '-'.rjust(20,' ')} #{user.profile.qq.rjust(12,' ') || '-'.rjust(12,' ')} #{user.profile.study_at.rjust(20,' ') || '-'.rjust(4,' ')} #{user.profile.major.rjust(20,' ') || '-'.rjust(4,' ')} \n"
    end
    puts @content
    @file.write @content
  end
end

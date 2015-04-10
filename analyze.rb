class String
  def to_time
    locale = {
      "Jan" => 1,
      "Feb" => 2,
      "Mar" => 3,
      "April" => 4,
      "May" => 5,
      "Jun" => 6,
      "July" => 7,
      "Aug" => 8,
      "Sep" => 9,
      "Oct" => 10,
      "Nov" => 11,
      "Dec" => 12
    }
    str = self.gsub('[','').gsub(']','').gsub(':','/').split '/'
    Time.new str[2].to_i, locale[str[1]], str[0].to_i, str[3].to_i, str[4].to_i, str[5].to_i
  end

  def to_maxLength(length, code = ' ')
    ''.rjust((length - self.length - 2) / 2, code) + " #{self} " + ''.rjust((length - self.length - 2) / 2, code)
  end
end

class LogInfo
  attr_accessor :ip, :time, :method, :location,
                :status, :est, :user_agent

  @@logs = []
  @@humans = []
  @@tips = 0
  @@totalLength = 0
  @@maxLength = {}

  def initialize(line)
    @@tips += 1
    @info = line.split ' '
    @ip = @info[0]
    @time = @info[3].to_time
    @method = @info[5].gsub '"', ''
    @location = @info[6]
    @status = @info[8]
    @est = @info[9]
    @user_agent = (@info - @info[0...11]).join(" ").gsub '"', ''

    unless @user_agent.match(/bot/) || @user_agent.match(/DNS/) || @user_agent.match(/spider/) || @location.match(/bbs/)
      @@humans << self
    end
    @@logs << self
  end

  class << self
    def all
      @@logs
    end

    def visitors
      self.all.map{|log| log.ip}.uniq
    end

    def get_max_length
      @@maxLength[:method] = @@humans.map{|i| i.method.length}.max
      @@maxLength[:location] = @@humans.map{|i| i.location.length}.max
      @@maxLength[:user_agent] = @@humans.map{|i| i.user_agent.length}.max
      @@totalLength = @@maxLength[:method] + @@maxLength[:location] + @@maxLength[:user_agent] + 18 + 9
    end

    def details
      puts "Details".to_maxLength @@totalLength, '='
      puts 'IP Address'.rjust(18,' ') + ' | ' + 'Action'.to_maxLength(@@maxLength[:method] + @@maxLength[:location] + 3, ' ') + ' | ' + "User Agent".to_maxLength(@@maxLength[:user_agent])
      @@humans.sort_by {|l| l.ip.gsub('.','').to_i}.each do |v|
        puts v.ip.rjust(18, ' ') + ' | ' + v.method.upcase.rjust(@@maxLength[:method], ' ') + '   ' + v.location.rjust(@@maxLength[:location], ' ') + " | " + v.user_agent.rjust(@@maxLength[:user_agent], ' ')
      end
      puts "".rjust @@totalLength, '-'
    end 

    def analyze
      LogInfo.get_max_length
      puts "Nginx Access Log Analyzer".to_maxLength @@totalLength, '='
      puts "Cassius Chen | 0.1.1".to_maxLength @@totalLength
      puts ''
      puts self.visitors
      #self.details
      puts "".rjust @@totalLength, '-'
    end
  end
end

$file = IO.readlines './log/nginx.access.log'
$file.each do |line|
  LogInfo.new line
end

LogInfo.analyze
#puts LogInfo.all.map{|l| l.user_agent}.


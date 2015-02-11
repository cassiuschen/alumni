def visitor
  puts '========= Visitors ============'
  puts `cat log/nginx.access.log | grep "bdfzer" | awk '{print $1}' | sort | uniq -c `
  puts '-------------------------------'
end

class LogInfo
  def initialize(lines)
    

@log = File.read
visitor

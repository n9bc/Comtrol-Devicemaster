require 'net/http'
require 'optparse' 

# Brent Crier
# I wrote this to avoid using the web gui which is extremely slow to quickly set new networking settings.


#Form Options 
ip_addr = "10.20.0."
ip_gw = "10.20.1.250"
ip_netmask = "255.255.254.0"
rxpoll = "10"
v6_prefix_lenght = "0"
tcpkeep = "60"
boottimeout = "15"
telnettimeout = "300"

options = {}

OptionParser.new do |opts|

  opts.banner = "Usage: cc.rb [options]"
  opts.separator " Options:"
  opts.on("-n", "--number IP Address", "The IP of the site.") do |v|
    options[:number] = v
  puts "\n -.-. .-. .. . .-.   -.-. --- -- - .-. --- .-..\n "
  end

end.parse!

url = URI.parse("http://192.168.250.250/goforms/network_form")

puts "Writing config  with IP Address #{ip_addr}#{ options[:number]}" if options[:number]

Net::HTTP.start(url.host) do |http| 
  req = Net::HTTP::Post.new(url.path)
  req.set_form_data({ 'RxPollingTime' => "#{rxpoll}", 'IPv4_Address' => "#{ip_addr}#{ options[:number]}", 'IPv4_Subnet_Mask' => "#{ip_netmask}", 'IPv4_Default_Gateway' => "#{ip_gw}", 'IPv6_Prefix_Length' => "#{v6_prefix_lenght}", 'TcpKeepalive' => "#{tcpkeep}", 'BootTimeout' => "#{boottimeout}", 'TelnetTimeout' => "#{telnettimeout}", 'submit' => 'SUBMIT' })
puts http.request(req).body
end

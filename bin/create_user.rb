
file = ARGV[0]
emails = File.open(file, 'r').readlines.map(&:chomp)

emails.each do |mail|
  puts "work on #{mail}"
  `appsdeck run rake simplon:create_remote email=#{mail}`
end



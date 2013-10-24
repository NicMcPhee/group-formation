require 'set'

file = File.new("past_groups.txt")
past_pairs = file.readlines.delete_if { |line| /^#/.match(line) }.map do |line|
  line.split(" ")
end

name_set = Set.new
count = Hash.new(0)
past_pairs.each do |a, b, lab|
  name_set.add(a)
  name_set.add(b)
  pair = [a, b].sort
  count[pair] += 1
end
names = name_set.to_a.sort

print "\t"
names.each do |name|
  print name
  print " "
end
puts
names.each do |a|
  print a
  print " "
  names.each do |b|
    print count[[a, b].sort]
    print " "
  end
  puts
end
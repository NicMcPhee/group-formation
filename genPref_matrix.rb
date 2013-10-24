require 'set'

def preference_score(a, b)
  if either_avoids(a, b)
    return 10
  elsif both_prefer(a, b)
    return 1
  elsif either_prefers(a, b)
    return 2
  else
    return 4
  end
end

def either_avoids(a, b)
  return (@avoids[a].member?(b) or @avoids[b].member?(a))
end

def both_prefer(a, b)
  return (@prefers[a].member?(b) and @prefers[b].member?(a))
end

def either_prefers(a, b)
  return (@prefers[a].member?(b) or @prefers[b].member?(a))
end

# I totally need to change this so that we generate the list of names instead
# of having it heard coded here.
names = %w{ Chris Pat Sandy }

file = File.new("prefs.txt")
pref_lines = file.readlines.delete_if { |line| /^#/.match(line) }.map do |line|
  line.split(" ")
end

@prefers = Hash.new([])
@avoids = Hash.new([])
pref_lines.each do |line|
  subject, type = line
  objects = line[2..-1]
  if type == "prefers"
    @prefers[subject] = objects
  else
    @avoids[subject] = objects
  end
end

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
    print preference_score(a, b)
    print " "
  end
  puts
end

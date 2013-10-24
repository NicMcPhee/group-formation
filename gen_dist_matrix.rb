require 'set'

def preference_score(a, b)
  if either_avoids(a, b)
    return 15
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

def combine_scores(history, preferences)
  # The 3*history + preference is pretty arbitrary, but has worked well in
  # practice.
  return 3*history + preferences
end

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
  print "\t"
end
puts
names.each do |a|
  print a
  print "\t"
  names.each do |b|
    print combine_scores(count[[a, b].sort], preference_score(a, b))
    print "\t"
  end
  puts
end

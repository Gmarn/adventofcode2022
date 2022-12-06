file = File.read('./input.txt')
signal = file.chomp

def are_chars_different?(str)
  str.chars.uniq.length == str.size
end

# soms = start-of-message size
def look_into_signal(signal, soms)
  (0..signal.size - soms).each do |idx|
    next unless are_chars_different?(signal.slice(idx..idx + soms - 1))

    return idx + soms
  end
end

result_1 = look_into_signal(signal, 4)
result_2 = look_into_signal(signal, 14)

print 'Result ', result_1, "\n"
print 'Result ', result_2, "\n"

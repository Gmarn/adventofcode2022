file = File.read('./input.txt')
array = file.split("\n")

def move_pointer(command, pointer)
  return pointer unless command.first == 'cd'

  case command[1]
  when '/'
    pointer = []
  when '..'
    pointer.pop
  else
    pointer << command[1]
  end

  pointer
end

def aggregate_data(cmd_output, pointer)
  case cmd_output.first
  when 'dir'
    if pointer.empty?
      @files[cmd_output[1]] = { size: 0 } unless @files[cmd_output[1]]
    else
      @files.dig(*pointer)[cmd_output[1]] = { size: 0 } unless @files.dig(*pointer)[cmd_output[1]]
    end
  else
    return if pointer.empty? # @files[:size] += cmd_output.first.to_i
    (1..pointer.length).each.with_index do |i|
      @files.dig(*pointer[0..-1 * i])[:size] += cmd_output.first.to_i
    end
  end
end

def traversing_files(parent, files)
  files.each do |key, value|
    if value.is_a?(Hash)
      traversing_files(key, value)
    else
      @result += value if value <= 100_000
    end
  end
end

@files = { size: 0 }
@result = 0

array.each_with_object([]) do |line, pointer|
  cmd_line = line.split(' ')

  if cmd_line.first == '$'
    pointer = move_pointer(cmd_line[1..-1], pointer)
    print 'pointer ', pointer, "\n"
  else
    aggregate_data(cmd_line, pointer)
  end
end

traversing_files(nil, @files)


puts @files
print 'Result ', @result, "\n"

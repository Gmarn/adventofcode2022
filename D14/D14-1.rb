file = File.read('./input.txt')
array = file.split("\n")

grid_width, @grid_height = 150, 190
@offest_width = 400
@grid = Array.new(@grid_height, []).map { |row| row = Array.new(grid_width, '.').dup }
@grid[0][500 - @offest_width] = '+'

def add_rock(x_s, y_s, x_e, y_e)
  x_min, x_max = [x_s, x_e].min, [x_s, x_e].max
  y_min, y_max = [y_s, y_e].min, [y_s, y_e].max
  if x_max == x_min
    (y_min..y_max).each { |y| @grid[y][x_min - @offest_width] = '#' }
  elsif y_max == y_min
    (x_min..x_max).each { |x| @grid[y_min][x - @offest_width] = '#' }
  else
    raise StandardError
  end
end

def build_grid(lines)
  lines.each do |line|
    segments = line.split(' -> ').map { |point| point.split(',').map(&:to_i) }
    segments[1..-1].each_with_index do |segment, idx|
      add_rock(segments[idx][0], segments[idx][1], segment[0], segment[1])
    end
  end
end

def one_step_falling(x_n, y_n)
  return 'Out' if y_n + 1 == @grid_height
  return [x_n, y_n + 1] if @grid[y_n + 1][x_n] == '.'
  return [x_n - 1, y_n + 1] if @grid[y_n + 1][x_n - 1] == '.'
  return [x_n + 1, y_n + 1] if @grid[y_n + 1][x_n + 1] == '.'
  'Stuck'
end

def a_grain_falling(x_n, y_n)
  result = one_step_falling(x_n, y_n)
  return result if result == 'Out'
  return @grid[y_n][x_n] = 'º' if result == 'Stuck'
  a_grain_falling(result[0], result[1])
end


build_grid(array)
falling_out = nil
grain = 0
while falling_out != 'Out'
  grain += 1
  falling_out = a_grain_falling(500 - @offest_width, 0)
  puts grain if grain % 1000 == 0
end

puts @grid.map { |e| e.join }

print 'Result ', grain - 1, "\n"

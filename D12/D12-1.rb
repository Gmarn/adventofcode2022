file = File.read('./input-k-to-m.txt')
@grid = file.split("\n").map { |row| row.chars }

def where_can_i_go(x, y, path)
  # puts 'Y: ' + y.to_s + " H: " + @height.to_s
  down  = [x, y+1, @grid[y+1][x]] if y < @height - 1
  up    = [x, y-1, @grid[y-1][x]] if y != 0 # y > 19
  left  = [x+1, y, @grid[y][x+1]] if x < @width - 1
  right = [x-1, y, @grid[y][x-1]] if x != 0

  pos = @grid[y][x]

  [down, up, left, right].each_with_object([]) do |point, possibilities|
    next unless point
    # print pos, ' elevation ', point[2], ' bool ', point[2] <= pos + 1, "\n"
    next unless point[2] == pos + 1 || point[2] == pos
    coord = point[0..1].join(',')
    # return 'Arrived' if coord == @end
    # print 'Path ', path, ' Coord: ', coord, "\n"
    possibilities << point[0..1].join(',') unless path.include?(coord)
  end
end

def change_letter_to_int
  reference = ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

  @grid.each_with_index do |row, y|
    row.each_with_index do |z, x|
      if z == 'S'
        @grid[y][x] = 11# 1
        @start = [x, y].join(',')
        next
      end
      if z == 'E'
        @grid[y][x] = 14 # 26
        @end = [x, y].join(',')
        next
      end
      @grid[y][x] = reference.rindex(z).to_i
    end
  end
end

@ite = 0
@min_path = nil
def traversing_grid(pos, path)
  x, y = pos.split(',').map(&:to_i)
  possibilities = where_can_i_go(x, y, path)

  return if possibilities.empty?
  @ite += 1
  puts "Iteration: " + @ite.to_s if @ite % 10000 == 0

  possibilities.each do |possibility|
    if possibility == @end
      @paths << path + [pos]
      @min_path = @paths.map(&:length).min
      return
    end
    return if @min_path && path.length >= @min_path
    return if @ite > 10000000
    traversing_grid(possibility, path + [pos])
  end
end

@height = @grid.length
@width = @grid.first.length
@start, @end = '', ''
@paths = []

test = @grid[13][60]
change_letter_to_int
# @end = '60,13' # with the first a to d 329 e to k 105 k to m
traversing_grid(@start, [])

# print @grid, "\n"
print @start, ' to ', @end, "\n"
# print where_can_i_go(2, 0, path + ['1,0'])

print 'Result ', @paths.map(&:length), "\n"
print 'Result ', @paths.map(&:length).min, "\n"
# print 'Result ', @paths, "\n"
# @paths.each { |p| print p, "\n" if p.length == 25 }
# print @grid.each { |r| r.join(',') }
# puts @grid.map { |e| e.join(',') }

file = File.read('./input.txt')
array = file.split("\n")

class Grid
  attr_reader :height, :width, :sensors
  attr :canvas

  def initialize(sensors)
    @sensors = sensors
    @width = find_width
    @height = find_height
  end

  def set_up_line(y_n, x_n_max)
    print 'Line: ', y_n, "\n"
    line = Array.new(x_n_max + 1, '.')
    left_extra_max, right_extra_max = 0, 0

    sensors.each do |sensor|
      line[ sensor[:position][0] ] = 'S' if sensor[:position][1] == y_n && sensor[:position][0] < x_n_max + 1 && sensor[:position][0].positive?
      line[ sensor[:beacon][0] ] = 'B' if sensor[:beacon][1] == y_n && sensor[:beacon][0] < x_n_max + 1 && sensor[:beacon][0].positive?

      cab_distance = (sensor[:position][0] - sensor[:beacon][0]).abs +
                     (sensor[:position][1] - sensor[:beacon][1]).abs

      line.each_with_index do |point, x_n|
        cab_distance_2 = (sensor[:position][0] - x_n).abs +
                         (sensor[:position][1] - y_n).abs
        next unless cab_distance >= cab_distance_2
        line[ x_n ] = '#' if line[ x_n ] == '.'
      end
    end

    line
  end

  def set_up_canvas
    init_canvas = Array.new(height[:length] + 1, []).map { |row| row = Array.new(width[:length] + 1, '.').dup }

    sensors.each do |sensor|
      init_canvas[ sensor[:position][1] - height[:min]][ sensor[:position][0] - width[:min]] = 'S'
      init_canvas[ sensor[:beacon][1] - height[:min]][ sensor[:beacon][0] - width[:min]] = 'B'
    end

    init_canvas
  end

  def find_width
    return if @width

    xs = sensors.map { |elt| [elt[:position][0], elt[:beacon][0]] }.flatten
    x_max, x_min = xs.max, xs.min

    { min: x_min, max: x_max, length: x_max - x_min }
  end

  def find_height
    return if @height

    ys = sensors.map { |elt| [elt[:position][1], elt[:beacon][1]] }.flatten
    y_max, y_min = ys.max, ys.min

    { min: y_min, max: y_max, length: y_max - y_min }
  end
end

sensors = array.each_with_object([]) do |sensor, acc|
  position, beacon = sensor.split(': closest beacon is at ').map { |e| e.split('=') }
  acc << {
    position: [position[1].gsub(', y', '').to_i, position[2].to_i],
    beacon: [beacon[1].gsub(', y', '').to_i, beacon[2].to_i]
  }
end

grid = Grid.new(sensors)

print 'width ', grid.width, "\n"
print 'height ', grid.height, "\n"

# (0..20).each { |i| print grid.set_up_line(i, 20)[:line].join, ' Line ', i, "\n" }

(0..3).each do |i|
  print grid.set_up_line(i, 4_000_000).include?('.'), "\n"
end

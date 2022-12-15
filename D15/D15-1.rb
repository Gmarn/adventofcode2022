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

  def set_up_line(y_n)
    line = Array.new(width[:length] + 1, '.')
    y_in_line = y_n - height[:min]
    left_extra_max, right_extra_max = 0, 0

    sensors.each do |sensor|
      print 'Sensor: ', sensor, "\n"
      line[ sensor[:position][0] - width[:min] ] = 'S' if sensor[:position][1] == y_n # sensor[:position][1] - height[:min] == y_in_line
      line[ sensor[:beacon][0] - width[:min] ] = 'B' if sensor[:beacon][1] == y_n

      cab_distance = (sensor[:position][0] - sensor[:beacon][0]).abs +
                     (sensor[:position][1] - sensor[:beacon][1]).abs

      line.each_with_index do |point, idx|
        x_n = idx + width[:min]
        cab_distance_2 = (sensor[:position][0] - x_n).abs +
                         (sensor[:position][1] - y_n).abs
        next unless cab_distance >= cab_distance_2
        line[ idx ] = '#' if line[ idx ] == '.'
      end

      cab_distsance_left = (sensor[:position][0] - width[:min]).abs +
                           (sensor[:position][1] - y_n).abs
      cab_distsance_right = (sensor[:position][0] - width[:max]).abs +
                            (sensor[:position][1] - y_n).abs

      right_extra = cab_distance - cab_distsance_right
      left_extra = cab_distance - cab_distsance_left

      print 'Cab distance S to B: ', cab_distance, "\n"
      print "Right: ", right_extra, "\n"
      print "Left: ", left_extra, "\n"
      right_extra_max = right_extra if right_extra.positive? && right_extra > right_extra_max
      left_extra_max = left_extra if left_extra.positive? && left_extra > left_extra_max
    end

    { line: line, left_extra: left_extra_max, right_extra: right_extra_max }
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

# puts grid.set_up_canvas.map { |e| e.join }
print 'width ', grid.width, "\n"
print 'height ', grid.height, "\n"

# print 'Line 09 ', grid.set_up_line(9)[:line].join, "\n"
# print 'Line 10 ', grid.set_up_line(10)[:line].join, "\n"
# print 'Line 12 ', grid.set_up_line(12)[:line].join, "\n"

result = grid.set_up_line(2_000_000)
# result = grid.set_up_line(10)
# print 'Line 10 ', result[:line].join, "\n"

print 'Result: ', result[:line].select { |pt| pt == '#' }.size + result[:right_extra] + result[:left_extra], "\n"

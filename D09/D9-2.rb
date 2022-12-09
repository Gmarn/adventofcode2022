file = File.read('./input.txt')
array = file.split("\n")

def move_head(x_h, y_h, dir)
  case dir
  when 'R'
    [x_h + 1, y_h]
  when 'L'
    [x_h - 1, y_h]
  when 'U'
    [x_h, y_h + 1]
  when 'D'
    [x_h, y_h - 1]
  end
end

def move_tail(x_t, y_t, x_h, y_h)
  return [x_t, y_t] if (x_t - x_h).abs() <= 1 && (y_t - y_h).abs() <= 1
  if (x_h - x_t).abs == 2
    x_t += 1 * ((x_h - x_t).abs) / (x_h - x_t)
    y_t += 1 * ((y_h - y_t).abs) / (y_h - y_t) if (y_t - y_h) != 0
  end

  if (y_h - y_t).abs == 2
    y_t += 1 * ((y_h - y_t).abs) / (y_h - y_t)
    x_t += 1 * ((x_h - x_t).abs) / (x_h - x_t) if (x_t - x_h) != 0
  end

  [x_t, y_t]
end

def move_rope(rope, dir)
  x_h, y_h = move_head(rope[0][0], rope[0][1], dir)
  new_rope = [[x_h, y_h]]

  rope[1..-1].each_with_index do |t_i, idx|
    new_rope << move_tail(rope[idx+1][0], rope[idx+1][1], new_rope[idx][0], new_rope[idx][1])
  end
  new_rope
end

rope = Array.new(10, [250, 250])

result = []
array.each do |move|
  dir, times = move.split(' ')
  (1..times.to_i).each do
    rope = move_rope(rope, dir)
    result << [rope[9][0].to_s, rope[9][1].to_s].join
  end
end

print 'Result ', result.uniq.length, "\n"

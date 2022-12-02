file = File.read('./input.txt')
array = file.split("\n")

shape_points = { X: 1, Y: 2, Z: 3 }
result_points = { victory: 6, draw: 3, loss: 0 }

def play_a_match(opponent, me)
  case opponent
  when 'A'
    case me
    when 'X'
      :draw
    when 'Y'
      :victory
    when 'Z'
      :loss
    end
  when 'B'
    case me
    when 'X'
      :loss
    when 'Y'
      :draw
    when 'Z'
      :victory
    end
  when 'C'
    case me
    when 'X'
      :victory
    when 'Y'
      :loss
    when 'Z'
      :draw
    end
  end
end

score = 0
array.each do |match|
  opponent, me = match.split(' ')
  score += shape_points[me.to_sym] + result_points[play_a_match(opponent, me)]
end

print 'Final score: ', score

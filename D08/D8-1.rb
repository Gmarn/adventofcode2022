file = File.read('./input.txt')
array = file.split("\n").map { |e| e.chars.map(&:to_i) }

@tree_map = array
width = array.first.length
height = array.length

def tree_visible?(tree, row_pos, colum_pos)
  left_trees = @tree_map[row_pos][0..colum_pos-1].max
  right_trees = @tree_map[row_pos][colum_pos+1..-1].max
  top_trees = @tree_map[0..row_pos-1].map { |row| row[colum_pos] }.max
  bottom_trees = @tree_map[row_pos+1..-1].map { |row| row[colum_pos] }.max

  return true if tree > left_trees || tree > right_trees || tree > top_trees || tree > bottom_trees
  false
end

result = 0
array.each_with_index do |row, i|
  row.each_with_index do |tree, j|
    next unless i == 0 || i + 1 == height || j == 0 || j + 1 == width || tree_visible?(tree, i, j)

    result += 1
  end
end

print 'Result ', result, "\n"

file = File.read('./input.txt')
array = file.split("\n").map { |e| e.chars.map(&:to_i) }

def trees_in_view(tree, trees_alginment)
  score = 0
  previous_tree = -1
  trees_alginment.each do |t|
    score += 1
    next if previous_tree >= t
    return score if t >=  tree
    previous_tree = t
  end
  score
end

def scenic_score(tree, row_pos, colum_pos)
  left_trees = @tree_map[row_pos][0..colum_pos-1].reverse
  right_trees = @tree_map[row_pos][colum_pos+1..-1]
  top_trees = @tree_map[0..row_pos-1].map { |row| row[colum_pos] }.reverse
  bottom_trees = @tree_map[row_pos+1..-1].map { |row| row[colum_pos] }

  left_tree_view = trees_in_view(tree, left_trees)
  right_tree_view = trees_in_view(tree, right_trees)
  top_tree_view = trees_in_view(tree, top_trees)
  bottom_tree_view = trees_in_view(tree, bottom_trees)

  # print 'L, R, T, B - ', row_pos, ', ', colum_pos, ': ', [left_tree_view, right_tree_view, top_tree_view, bottom_tree_view], "\n"
  left_tree_view * right_tree_view * top_tree_view * bottom_tree_view
end

@tree_map = array
result = 0
width = array.first.length
height = array.length

array.each_with_index do |row, i|
  row.each_with_index do |tree, j|
    next if i == 0 || i + 1 == height || j == 0 || j + 1 == width

    score = scenic_score(tree, i, j)
    result = score if result < score
  end
end

print 'Result ', result, "\n"


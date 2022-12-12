file = File.read('./input.txt')
array = file.split("\n\n").map { |p| p.split("\n") }

class Monkey
  attr :items, :business
  attr_reader :id, :operation, :test

  def initialize(id, items, operation, test)
    @id = id
    @items = prep_item(items)
    @operation = operation
    @test = test
    @business = 0
  end

  def prep_item(int_list)
    # dividers = [23, 19, 13, 17]
    dividers = [7, 13, 5, 19, 2, 11, 17, 3]
    int_list.map do |int|
      [[dividers[0], int % dividers[0]],
       [dividers[1], int % dividers[1]],
       [dividers[2], int % dividers[2]],
       [dividers[3], int % dividers[3]],
       [dividers[4], int % dividers[4]],
       [dividers[5], int % dividers[5]],
       [dividers[6], int % dividers[6]],
       [dividers[7], int % dividers[7]]
      ]
    end
  end

  def inspection(old)
  end

  def inspection(old)
    @business += 1

    inspection_result = old.each_with_object([]) do |item, acc|
      value1, operator, value2 = operation.split(' ')
      value1 = item[1] if value1.to_s.match?('old')
      value2 = item[1] if value2.to_s.match?('old')

      acc << [item[0], value1.to_i.method(operator).(value2.to_i) % item[0]]
    end

    return inspection_result # / 3
  end

  def remove_item_to_throw
    items.delete_at(0)
  end

  def throw(old)
    inspection_value = inspection(old)

    testing = inspection_value.select { |divider, reste| divider == test[:divider] && reste == 0 }.any?
    monkey_recipient = testing ? test[:to_true] : test[:to_false]

    [monkey_recipient, inspection_value]
  end

  def receive(item)
    items << item
  end
end


def run_a_round(monkeys)
  monkeys.each do |monkey|
    items_to_throw = monkey.items.size
    items_to_throw.times do
      item = monkey.remove_item_to_throw
      monkey_id, new_item = monkey.throw(item)

      monkeys[monkey_id.to_i].receive(new_item)
    end
  end
end

monkeys = array.each_with_object([]) do |monkey, acc|
  id = monkey[0].scan(/[0-9]/).join
  items = monkey[1].split(': ')[1].split(', ').map(&:to_i)
  operation = monkey[2].split('= ')[1]
  test = {
    divider: monkey[3].scan(/[0-9]/).join.to_i,
    to_true: monkey[4].scan(/[0-9]/).join,
    to_false: monkey[5].scan(/[0-9]/).join
  }

  acc << Monkey.new(id, items, operation, test)
end

10000.times.with_index do |idx|
  puts 'Next round ' + idx.to_s
  run_a_round(monkeys)
end

print 'Business logic', nil, "\n"
business_print = monkeys.map { |m| "Monkey " + m.id.to_s + ' inspected items ' + m.business.to_s + ' items.' }
puts business_print
business_monkey = monkeys.map { |m| [m.id, m.business] }.max(2) { |m, n| m[1] <=> n[1] }

print 'Result ', business_monkey[0][1] * business_monkey[1][1], "\n"


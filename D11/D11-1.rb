file = File.read('./input.txt')
array = file.split("\n\n").map { |p| p.split("\n") }

class Monkey
  attr :items, :business
  attr_reader :id, :operation, :test

  def initialize(id, items, operation, test)
    @id = id
    @items = items
    @operation = operation
    @test = test
    @business = 0
  end

  def inspection(old)
    @business += 1
    value1, operator, value2 = operation.split(' ')
    value1 = old if value1.to_s.match?('old')
    value2 = old if value2.to_s.match?('old')

    inspection_result = value1.to_i.method(operator).(value2.to_i)

    return inspection_result / 3
  end

  def throw(old)
    items.delete_if { |i| i == old }
    inspection_value = inspection(old)

    monkey_recipient = inspection_value % test[:divider] == 0 ? test[:to_true] : test[:to_false]

    [monkey_recipient, inspection_value]
  end

  def receive(item)
    items << item
  end
end


def run_a_round(monkeys)
  monkeys.each do |monkey|
    items_to_throw = monkey.items.dup
    items_to_throw.each do |item|
      monkey_id, new_item = monkey.throw(item)

      monkeys[monkey_id.to_i].receive(new_item)
      # print 'Monkeys ', monkey.id, ' throws item ', item, ' to monkey ', monkey.throw(item), "\n"
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

round = 0
20.times { run_a_round(monkeys) }

print 'Business logic', nil, "\n"
business_print = monkeys.map { |m| "Monkey " + m.id.to_s + ' inspected items ' + m.business.to_s + ' items.' }
puts business_print
business_monkey = monkeys.map { |m| [m.id, m.business] }.max(2) { |m, n| m[1] <=> n[1] }

print 'Result ', business_monkey[0][1] * business_monkey[1][1], "\n"


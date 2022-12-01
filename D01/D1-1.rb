file = File.read('./input.txt')
array = file.split("\n")

elf_number = 1
@max_stuffed_elf = :elf_1
@second_stuffed_elf = :elf_1
@third_stuffed_elf = :elf_1

def check_max_stuffed_elf(acc, elf_number)
  if acc["elf_#{elf_number}".to_sym] > acc[@max_stuffed_elf]
    @third_stuffed_elf = @second_stuffed_elf.dup
    @second_stuffed_elf = @max_stuffed_elf.dup
    @max_stuffed_elf = "elf_#{elf_number}".to_sym
    return
  end

  if acc["elf_#{elf_number}".to_sym] > acc[@second_stuffed_elf]
    @third_stuffed_elf = @second_stuffed_elf.dup
    @second_stuffed_elf = "elf_#{elf_number}".to_sym
    return
  end

  if acc["elf_#{elf_number}".to_sym] > acc[@third_stuffed_elf]
    @third_stuffed_elf = "elf_#{elf_number}".to_sym
    return
  end
end

max_calories_by_elves = array.each_with_object({ elf_1: 0 }) do |calories, acc|
  if calories == ''
    check_max_stuffed_elf(acc, elf_number)

    elf_number += 1
    acc["elf_#{elf_number}".to_sym] = 0
  else
    acc["elf_#{elf_number}".to_sym] += calories.to_i
  end
end

check_max_stuffed_elf(max_calories_by_elves, elf_number)


puts max_calories_by_elves
print 'Max stuffed elf ', @max_stuffed_elf, ' ', max_calories_by_elves[@max_stuffed_elf], "\n"
print '2nd stuffed elf ', @second_stuffed_elf, ' ', max_calories_by_elves[@second_stuffed_elf], "\n"
print '3rd stuffed elf ', @third_stuffed_elf, ' ', max_calories_by_elves[@third_stuffed_elf], "\n"

print 'Total ', max_calories_by_elves[@max_stuffed_elf] + max_calories_by_elves[@second_stuffed_elf] + max_calories_by_elves[@third_stuffed_elf]

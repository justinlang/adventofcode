# https://adventofcode.com/2021/day/3

def part1
  raw = File.read("/Users/justinlang/scratch/adventofcode/2021/day_3/input.txt")

  rows = raw.split("\n").each { |val| val.to_c }

  columns = []
  (0..rows[0].size - 1).each do |i|
    columns[i] = []
    rows.each { |row| columns[i] << row[i] }
    columns[i].sort!
  end

  gamma = columns.flat_map do |column|
    column[(column.size - 1) / 2]
  end.join("").to_i(2)

  epsilon = gamma ^ (0..rows[0].size - 1).map { |i| "1" }.join("").to_i(2)

  puts "power=#{gamma * epsilon}"
end

def part2
  raw = File.read("/Users/justinlang/scratch/adventofcode/2021/day_3/input.txt")

  rows = raw.split("\n").each { |val| val.to_c }

  oxy = find_rating(rows, :>, "1")
  co2 = find_rating(rows, :<, "0")

  puts "life support=#{oxy * co2}"
end

def find_rating(rows, comparator, default_bit)
  filtered_rows = rows
  (0..rows[0].size - 1).each do |i|
    column = filtered_rows.map { |row| row[i] }
    bit = select_bit(column, comparator, default_bit)
    filtered_rows = filtered_rows.select { |row| row[i] == bit }
    break if filtered_rows.size <= 1
  end
  filtered_rows.first.to_i(2)
end

def select_bit(column, comparator, default)
  groups = column.partition { |i| i == "0" }
  return default if groups[0].size == groups[1].size
  return groups[0].size.send(comparator, groups[1].size) ? "0" : "1"
end
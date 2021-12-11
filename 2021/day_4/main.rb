# https://adventofcode.com/2021/day/4

class Board
  def initialize(grid)
    @grid = grid
  end

  def try_mark_number(number)
    @grid.each_with_index do |row, i|
      next unless j = row.find_index(number)
      @grid[i][j] = "x"
      return true
    end
    return false
  end

  def winning_board?
    @grid.find { |row| winning_line?(row) } || @grid.transpose.find { |col| winning_line?(col) }
  end

  def winning_line?(line)
    line.first == "x" && line.uniq.size == 1
  end

  def unmarked_sum
    @grid.flatten.reject { |i| i == "x" }.sum
  end
end

def parse_input(input, row_count)
  input = input.split("\n").compact.reject(&:empty?)
  called_numbers = input.shift.split(",").map(&:to_i)
  boards = input.each_slice(row_count).map do |rows|
    Board.new(rows.map { |row| row.split(" ").map(&:to_i) } )
  end
  [called_numbers, boards]
end

def get_winning_board(called_numbers, boards)
  called_numbers.each do |number|
    winning_board = boards
      .select { |b| b.try_mark_number(number) }
      .find(&:winning_board?)
    return [number, winning_board] if winning_board
  end
end

def get_last_winning_board(called_numbers, boards)
  called_numbers.reduce([]) do |acc, number|
    winning_boards = boards
      .select { |b| b.try_mark_number(number) }
      .find_all(&:winning_board?)
    if winning_boards
      acc += winning_boards.map { |winning_board| [number, winning_board] }
      boards.reject! { |board| winning_boards.include?(board) }
    end
    acc
  end.last
end

def get_score(winning_number, winning_board)
  winning_number * winning_board.unmarked_sum
end

def execute(input)
  called_numbers, boards = parse_input(input, 5)
  winning_number, winning_board = get_last_winning_board(called_numbers, boards)
  score = get_score(winning_number, winning_board)
end

input = File.read("/Users/justinlang/scratch/adventofcode/2021/day_4/input.txt")
result = execute(input)
puts "result = #{result.to_s}"
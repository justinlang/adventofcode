# https://adventofcode.com/2021/day/2

class Submarine
  attr_reader :horizontal, :depth, :aim

  def initialize()
    @horizontal = 0
    @depth = 0
    @aim = 0
  end

  def forward(units)
    @horizontal += units
    @depth += (@aim * units)
  end

  def up(units)
    @aim -= units
  end

  def down(units)
    @aim += units
  end
end

class Controller
  attr_reader :sub

  def initialize
    @commands = parse_input(File.read("/Users/justinlang/scratch/adventofcode/2021/day_2/input.txt"))
    @sub = Submarine.new
  end

  def execute
    @commands.each do |direction, magnitude|
      sub.send(direction.to_sym, magnitude.to_i)
    end
  end

  def print_result
    puts "#{sub.horizontal * sub.depth} "
  end

  def parse_input(raw_input)
    raw_input.split("\n").map { |command| command.split(" ") }
  end
end

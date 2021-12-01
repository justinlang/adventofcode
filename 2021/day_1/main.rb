# https://adventofcode.com/2021/day/1

def count_measurement_increases(measurements)
  increases = 0

  measurements.each_with_index do |m, i|
    next if i == 0

    if m > measurements[i - 1]
      increases += 1
    end
  end

  increases
end

def count_window_increases(windows)
  increases = 0

  windows.each_with_index do |w, i|
    next if i == 0

    if w.sum > windows[i - 1].sum
      increases += 1
    end
  end

  increases
end

def group_measurements(measurements)
  window_size = 3
  windows = []
  total_measurements = measurements.size

  measurements.each_with_index do |m, first|
    last = first + window_size - 1
    next if last >= total_measurements
    windows << (first..last).map { |i| measurements[i] }
  end

  windows
end

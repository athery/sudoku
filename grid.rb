class Grid
  attr :data

  def initialize(raw_text_grid)
    @data = raw_text_grid.split().map {|line| line.split('').map{|cell| cell == '.' ? '.' : cell.to_i}}
  end

  def solve!
    while !solved?
      changed_something_this_round = false
      data.each_with_index do |line, l|
        unless array_solved? line
          line.each_with_index do |value, c|
            if (value == '.') && (value = cell_solution(l,c))
              set_cell_value(l, c, value)
              changed_something_this_round = true
            end
          end
        end
      end
      if !changed_something_this_round
        return false
      end
    end
    return true
  end

  def solved?
    solved = true
    data.each do |line|
      if line.include? '.'
        return false
      end
    end
    return true
  end

  def print
    data.each{|line| puts line.join(' ')}
  end

  private

  def array_solved?(array)
    !array.include?('.')
  end

  def line(l)
    data[l]
  end

  def column(c)
    data.map{|line| line[c]}
  end

  def square(l,c)
    l_start = (l == 0 ? 0 : (3*(l/(data.size/3))))
    c_start = (c == 0 ? 0 : (3*(c/(data.size/3))))
    return data[l_start..(l_start + 2)].map{|line| line[c_start..(c_start + 2)]}.flatten
  end

  def cell_solution(l,c)
    values = [*1..9] - taken_values(line(l)) - taken_values(column(c)) - taken_values(square(l,c))
    return values.size == 1 ? values.first : false
  end

  def taken_values(array)
    array - ['.']
  end

  def set_cell_value(l, c, value)
    data[l][c] = value
  end

end

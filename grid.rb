class Grid
  attr :data

  def initialize(raw_text_grid)
    reset(raw_text_grid)
  end

  def solve!
    while !solved?
      changed_unit_this_round = false
      data.each_with_index do |line, l|
        unless array_solved? line
          line.each_with_index do |value, c|
            if (value == '.') && (value = unit_solution(l,c))
              set_unit_value(l, c, value)
              changed_unit_this_round = true
            end
          end
        end
      end
      return false if !changed_unit_this_round
    end
    return true
  end

  def solved?
    data.each {|line| return false if line.include? '.'}
    return true
  end

  def print
    data.each{|line| puts line.join(' ')}
  end

  def reset(raw_text_grid)
    @data = raw_text_grid.split().map {|line| line.split('').map{|unit| unit == '.' ? '.' : unit.to_i}}
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

  def region(l,c)
    l_start = 3*(l/3)
    c_start = 3*(c/3)
    return data[l_start..(l_start + 2)].map{|line| line[c_start..(c_start + 2)]}.flatten
  end

  def unit_solution(l,c)
    return (values = possible_unit_values(l,c)).size == 1 ? values.first : false
  end

  def possible_unit_values(l,c)
    [*1..9] - taken_values(line(l)) - taken_values(column(c)) - taken_values(region(l,c))
  end

  def taken_values(array)
    array - ['.']
  end

  def set_unit_value(l, c, value)
    data[l][c] = value
  end

end

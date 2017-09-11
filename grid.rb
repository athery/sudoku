class Grid
  attr :data

  def initialize(raw_text_grid)
    reset(raw_text_grid)
  end

  def solve!
    while !fully_solved? do
      nb_updated_this_round = 0
      nb_updated_this_round += simple_solve_scan
      nb_updated_this_round += deductive_solve_scan
      return false if (nb_updated_this_round == 0)
    end
    return true
  end

  def fully_solved?
    data.each {|line| return false unless array_solved?(line)}
    return true
  end

  def print
    puts to_s
  end

  def to_s
    data.map{|line| printable_array(line).join(' ')}.join("\n")
  end

  def reset(raw_text_grid)
    @data = raw_text_grid.split().map {|line| line.split('').map{|u| u == '.' ? [] : [u.to_i]}}
  end

#  private
  def simple_solve_scan
    nb_updated = 0
    data.each_with_index do |line, l|
      unless array_solved? line
        line.each_with_index do |u, c|
          if (!unit_solved?(u)) && (u != (new_values = possible_unit_values(l,c)))
            set_unit_values(l, c, new_values)
            nb_updated += 1
          end
        end
      end
    end
    return nb_updated
  end

  def deductive_solve_scan
    0
  end

  def printable_array(array)
    array.map{|u| unit_solved?(u) ? u.first : '.'}
  end

  def array_solved?(array)
    solved = true
    array.each{|u| solved = false unless unit_solved?(u)}
    return solved
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
    return data[l_start..(l_start + 2)].map{|line| line[c_start..(c_start + 2)]}.flatten(1)
  end

  def possible_unit_values(l,c)
    return unit(l,c) if unit_solved?(unit(l,c))
    [*1..9] - taken_values(region(l,c)) - taken_values(line(l)) - taken_values(column(c))
  end

  def taken_values(array)
    array.select{|v| v.size == 1}.flatten
  end

  def set_unit_values(l, c, values)
    data[l][c] = values
  end

  def set_line(line_number, line_array)
    data[line_number] = line_array
  end

  def set_column(column_number, column_array)
    data.each_with_index{|line, i| line[column_number] = column_array[i]}
  end

  def set_region(l, c, region_array)
    l_start = 3*(l/3)
    c_start = 3*(c/3)
    data[l_start..(l_start + 2)].each_with_index do |line,i|
      line[c_start..(c_start + 2)].each_with_index do |cell,j|
        data[l_start + i][c_start + j] = region_array[i*3+j]
      end
    end
  end

  def unit_solved?(u)
    u.size == 1
  end

  def unit(l,c)
    data[l][c]
  end

end

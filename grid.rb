class Grid
  attr :data

  def initialize(raw_text_grid)
    reset(raw_text_grid)
  end

  def solve!
    #while !fully_solved?
    5.times do
      changed_unit_this_round = false
      data.each_with_index do |line, l|
        unless array_solved? line
          line.each_with_index do |unit, c|
            if (!unit_solved?(unit)) && (unit != (new_values = possible_unit_values(l,c)))
              set_unit_values(l, c, new_values)
              changed_unit_this_round = true
            end
          end
        end
      end
      return false if !changed_unit_this_round
      p '============'
      print()
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
    @data = raw_text_grid.split().map {|line| line.split('').map{|unit| unit == '.' ? [] : [unit.to_i]}}
  end

#  private

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
    [*1..9] - taken_values(line(l)) - taken_values(column(c)) - taken_values(region(l,c))
  end

  def taken_values(array)
    array.flatten
  end

  def set_unit_values(l, c, values)
    data[l][c] = values
  end

  def unit_solved?(unit)
    unit.size == 1
  end

end

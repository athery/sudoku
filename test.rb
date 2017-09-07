require 'minitest/autorun'
require('./grid.rb')

grid_names = ['easy', 'medium1', 'medium2', 'hard']

describe 'overall solving algorithm' do
  it 'should solve an easy grid' do
    check_grid_solving('easy')
  end
  it 'should solve medium grids' do
    check_grid_solving('medium1')
    check_grid_solving('medium2')
  end
  it 'should not solve a hard grid' do
    check_grid_solving('hard', false)
  end
end

describe 'a new grid'do
  before do
    @grid = new_grid('easy')
    @solution = solution_grid('easy')
  end

  it 'should load properly and be accessible' do
    @grid.fully_solved?.must_equal(false)
    @grid.region(0,8).must_equal([[2],[9],[],[],[],[6],[],[],[]])
    @grid.line(1).must_equal([[1],[],[],[],[9],[8],[],[],[6]])
    @grid.column(7).must_equal([[9],[],[],[],[],[],[],[],[2]])
  end

  it 'should know when its solved partially or fully' do
    @grid.fully_solved?.must_equal(false)
    @solution.fully_solved?.must_equal(true)
    @grid.array_solved?(@grid.line(1)).must_equal(false)
    @solution.array_solved?(@solution.column(3)).must_equal(true)
    @grid.unit_solved?([]).must_equal(false)
    @grid.unit_solved?([3]).must_equal(true)
    @grid.unit_solved?([2, 5]).must_equal(false)

  end

  it 'should know what values are taken in a given line/column/region' do
    @grid.taken_values([[2], [], [9, 3, 6], [7]]).must_equal([2,7])
    @grid.taken_values(@grid.line(1)).must_equal([1, 9, 8, 6])
    @grid.taken_values(@grid.region(0, 8)).must_equal([2, 9, 6])
  end

  it 'should know to deduct possible values for a cell, in easy/medium case' do
    @grid.possible_unit_values(2,0).must_equal([2,4,9])
  end

end

def check_grid_solving(name, solved=true)
  grid = new_grid(name)
  grid.solve!
  grid.fully_solved?.must_equal solved
  grid.to_s.must_equal solution_grid(name).to_s
end

def new_grid(name)
  Grid.new File.read("grid_samples/problems/#{name}.txt")
end

def solution_grid(name)
  Grid.new File.read("grid_samples/solutions/#{name}.txt")
end

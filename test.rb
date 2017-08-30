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
    check_grid_solving('hard')
  end
end

def check_grid_solving(name)
  grid = Grid.new File.read("grid_samples/problems/#{name}.txt")
  grid.solve!
  grid.to_s.must_equal Grid.new(File.read("grid_samples/solutions/#{name}.txt")).to_s
end

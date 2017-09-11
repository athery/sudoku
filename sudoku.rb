###################################
# The Sudoku challenge from Zineb #
# non TDD version                 #
# Time used : 3h (too much!!)     #
###################################

require('./grid.rb')

# Main program
grid = Grid.new(File.read('grid_samples/problems/hard.txt'))

puts ' '
puts "Grille de départ :"
puts '=================='
grid.print

success = grid.solve!

puts ' '
puts success ? 'VICTOIRE!  Le resultat :' : "Damned I'm stuck, sorry :/"
puts '========================'
grid.print

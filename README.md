# Zizou's Sudoku

My Ruby implementation of Zineb's Sudoku challenge

How to run the program :

```
> ruby sudoku.rb
```

How to run the tests (written in minitest specs format) :

```
> ruby test.rb
```



## TODO : Solve difficult sudoku grids

Easy and Medium grids can be solved simply by looping on every unsolved cell and testing for a number that is neither in the line, nor the column, nor the region of the cell. There is always at least one cell that can be solved that way, until the whole grid is solved.

But grids rated "hard" are different : at some point (and often since the beginning), no cell can be solved this way : all of them have multiple possible value, rendering the simple algorithm useless.

To solve a "hard" grid, one must proceed by elimination :
0. try the simple method until you are stuck
1. loop over all cells, and compute the list of possible values for each one
2. loop over lines :
  - if a given number is only possible in the intersection between the line and a region, remove this number from the possible values of all unsolved cells in that region that are not part of the line
  - each time you remove a number from the possible values of a cell, if there is only one value left, the cell is solved.
3. loop on the columns, and do the same thing.
4. loop over regions :
  - if two given numbers are only possible on cells in the same line/column, then remove this numbers from the possible values of all unsolved cells on this line/column that are not part of the region
  - each time you remove a number from the possible values of a cell, if there is only one value left, the cell is solved.
5. go back to the top :)

Exit condition : if after going through 0 to 4, you removed no number from the possible values of any cell and you did not solve any cell, you are stuck. This might be a "diabolico" grid :)

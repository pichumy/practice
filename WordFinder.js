import WordVector from './WordVector';
import TrieTree from './TrieTree';
/**
 * Implement the functions in this class marked TODO
 */
export default class WordFinder {

    /**
     * Initializes the WordFinder with a word-grid specified as a String of the character lines going from left-right. The
     * lines are concatenated together from top to bottom. E.g. the String "ABCDEFGHIJKLMNOP" would describe the grid:
     *
     * A B C D
     * E F G H
     * I J K L
     * M N O P
     *
     * The characters should always form a perfect square grid. Otherwise, you code should throw an exception.
     */
    constructor(wordGrid) {
      this.dimensions = Math.sqrt(wordGrid.length);
      this.grid = [];
      this.tree = new TrieTree();
      // Ensure that we have a whole number
      if(this.dimensions === Math.floor(this.dimensions)){
        for(let i = 0; i < this.dimensions; i++){
          let row = [];
          for(let j = 0; j < this.dimensions; j++){
            row.push(wordGrid[i * this.dimensions + j]);
          }
          this.grid.push(row);
        }
      }else{
        throw "Improper dimensions! Must be able to make a square!";
      }
    }

    /**
     * Given a collection of words, will find and return the location of the words in the initialized wordGrid.
     * The vectorArray returned here should be an array of WordVector objects.
     * The words can extend in all 8 directions, horizontally, vertically, and diagonally, forwards or backwards.
     */
    findWords(words) {
      // Register the words into the tree...
        words.forEach(word => {
          this.tree.addWord(word);
        });
        let vectorArray = [];

        for(let i = 0; i < this.dimensions; i++){
          for(let j = 0; j < this.dimensions; j++){
            // Check for possible words that can be made starting at any position in the grid...
            let vectors = this.checkPossibilities(i, j);
            vectors.forEach(wordVector => {
              vectorArray.push(wordVector);
            })
          }
        }
        return vectorArray;
    }

    checkPossibilities(i, j){
        let first_letter = this.grid[i][j];
        let vectors = [];
        // Handling with an options object instead of an if or switch statement...
        let options = {
          // One letter word found...
          1: () => { vectors.push(new WordVector(first_letter, i, j, i, j)) },
          // Go look for words. Increments found words into vectors array.
          0: (vectors, i, j) => { this.searchForWords(vectors, i, j) },
          // do nothing. String used here due to how JS handles negative literals.
          "-1": () => {  }
        }
        options[this.tree.checkWord(first_letter)](vectors, i, j);

        return vectors;
    }

    searchForWords(vectors, i, j){
      let directions = [
        [0, -1], // left
        [-1, -1], // leftup
        [1, -1], // leftdown
        [-1, 0], // up
        [1, 0], // down
        [0, 1], // right
        [-1, 1], // rightup
        [1, 1] // rightdown
      ];
      // Check in every direction for possible words
      directions.forEach(direction => {
        let foundWords = this.check(i, j, direction[0], direction[1]);
        // Add found word to vectors array.
        foundWords.forEach(wordObject => {
            vectors.push(new WordVector(wordObject.word, i, j, wordObject.end_i, wordObject.end_j));
        });
      });

    }

    check(i, j, directionX, directionY){
      let word = this.grid[i][j];
      let foundWords = [];
      // trigger endLoop if a possible word can no longer be found in this direction.
      let endLoop = false;
      // Using an options object to replace a switch or if statements.
      let options = {
        // Word Found!
        1: (word, i, j) => { foundWords.push({word, end_i: i, end_j: j}) },
        // do nothing
        0: () => { },
        // End the loop.
        '-1': () => { endLoop = true}
      }
      // Break out of the loop if you go out of bounds... Since I only made one method, I don't know necessarily if directionX and directionY are positive or negative, so I need to do checks like this.
      while(!endLoop && i + directionX >= 0 && i + directionX <= this.dimensions - 1 && j + directionY >= 0 && j + directionY <= this.dimensions - 1){
        i = i + directionX;
        j = j + directionY;
        word = word + this.grid[i][j];
        options[this.tree.checkWord(word)](word, i, j);
      }
      return foundWords;
    }
}

/**
 * Describes the start and end locations of a word in the grid where the top left coordinate is 0,0
 * and N,N where N is the height and width of the grid.
 */
export default class WordVector {
    constructor(word, startX, startY, endX, endY) {
        this.word = word;
        this.startX = startX;
        this.startY = startY;
        this.endX = endX;
        this.endY = endY;
    }
    toString() {
        return "word= '" + this.word + "', start=[" + this.startX + ", " + this.startY + "], end = [" + this.endX + ", " + this.endY + "]";
    }
}

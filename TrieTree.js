import TrieNode from './TrieNode';

export default class TrieTree {
  constructor(){
    this.root = new TrieNode(null);
    // Keeping a word bank requires O(n) space where N = # of words. I'm not aware of a more stable way to check for whether a word has been found or not though. (Checking with length has issues due to subwords inside larger words)
    this.wordBank = {};
  }
  addWord(word){
    this.wordBank[word] = true;
    // start at the root
    let currentNode = this.root;
    for(let i = 0; i < word.length; i++){
      let child = currentNode[word[i]];
      // If that node is already a child of this node...
      if(child){
        currentNode = child;
      }else{
        // Case that this node does not have that character as a child
        let newNode = new TrieNode(word[i]);
        currentNode[word[i]] = newNode;
        currentNode = newNode;
      }
    }
  }
  // Checks the trie tree for the word passed in
  checkWord(word){
    let currentNode = this.root;
    // If this word
    if(this.wordBank[word]){
      return 1;
    }
    for(let i = 0; i < word.length; i++){
      let child = currentNode[word[i]];
      // If that child node exists, then continue. Else, return - 1.
      if(child){
        currentNode = child;
      }else{
        // This means that this fragment does not exist in the tree. Stop searching.
        return -1;
      }
    }
    // This means that the fragment is present, but it is not a word in the wordbank. Continue searching.
    return 0;
  }
}

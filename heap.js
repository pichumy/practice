// incomplete 
class MaxHeap {
  constructor(store = []){
    this.store = store;
  }
  count(){
    return this.store.length;
  }
  insert(value){
    this.store.push(value);
    heapify_up(this.store.length - 1);
  }
  // [0, 1, 2, 3, 4, 5, 6]
  // index[1] has children 3,4
  // index[2] has children 5,6
  children(index){
    let indices = [];
    let length = count();
    let index1 = index * 2 + 1;
    let index2 = index * 2 + 2;
    if(index2 < length){
      indices.push(index2);
      indices.push(index1);
    }else if(index1 < length){
      indices.push(index1)
    }
    return indices;
  }
  // index[1] has parent [0]
  // index[2] has parent [0]
  // index[3] has parent [1]
  // index[4] has parent [1]
  // index[5] has parent [2]
  // index[6] has parent [2]
  parent(index){
    // root has no parents
    if(index === 0){
      return null;
    }
    if(index % 2 === 0){
      return Math.floor((index - 1) / 2);
    }else{
      return Math.floor(index / 2);
    }
  }
  heapify_up(index){
    let parent_idx = parent(index);
    if(this.store[index] > this.store[parent_idx]){
      [this.store[index], this.store[parent_idx]] = [this.store[parent_idx], this.store[index]];
      heapify_up(parent_idx);
    }
  }
  heapify_down(index){
    let children = children(index);
  }
}

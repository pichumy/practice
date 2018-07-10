# Given a sorted dictionary (array of words) of an alien language, find the order of the characters in the language.

require_relative 'graph'

def dependency_graph(array)
  vertexes = []
  letters = []
  edges = []
  # start at the end, generate dependencies
  last_word = array.pop.chars
  until array.empty?
    compare_word = array.pop
    idx = 0
    # Creating vertexes and edges
    while idx < compare_word.length
      break if last_word[idx].nil?
      unless letters.include?(compare_word[idx])
        letters.push(compare_word[idx])
        vertexes.push(Vertex.new(compare_word[idx]))
      end
      unless letters.include?(last_word[idx])
        letters.push(last_word[idx])
        vertexes.push(Vertex.new(last_word[idx]))
      end
      # Add depndency edge at point of comparison
      if compare_word[idx] != last_word[idx]
        dependency = vertexes[letters.find_index(compare_word[idx])]
        other_letter = vertexes[letters.find_index(last_word[idx])]
        unless edges.include?([dependency, other_letter])
          Edge.new(dependency, other_letter)
          edges.push([dependency, other_letter])
        end
        break
      end
      idx += 1
    end
    last_word = compare_word
  end
  # Testing
  # vertexes.each do |vertex|
  #   p 'vertex value'
  #   p vertex.value
  #   p 'in_edges'
  #   vertex.in_edges.each do |edge|
  #     p edge.from_vertex.value
  #   end
  #   p 'out_edges'
  #   vertex.out_edges.each do |edge|
  #     p edge.to_vertex.value
  #   end
  # end
  result = tarians_topological_sort(vertexes)

  result.map do |vertex|
    vertex.value
  end

end

def tarians_topological_sort(vertices)
  output = []
  until vertices.empty?
    random_node = vertices[rand(vertices.length)]
    vertices.delete(random_node)
    return [] if dfs(random_node, output).nil?
  end
  output.reverse
end

def dfs(node, output = [], visited = [])
  return nil if visited.include?(node)
  return output if output.include?(node)
  return output.push(node) if node.out_edges.empty?
  visited.push(node)
  node.out_edges.each do |edge|
    return nil if dfs(edge.to_vertex, output, visited.dup).nil?
  end
  output.push(node)
end

input = ["baa", "abcd", "abca", "cab", "cad"]

print dependency_graph(input)

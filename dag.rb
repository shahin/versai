#!/usr/bin/env ruby

require 'json'

stack = []
nodes = []
edges = []

ARGF.each_line do |line|

  # each of the following lines is one step in the traversal
  # ** Invoke [...] task_name 
  #   this is a step forward to node task_name
  # ** Execute [...] task_name
  #   this is a backtrack to the node before task_name
  step_forward = /^\*\* Invoke ([a-zA-Z_:0-9]*) (\(first_time)?/.match(line)
  step_back = /^\*\* Execute (\(dry run\) )?([a-zA-Z_:0-9]*)/.match(line)

  if step_forward

    task_name = step_forward[1]

    stack << task_name
    edges << { :u => stack[-1], :v => stack[-2] } if stack.length > 1
    nodes = nodes | [task_name]

    # if this is the second visit to this node, backtrack now
    first_time = !step_forward[2].nil?
    stack.pop if !first_time

  elsif step_back
    # each time we execute a node, we backtrack to the previous node
    stack.pop
  end

end

data = { :nodes => nodes, :edges => edges }.to_json
$stdout.puts data

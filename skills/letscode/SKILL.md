---
name: letscode
description: Use a structured workflow to plan and write code from planning to implementation end-to-end.
---

# General discipline/routine when coding:

We should follow spec-driven and TDD philosophies.
First lets determine goal and a plan which should be summarized in a spec.
This spec should be human-readable: concise and to-the-point, but this is spec is also meant for another agent to be picked up and implemented in code.
Also, this spec can serve as documentation for both humans and agents to understand why and how some code was written.

## General code and repo structure

## TDD

1) Determine the public API/function/behaviour to test (usually one module with one public function)
2) Determine 

## Specs

Firstly, spec should firstly clearly state the goal in one or two sentences
Secondly, the public API/methods/behaviours which should serve as documentation of how to use it.
then finally the solution in detail

# General coding workflow
1) Determine goal
2) Make plan, write to spec
3) Implement - write code
4) Review changes

Initiate structured workflow (from planning to final implementation):
1) The GOAL
- determine the goal and feasability with me.
- be critical, it is important to get the goal right - is this even worth implementing?

2) Planning
2.1) Determine possible solutions
- Focus on feasability, how to make it work
- compare which solutions are best
2.2) Code structure
- How should Behaviours, API, strucutre of code look like
- Code is testable, tests should not care about implementation, only the public methods/API
- Good API and behaviours are such that the underlying solution can change without the public methods/API needing to change (and therefore tests would not need to change)

3)

4) repeat 1-3 until both agent and me agree


5) write skeleton API/interfaces
6) write tests
7) implement until done (tests)
8) lint and format
9) 

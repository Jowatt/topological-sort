note
	description: "A class that encapsulates a Topological Sort algorithm."
	author: "Lorenzo and Michele"
	date: "$Date$"
	revision: "$Revision$"

class
	TOPOLOGICAL_SORT

create
	make

feature
	make (elems: LINKED_LIST[INTEGER];
			cons: LINKED_LIST[TUPLE[INTEGER, INTEGER]])
		local
			e0, e1: INTEGER
		do
			elements := elems
			constraints := cons
			create successors.make_filled (create {LINKED_LIST[INTEGER]}.make, 1, elements.count)
			create predecessor_count.make_filled (0, 1, elements.count)
			create candidates.make

			-- fill the fuckin' structures

			across 1 |..| elements.count as i loop
				successors.put (create {LINKED_LIST[INTEGER]}.make, i.item)
			end

			across constraints as c loop
				e0 := c.item.integer_item(1)
				e1 := c.item.integer_item(2)
				successors[e0].extend (e1)
				predecessor_count[e1] := predecessor_count[e1] + 1
			end

			across predecessor_count as pred loop
				if pred.item = 0 then
					candidates.put (pred.target_index)
				end
			end
	end

feature {NONE}
	elements: LINKED_LIST[INTEGER]
	constraints: LINKED_LIST[TUPLE[INTEGER, INTEGER]]
	successors: ARRAY[LINKED_LIST[INTEGER]]
	predecessor_count: ARRAY[INTEGER]
	candidates: LINKED_STACK[INTEGER]

	dump do
		io.put_string ("Elements:%N")
		across elements as e
		loop
		 io.put_string (e.item.out + "%N")
		end
		io.put_string ("%N")

		io.put_string ("Constraints:%N")
		across constraints as c
		loop
		 io.put_string (c.item.out + "%N")
		end
		io.put_string ("%N")

		io.put_string ("Predecessor count:%N")
		io.put_string (predecessor_count.out)
		io.put_string ("%N")

		io.put_string ("Candidates:%N")
		io.put_string (candidates.out)
		io.put_string ("%N")

		io.put_string ("Successors:%N")
		across successors as s
		loop
			io.put_string (s.target_index.out + " -> ")
			across s.item as ss  loop
		 		io.put_string (ss.item.out + " ")
		 	end
		 	io.put_string ("%N")
		end
		io.put_string ("%N")
	end

feature
	sort: LINKED_LIST[INTEGER]
	local
		sorted: LINKED_LIST[INTEGER]
		next: INTEGER
	do
		from
			create sorted.make
		until
			candidates.is_empty
		loop
			next := candidates.item
			candidates.remove

			sorted.extend (next)
			across successors.at (next) as s loop
				predecessor_count[s.item] := predecessor_count[s.item] - 1
				if predecessor_count[s.item] = 0 then
					candidates.put (s.item)
				end
			end
		end

		if elements.count = sorted.count then
			io.put_string ("Sort completed%N")
		else
			io.put_string ("Cycle detected%N")
		end

	 	Result := sorted
	end
end

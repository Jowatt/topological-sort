note
	description: "topological_sort application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			topological: TOPOLOGICAL_SORT
			elements: LINKED_LIST[INTEGER]
			constraints: LINKED_LIST[TUPLE[INTEGER, INTEGER]]
			sorted: LINKED_LIST[INTEGER]
		do
			create elements.make
			create constraints.make
			elements.extend (1)
			elements.extend (2)
			elements.extend (3)
			elements.extend (4)
			elements.extend (5)

			constraints.extend ([1, 3])
			constraints.extend ([2, 3])
			constraints.extend ([3, 4])
			constraints.extend ([4, 5])
			create topological.make(elements, constraints)
			sorted := topological.sort

			io.put_string ("Sorted:%N")
			across sorted as s
			loop
			 io.put_string (s.item.out + "%N")
			end
			io.put_string ("%N")
		end
end

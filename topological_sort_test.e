note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TOPOLOGICAL_SORT_TEST

inherit
	EQA_TEST_SET
	redefine
		on_prepare
	end

feature {NONE}
	topological: detachable TOPOLOGICAL_SORT
	elements: LINKED_LIST[INTEGER]
	constraints: LINKED_LIST[TUPLE[INTEGER, INTEGER]]
	sorted: detachable LINKED_LIST[INTEGER]

feature -- Test routines

	on_prepare
		do
			create elements.make
			create constraints.make
		end

	test_normal_graph
		do
			assert ("not_implemented", False)
		end

	test_cycle
		do
			assert ("not_implemented", False)
		end

	test_partition
		do
			assert ("not_implemented", False)
		end

	test_no_constraints
		do
			assert ("not_implemented", False)
		end

end



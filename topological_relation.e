note
--	description: "Summary description for {TOPOLOGICAL_RELATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	model: adj

class
	TOPOLOGICAL_RELATION

create
	make

feature
	rel: MML_RELATION[INTEGER, INTEGER]
	note
		status: ghost
	attribute
	end

feature
	adj: V_ARRAY[V_ARRAY[INTEGER]]
	-- predecessor_count: ARRAY[INTEGER]
	-- candidates: LINKED_STACK[INTEGER]
	cardinality: INTEGER

feature
	make(domain_cardinality: INTEGER)
	note
		status: creator
	require
		domain_cardinality >= 1
	do
		create rel.default_create
		cardinality := domain_cardinality
		create adj.make_filled (1, domain_cardinality, create {V_ARRAY[INTEGER]}.make_filled (1, domain_cardinality, 0))
		--create predecessor_count.make_filled (0, 1, elements.count)
		--create candidates.make


--		across constraints as c loop
--			e0 := c.item.integer_item(1)
--			e1 := c.item.integer_item(2)
--			successors[e0].extend (e1)
--			predecessor_count[e1] := predecessor_count[e1] + 1
--		end

--		across predecessor_count as pred loop
--			if pred.item = 0 then
--				candidates.put (pred.target_index)
--			end

	ensure
		adj.lower = 1
		adj.upper = cardinality
		cardinality = domain_cardinality
		rel.is_empty
		matrix_empty:
		across adj.sequence as row
			all	row.item /= Void
			and across row.item.sequence as element
				all element.item = 0
			end
		end
		--square: square_matrix
		--voidness: void_stuff
	end

--feature
--	square_matrix: BOOLEAN
--		note
--			status: ghost, functional
--		do
--			Result := adj /= Void and adj.sequence.count = cardinality
--					and across adj.sequence as row all
--							row.item.sequence.count = adj.sequence.count
--					end
--		end


--feature
--	void_stuff: BOOLEAN
--		note
--			status: ghost, functional
--		do
--			Result := adj /= Void and
--					across adj.sequence as row all
--					row.item /= Void
--					end
--		end

feature
	in(first, second: INTEGER): BOOLEAN
	require
		first <= cardinality and second <= cardinality
	do
		Result := rel.has (first, second)
	ensure
		Result = rel.has (first, second)
	end

	is_empty: BOOLEAN do
		Result := rel.is_empty
	ensure
		Result = rel.is_empty
	end

	extend(first, second: INTEGER)
	require
		first >= 1
		first <= cardinality

	--	adj[first] /= Void
--		second >= adj[first].lower
--		second >= adj[first].upper
		-- modify_model("adj", Current)
	local
		row: V_ARRAY[INTEGER]
	do
		-- OAT update
		rel := rel.extended (first, second)

		-- Internal representation update
		-- check assume: False end
		check first_in_bound: first >= adj.lower and first <= adj.upper  end
		-- check assume: (adj.lower = 1 and adj.upper = 5) end
		-- check diocane: adj. end
		row := adj[first]
		check row_not_void: row /= Void end
		check assume: second >= row.lower and second <= row.upper end

		check se_vabbe: row.has_index (second) end

		row[second] := 1
	ensure
		rel.has (first, second)
		count_increases: not (old rel).has(first, second) implies (rel.count = (old rel).count + 1)
		rel = (old rel).extended (first, second)
	end

	remove(first, second: INTEGER) do
		rel := rel.removed (first, second)
	ensure
		not rel.has (first, second)
		count_decreases: (old rel).has(first, second) implies (rel.count = (old rel).count - 1)
		rel = (old rel).removed (first, second)
	end

	is_subset_of(rel2: TOPOLOGICAL_RELATION): BOOLEAN do
		-- Result := rel.difference (rel2.rel).is_empty
		Result := across rel as pair all rel2.rel.has(pair.item.left, pair.item.right) end
	ensure
--		rel.is_empty and rel2.is_empty implies Result
--		rel.is_empty implies Result
		-- (rel.has (1, 1) and rel.count = 1 and rel2.rel.has (1,1)) implies Result
		-- Result implies (rel.count <= rel2.rel.count)
		Result = across rel as pair all rel2.rel.has(pair.item.left, pair.item.right) end
	end

	invariant
	true
		--adj /= Void
		--square_matrix
		-- rel /= Void and rep /= Void  -- MAKES AUTOPROOF GO CRAZY
		--void_stuff and square_matrix

--		square_matrix:
--		across  1 |..| cardinality as i all
--			adj[i.item].count = adj.count and adj[i.item].lower = adj.lower
--			and adj[i.item].upper = adj.upper
--		end
--		and adj.lower = 1 and adj.upper = cardinality
--		and adj.count = cardinality
end

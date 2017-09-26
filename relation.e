note
--	description: "Summary description for {TOPOLOGICAL_RELATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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


------feature {NONE}
------	rep:  V_HASH_SET[V_STRING]

------	encode_couple(first, second: INTEGER): V_STRING do
------		Result := create {V_STRING}.make_from_string (first.out + ":" + second.out)
------	end

feature
	make
	note
		status: creator
	do
		create rel.default_create
--------		create rep.make (create {V_HASH_LOCK[V_STRING]})
	ensure
		rel.is_empty
	end

feature
	in(first, second: INTEGER): BOOLEAN do
		Result := rel.has (first, second)
	ensure
		Result = rel.has (first, second)
	end

	is_empty: BOOLEAN do
		Result := rel.is_empty
	ensure
		Result = rel.is_empty
	end

	extend(first, second: INTEGER) do
		-- rep.extend (encode_couple(first, second))
		rel := rel.extended (first, second)
	ensure
		rel.has (first, second)
		count_increases: not (old rel).has(first, second) implies (rel.count = (old rel).count + 1)
		rel = (old rel).extended (first, second)
		-- "old" cannot be used in "across" expressions!
--		frame: across rel as pair all
--			not (first = pair.item.left and second = pair.item.right) implies
--			(old rel).has (pair.item.left, pair.item.right) end
--		across rel as pair all (old rel).has (pair.item.left, pair.item.right)
--			and not (pair.item.left = first and pair.item.right = second) end
	end

	remove(first, second: INTEGER) do
		-- rep.remove (encode_couple(first, second))
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
		-- rel /= Void and rep /= Void  -- MAKES AUTOPROOF GO CRAZY
		just_4_fun: true
end

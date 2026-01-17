note
	description: "[
		Represents a GraphQL error with message, locations, and path.

		Per GraphQL specification, errors contain:
		- message: Human-readable error description
		- locations: Source locations where error occurred (optional)
		- path: Path to field that caused error (optional)
	]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	GQL_ERROR

create
	make,
	make_from_json

feature {NONE} -- Initialization

	make (a_message: STRING)
			-- Create error with `a_message'.
		require
			message_not_empty: not a_message.is_empty
		do
			message := a_message.twin
			create locations.make (0)
			create path.make (0)
		ensure
			message_set: message.same_string (a_message)
			no_locations: locations.is_empty
			no_path: path.is_empty
		end

	make_from_json (a_obj: SIMPLE_JSON_OBJECT)
			-- Parse error from JSON object.
		require
			object_attached: a_obj /= Void
		do
			-- Extract message
			if attached a_obj.item ("message") as l_msg and then attached l_msg.as_string_32 as l_str then
				message := l_str.to_string_8
			else
				message := "Unknown error"
			end

			create locations.make (0)
			create path.make (0)

			-- Extract locations array
			if attached a_obj.item ("locations") as l_locs and then attached l_locs.as_array as l_arr then
				parse_locations (l_arr)
			end

			-- Extract path array
			if attached a_obj.item ("path") as l_path and then attached l_path.as_array as l_arr then
				parse_path (l_arr)
			end
		ensure
			message_not_empty: not message.is_empty
			locations_attached: locations /= Void
			path_attached: path /= Void
		end

feature -- Access

	message: STRING
			-- Human-readable error description

	locations: ARRAYED_LIST [TUPLE [line: INTEGER; column: INTEGER]]
			-- Source locations where error occurred

	path: ARRAYED_LIST [STRING]
			-- Path to the field that caused the error

feature -- Status Report

	has_locations: BOOLEAN
			-- Does this error have location information?
		do
			Result := not locations.is_empty
		ensure
			definition: Result = not locations.is_empty
		end

	has_path: BOOLEAN
			-- Does this error have path information?
		do
			Result := not path.is_empty
		ensure
			definition: Result = not path.is_empty
		end

feature -- Output

	to_string: STRING
			-- Human-readable representation of error.
		do
			create Result.make (100)
			Result.append (message)

			if not locations.is_empty then
				Result.append (" at ")
				across locations as ic loop
					if @ic.cursor_index > 1 then
						Result.append (", ")
					end
					Result.append ("line ")
					Result.append_integer (ic.line)
					Result.append (":")
					Result.append_integer (ic.column)
				end
			end

			if not path.is_empty then
				Result.append (" (path: ")
				across path as ic loop
					if @ic.cursor_index > 1 then
						Result.append (".")
					end
					Result.append (ic)
				end
				Result.append (")")
			end
		ensure
			result_not_empty: not Result.is_empty
			contains_message: Result.has_substring (message)
		end

feature {NONE} -- Implementation

	parse_locations (a_array: SIMPLE_JSON_ARRAY)
			-- Parse locations from JSON array.
		require
			array_attached: a_array /= Void
		local
			i: INTEGER
			l_line, l_column: INTEGER
		do
			from
				i := 1
			until
				i > a_array.count
			loop
				if attached a_array.item (i) as l_item and then attached l_item.as_object as l_loc then
					l_line := 0
					l_column := 0
					if attached l_loc.item ("line") as l_ln and then l_ln.is_integer then
						l_line := l_ln.as_integer.to_integer_32
					end
					if attached l_loc.item ("column") as l_col and then l_col.is_integer then
						l_column := l_col.as_integer.to_integer_32
					end
					locations.extend ([l_line, l_column])
				end
				i := i + 1
			end
		end

	parse_path (a_array: SIMPLE_JSON_ARRAY)
			-- Parse path from JSON array.
		require
			array_attached: a_array /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_array.count
			loop
				if attached a_array.item (i) as l_item then
					if attached l_item.as_string_32 as l_str then
						path.extend (l_str.to_string_8)
					elseif l_item.is_integer then
						path.extend (l_item.as_integer.out)
					end
				end
				i := i + 1
			end
		end

invariant
	message_not_empty: not message.is_empty
	locations_attached: locations /= Void
	path_attached: path /= Void

end

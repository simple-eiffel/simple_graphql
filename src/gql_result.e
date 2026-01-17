note
	description: "[
		Represents a GraphQL response with data and/or errors.

		Parses GraphQL JSON response containing 'data' and 'errors' fields.
		Provides convenient access to response data and error information.
	]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	GQL_RESULT

create
	make,
	make_error

feature {NONE} -- Initialization

	make (a_json: STRING)
			-- Parse GraphQL response from `a_json'.
		require
			json_not_empty: not a_json.is_empty
		local
			l_json: SIMPLE_JSON
		do
			raw_json := a_json.twin
			create errors.make (0)
			create l_json

			if attached l_json.parse (a_json) as l_root and then attached l_root.as_object as l_obj then
				-- Extract data field
				if attached l_obj.item ("data") as l_data then
					data := l_data
				end

				-- Extract errors array
				if attached l_obj.item ("errors") as l_errors and then attached l_errors.as_array as l_arr then
					parse_errors (l_arr)
				end
			else
				-- Parse failed - treat as error
				errors.extend (create {GQL_ERROR}.make ("Failed to parse GraphQL response"))
			end
		ensure
			raw_json_set: raw_json.same_string (a_json)
			errors_attached: errors /= Void
		end

	make_error (a_message: STRING)
			-- Create error result with `a_message'.
		require
			message_not_empty: not a_message.is_empty
		do
			raw_json := ""
			create errors.make (1)
			errors.extend (create {GQL_ERROR}.make (a_message))
		ensure
			has_error: has_errors
			error_count_one: errors.count = 1
			no_data: data = Void
		end

feature -- Access

	data: detachable SIMPLE_JSON_VALUE
			-- Response data (Void if error or no data)

	errors: ARRAYED_LIST [GQL_ERROR]
			-- List of errors from response

	raw_json: STRING
			-- Original JSON response string

	first_error_message: STRING
			-- Message from first error, or empty if no errors.
		do
			if errors.is_empty then
				Result := ""
			else
				Result := errors.first.message
			end
		ensure
			empty_when_no_errors: errors.is_empty implies Result.is_empty
			first_error_when_has_errors: not errors.is_empty implies Result.same_string (errors.first.message)
		end

feature -- Status Report

	is_successful: BOOLEAN
			-- Was the operation successful (has data, no errors)?
		do
			Result := data /= Void and errors.is_empty
		ensure
			definition: Result = (data /= Void and errors.is_empty)
		end

	has_errors: BOOLEAN
			-- Does the response contain errors?
		do
			Result := not errors.is_empty
		ensure
			definition: Result = not errors.is_empty
		end

	has_data: BOOLEAN
			-- Does the response contain data?
		do
			Result := data /= Void
		ensure
			definition: Result = (data /= Void)
		end

feature {NONE} -- Implementation

	parse_errors (a_array: SIMPLE_JSON_ARRAY)
			-- Parse errors from JSON array.
		require
			array_attached: a_array /= Void
		local
			i: INTEGER
			l_error: GQL_ERROR
		do
			from
				i := 1
			until
				i > a_array.count
			loop
				if attached a_array.item (i) as l_item and then attached l_item.as_object as l_obj then
					create l_error.make_from_json (l_obj)
					errors.extend (l_error)
				end
				i := i + 1
			end
		end

invariant
	errors_attached: errors /= Void
	raw_json_attached: raw_json /= Void

end
note
	description: "[
		Represents a GraphQL query with optional variables and operation name.

		Encapsulates the query string, variables, and operation name
		for GraphQL requests. Provides JSON serialization for HTTP transport.
	]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	GQL_QUERY

create
	make,
	make_with_variables,
	make_with_operation

feature {NONE} -- Initialization

	make (a_query: STRING)
			-- Create query with `a_query' text.
		require
			query_not_empty: not a_query.is_empty
		do
			query := a_query.twin
		ensure
			query_set: query.same_string (a_query)
			no_variables: variables = Void
			no_operation_name: operation_name = Void
		end

	make_with_variables (a_query: STRING; a_variables: SIMPLE_JSON_OBJECT)
			-- Create query with `a_query' and `a_variables'.
		require
			query_not_empty: not a_query.is_empty
			variables_attached: a_variables /= Void
		do
			query := a_query.twin
			variables := a_variables
		ensure
			query_set: query.same_string (a_query)
			variables_set: variables = a_variables
			no_operation_name: operation_name = Void
		end

	make_with_operation (a_query: STRING; a_variables: detachable SIMPLE_JSON_OBJECT; a_operation_name: STRING)
			-- Create query with all parameters.
		require
			query_not_empty: not a_query.is_empty
			operation_name_not_empty: not a_operation_name.is_empty
		do
			query := a_query.twin
			variables := a_variables
			operation_name := a_operation_name.twin
		ensure
			query_set: query.same_string (a_query)
			variables_set: variables = a_variables
			operation_name_set: attached operation_name as op and then op.same_string (a_operation_name)
		end

feature -- Access

	query: STRING
			-- GraphQL query text

	variables: detachable SIMPLE_JSON_OBJECT
			-- Optional query variables

	operation_name: detachable STRING
			-- Optional operation name for multi-operation documents

feature -- Status Report

	has_variables: BOOLEAN
			-- Does this query have variables?
		do
			Result := variables /= Void
		ensure
			definition: Result = (variables /= Void)
		end

	has_operation_name: BOOLEAN
			-- Does this query have an operation name?
		do
			Result := operation_name /= Void
		ensure
			definition: Result = (operation_name /= Void)
		end

feature -- Conversion

	to_json: STRING
			-- Convert to JSON string for HTTP request body.
		local
			l_json: SIMPLE_JSON_OBJECT
		do
			create l_json.make
			l_json.put_string (query, "query").do_nothing

			if attached variables as l_vars then
				l_json.put_object (l_vars, "variables").do_nothing
			end

			if attached operation_name as l_op then
				l_json.put_string (l_op, "operationName").do_nothing
			end

			Result := l_json.to_json_string
		ensure
			result_not_empty: not Result.is_empty
			contains_query: Result.has_substring ("query")
		end

invariant
	query_not_empty: not query.is_empty

end

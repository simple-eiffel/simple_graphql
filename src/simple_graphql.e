note
	description: "[
		Facade for GraphQL client operations.
		
		Provides easy-to-use API for querying remote GraphQL endpoints.
		Handles HTTP transport, JSON encoding, and response parsing.
		
		Usage:
			create gql.make ("https://api.example.com/graphql")
			gql.query ("{ users { id name } }")
			if attached gql.last_result as res and then res.is_successful then
				-- process res.data
			end
	]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	SIMPLE_GRAPHQL

create
	make

feature {NONE} -- Initialization

	make (a_endpoint: STRING)
			-- Create GraphQL client for `a_endpoint'.
		require
			endpoint_not_empty: not a_endpoint.is_empty
			valid_url: a_endpoint.has_substring ("://")
		do
			endpoint_url := a_endpoint.twin
			create last_error.make_empty
			create default_headers.make (5)
			create client.make (a_endpoint)
			default_headers.put ("application/json", "Content-Type")
		ensure
			endpoint_set: endpoint_url.same_string (a_endpoint)
			no_error: last_error.is_empty
			no_result: last_result = Void
		end

feature -- Access

	endpoint_url: STRING
			-- GraphQL endpoint URL

	last_result: detachable GQL_RESULT
			-- Result from last query/mutation operation.
			-- Void if no operation executed yet.

	last_error: STRING
			-- Last error message (empty if no error)

feature -- Status Report

	has_error: BOOLEAN
			-- Did the last operation have an error?
		do
			Result := not last_error.is_empty
		ensure
			definition: Result = not last_error.is_empty
		end

feature -- Query Operations

	query (a_query: STRING)
			-- Execute GraphQL query and store result in `last_result'.
		require
			query_not_empty: not a_query.is_empty
		local
			l_gql_query: GQL_QUERY
		do
			last_error.wipe_out
			last_result := Void
			
			create l_gql_query.make (a_query)
			apply_headers
			last_result := client.execute (l_gql_query)
			
			if attached last_result as res and then res.has_errors then
				last_error := res.first_error_message.twin
			end
		ensure
			result_set: last_result /= Void
		end

	query_with_variables (a_query: STRING; a_variables: SIMPLE_JSON_OBJECT)
			-- Execute GraphQL query with variables and store result.
		require
			query_not_empty: not a_query.is_empty
			variables_attached: a_variables /= Void
		local
			l_gql_query: GQL_QUERY
		do
			last_error.wipe_out
			last_result := Void
			
			create l_gql_query.make_with_variables (a_query, a_variables)
			apply_headers
			last_result := client.execute (l_gql_query)
			
			if attached last_result as res and then res.has_errors then
				last_error := res.first_error_message.twin
			end
		ensure
			result_set: last_result /= Void
		end

feature -- Mutation Operations

	mutation (a_mutation: STRING)
			-- Execute GraphQL mutation and store result.
			-- Mutations are executed the same way as queries.
		require
			mutation_not_empty: not a_mutation.is_empty
		do
			query (a_mutation)
		ensure
			result_set: last_result /= Void
		end

feature -- Configuration

	set_header (a_name, a_value: STRING)
			-- Set a default HTTP header for all requests.
			-- Common use: set_header ("Authorization", "Bearer <token>")
		require
			name_not_empty: not a_name.is_empty
			value_not_empty: not a_value.is_empty
		do
			default_headers.force (a_value, a_name)
		ensure
			header_set: attached default_headers.item (a_name) as h and then h.same_string (a_value)
		end

feature {NONE} -- Implementation

	client: GQL_CLIENT
			-- Internal HTTP client for GraphQL operations

	default_headers: HASH_TABLE [STRING, STRING]
			-- Default HTTP headers for all requests

	apply_headers
			-- Apply default headers to client.
		do
			client.clear_headers
			across default_headers as ic loop
				client.add_header (@ic.key, ic)
			end
		end

invariant
	endpoint_not_empty: not endpoint_url.is_empty
	last_error_attached: last_error /= Void
	client_attached: client /= Void
	headers_attached: default_headers /= Void

end
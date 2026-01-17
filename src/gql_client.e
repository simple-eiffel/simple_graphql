note
	description: "[
		Low-level GraphQL HTTP client.

		Handles HTTP transport and JSON encoding/decoding for GraphQL operations.
		Uses simple_http for POST requests to GraphQL endpoints.
	]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	GQL_CLIENT

create
	make

feature {NONE} -- Initialization

	make (a_endpoint: STRING)
			-- Create client for GraphQL endpoint `a_endpoint'.
		require
			endpoint_not_empty: not a_endpoint.is_empty
		do
			endpoint := a_endpoint.twin
			create http.make
			create headers.make (5)
		ensure
			endpoint_set: endpoint.same_string (a_endpoint)
			headers_empty: headers.is_empty
		end

feature -- Access

	endpoint: STRING
			-- GraphQL endpoint URL

feature -- Operations

	execute (a_query: GQL_QUERY): GQL_RESULT
			-- Execute `a_query' and return result.
		require
			query_attached: a_query /= Void
		local
			l_body: STRING
			l_response: SIMPLE_HTTP_RESPONSE
		do
			l_body := build_request_body (a_query)

			-- Set headers
			http.clear_headers
			across headers as ic loop
				http.add_header (@ic.key, ic)
			end
			http.add_header ("Content-Type", "application/json")

			-- Make POST request
			l_response := http.post (endpoint, l_body)

			if not l_response.is_success then
				create Result.make_error ("HTTP error: " + l_response.status.out)
			else
				if attached l_response.body as l_body_str then
					Result := parse_response (l_body_str.to_string_8)
				else
					create Result.make_error ("HTTP error: empty response")
				end
			end
		ensure
			result_attached: Result /= Void
		end

	build_request_body (a_query: GQL_QUERY): STRING
			-- Build JSON request body from `a_query'.
		require
			query_attached: a_query /= Void
		do
			Result := a_query.to_json
		ensure
			result_not_empty: not Result.is_empty
		end

	parse_response (a_json: STRING): GQL_RESULT
			-- Parse JSON response into GQL_RESULT.
		require
			json_not_empty: not a_json.is_empty
		do
			create Result.make (a_json)
		ensure
			result_attached: Result /= Void
		end

feature -- Configuration

	add_header (a_name, a_value: STRING)
			-- Add HTTP header for requests.
		require
			name_not_empty: not a_name.is_empty
			value_not_empty: not a_value.is_empty
		do
			headers.force (a_value, a_name)
		ensure
			header_set: attached headers.item (a_name) as h and then h.same_string (a_value)
		end

	clear_headers
			-- Clear all custom headers.
		do
			headers.wipe_out
		ensure
			headers_empty: headers.is_empty
		end

feature {NONE} -- Implementation

	http: SIMPLE_HTTP
			-- HTTP client for requests

	headers: HASH_TABLE [STRING, STRING]
			-- Custom HTTP headers

invariant
	http_attached: http /= Void
	endpoint_not_empty: not endpoint.is_empty
	headers_attached: headers /= Void

end
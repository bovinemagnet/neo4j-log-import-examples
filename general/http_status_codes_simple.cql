//  A neo4j script to create the various HTTP_STATUS codes
//
//

// Ensure that the status codes are unique
CREATE CONSTRAINT on (http_status:HTTP_STATUS) ASSERT http_status.id IS UNIQUE;

//2xx Success[edit]
//This class of status codes indicates the action requested by the client was received, understood and accepted.[2]

CREATE (http_status:HTTP_STATUS { id:200 })
SET http_status.name = 200,
 		http_status.description = 'OK',
 		http_status.long_description = 'Standard response for successful HTTP requests. The actual response will depend on the request method used. In a GET request, the response will contain an entity corresponding to the requested resource. In a POST request, the response will contain an entity describing or containing the result of the action.'
	;



// 3xx Redirection[edit]
// This class of status code indicates the client must take additional action
// to complete the request. Many of these status codes are used in URL redirection.[2]

//A user agent may carry out the additional action with no user interaction only if the method used in the second request is GET or HEAD. A user agent may automatically redirect a request. A user agent should detect and intervene to prevent cyclical redirects.[19]

CREATE (http_status:HTTP_STATUS { id:301 })
SET http_status.name = 301,
	http_status.description = 'Moved Permanently',
 	http_status.long_description = 'This and all future requests should be directed to the given URI.[21]'
	;

CREATE (http_status:HTTP_STATUS { id:303 })
SET http_status.name = 303,
	http_status.description = 'See Other (since HTTP/1.1)',
	http_status.long_description = 'The response to the request can be found under another URI using the GET method. When received in response to a POST (or PUT/DELETE), the client should presume that the server has received the data and should issue a new GET request to the given URI.[25]'
	;
// 4xx Client errors[edit]
//A 404 error on Wikipedia.
//404 error on Wikipedia
//This class of status code is intended for situations in which the error seems to have been caused by the client. Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation, and whether it is a temporary or permanent condition. These status codes are applicable to any request method. User agents should display any included entity to the user.[32]

CREATE (http_status:HTTP_STATUS { id:400 })
SET http_status.name = 303,
	http_status.description = 'Bad Request
 		http_status.long_description = 'The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, size too large, invalid request message framing, or deceptive request routing).[33]

CREATE (http_status:HTTP_STATUS { id:401 })
SET http_status.name = 401,
	http_status.description = 'Unauthorized',
	http_status.rfc= 7235,
 	http_status.long_description = 'Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided. The response must include a WWW-Authenticate header field containing a challenge applicable to the requested resource. See Basic access authentication and Digest access authentication.[34] 401 semantically means "unauthenticated",[35] i.e. the user does not have the necessary credentials.
Note: Some sites issue HTTP 401 when an IP address is banned from the website (usually the website domain) and that specific address is refused permission to access a website.'

CREATE (http_status:HTTP_STATUS { id:403 })
SET http_status.name = 403,
	http_status.description = 'Forbidden',
 		http_status.long_description = 'The request was valid, but the server is refusing action. The user might not have the necessary permissions for a resource, or may need an account of some sort.'
;

CREATE (http_status:HTTP_STATUS { id:404  })
SET http_status.name = 404,
 		http_status.description = 'Not Found',
 		http_status.long_description = 'The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.'
;

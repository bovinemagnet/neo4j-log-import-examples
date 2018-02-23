//  A neo4j script to create the various HTTP_STATUS codes
//
//

// Ensure that the status codes are unique
CREATE CONSTRAINT on (protocol:Protocol) ASSERT protocol.id IS UNIQUE;

// List derived from https://en.wikipedia.org/wiki/List_of_HTTP_status_codes

// Protocol, ensure that imports to TOUPPER
// maybe I should have a version.
CREATE (protocol:Protocol { id: 'HTTP' })
SET protocol.name = 'http',
		protocol.description = 'Hypertext Transfer Protocol'
;

CREATE (protocol:Protocol { id: 'HTTPS' })
SET protocol.name = 'https',
		protocol.description = 'Hypertext Transfer Protocol Secure'
;

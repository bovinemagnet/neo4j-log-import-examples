// @Author Paul Snow
// Date Created: 24th Feb 2018
// Create unique constraints for use with the MERGE statements below
//
CREATE CONSTRAINT ON (c:Client) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (t:Target) ASSERT t.id IS UNIQUE;
CREATE CONSTRAINT ON (t:Tracker) ASSERT t.id IS UNIQUE;

// Simple example of importing the AWS ALB logs.
//
// I was playing with importing ALB logs into NEO, this is the first cut of me playing, and while it is not very useful
// as a final solution, it proves that data can be imported.
// It has some nice components, like date parsing, and splitting of elements.
//
USING PERIODIC COMMIT 200
LOAD CSV FROM "https://raw.githubusercontent.com/bovinemagnet/neo4j-log-import-examples/master/aws/alb/alb_log_example.txt" AS line

FIELDTERMINATOR ' '
WITH line, SPLIT(line[3], ':') AS CLIENT_IP, SPLIT(line[4], ':') AS TARGET_IP, SPLIT(line[12], ' ') AS TRG_REQ, SPLIT( line[17], '-') AS TRACKER
CREATE (request:Request {id: line[0] + '_' + line[1] + '_' + line[2]})
set request.name = line[0],
	request.type = line[0],
	request.timestamp  = line[1],
	request.utc_ms = apoc.date.parse(line[1],'ms', "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"),
	request.elb  = line[2],
	request.client  = CLIENT_IP[0],
	request.client_port = CLIENT_IP[1],
	request.target = line[4],
	request.target_ip  = TARGET_IP[0],
	request.target_port = TARGET_IP[1],
	request.request_processing_time  = line[5],
	request.target_processing_time  = line[6],
	request.response_processing_time  = line[7],
	request.elb_status_code  = line[8],
	request.target_status_code  = line[9],
	request.received_bytes  = line[10],
	request.sent_bytes  = line[11],
	request.request  = line[12],
	request.request_type = TRG_REQ[0],
	request.request_url = TRG_REQ[1],
	request.request_mode = TRG_REQ[2],
	request.user_agent  = line[13],
	request.ssl_cipher  = line[14],
	request.ssl_protocol  = line[15],
	request.target_group_arn  = line[16],
	request.trace_id  = line[17],
	request.domain_name  = line[18],
	request.chosen_cert_arn = line[19],
	request.matched_rule_priority = line[20],
	request.request_creation_time = line[21],
	request.actions_executed = line[22],
	request.redirect_url = line[23],
	request.error_reason = line[24],
	request.target_port_list = line[25],
	request.target_status_code_list = line[26]


MERGE (client:Client {id: CLIENT_IP[0] })
MERGE (target:Target {id: line[4] })
set target.port = TARGET_IP[1],
    target.ip_address = TARGET_IP[0],
		target.name = TARGET_IP[0]

MERGE (tracker:Tracker {id: TRACKER[2] })
// Create some relationships
CREATE (client)-[:ISSUED]->(request)
CREATE (request)-[:PROCESSED_BY]->(target)
CREATE (client)-[:TRACKED_BY]-> (tracker)
CREATE (tracker)-[:TRACKED_REQUESTS] -> (request)
;

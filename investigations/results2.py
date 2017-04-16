import sys

from pyhive import hive

conn = hive.Connection(host="localhost", port="10000", username="hive")

cur = conn.cursor()

zip_input = sys.argv[1]

cur.execute("SELECT zip_code_reference_ca.zipcode, count(*) FROM zip_code_reference_ca LEFT JOIN t_bridge ON zip_code_reference_ca.zipcode=t_bridge.zipcode WHERE zip = %s;", (zip_input,))
bad_bridges = cur.fetchone()
print "Total Number of Unsafe Bridges in Zip Code", zip_input, ":", bad_bridges[1]
conn.close()



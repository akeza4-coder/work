#import fabric
import datetime
from fabric import Connection
with open('password.txt') as f:
    password = f.read()

connection = Connection(host='127.0.0.1', user='waka', connect_kwargs={'password': password})

time_mod = datetime.datetime.now().strftime("%Y%m%d%H%M%S")

def do_pack():
    connection.run('mkdir -p /home/waka/ALU/Sessions/FabricSession/versions')
    connection.run(f'tar -cvf /home/waka/ALU/Sessions/FabricSession/web_static{time_mod}.tgz /home/waka/ALU/Sessions/FabricSession/alu-AirBnB_clone_v2/web_static/')
    connection.run(f'mv /home/waka/ALU/Sessions/FabricSession/web_static{time_mod}.tgz /home/waka/ALU/Sessions/FabricSession/versions/')
    
do_pack()

# HOME ACTIVITY
# Use fabric, based on the above example, to:
# 1. Install Mysql Server
# 2. Create a database (call it whatever you want)
# 3. Run the .sql dump you created on the last couple of home activities





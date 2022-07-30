import subprocess

cmd = 'yc compute instances list | grep RUNNING'
out = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True)
stdout, stderr = out.communicate()
lines = stdout.splitlines()


count = len(lines)
i = 0

f = open('inventory.json', 'w')
f.write('{' + '\n')

for line in lines:
    i = i + 1

    line = line.replace(' ', '')
    line_split = line.split('|')

    service = line_split[2].replace('reddit-', '')
    host = service + 'server'
    ip = line_split[5]

    str = '"' + service + '":{"hosts":{"' + host + '":{"ansible_host":"' + ip + '"}}}'
    if i != count:
        str = str + ','
    f.write(str + '\n')

f.write('}' + '\n')

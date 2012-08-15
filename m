From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Wed, 15 Aug 2012 01:49:59 -0400
Message-ID: <87ipckwvp4.fsf@gmail.com>
References: <20120814103553.GF23370@arianrhod.panaceas.james.local> <87mx1xxy1y.fsf@gmail.com> <20120814160519.GC12473@artemis.panaceas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40271 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2HOFuE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 01:50:04 -0400
Received: by qcro28 with SMTP id o28so969304qcr.19
        for <linux-input@vger.kernel.org>; Tue, 14 Aug 2012 22:50:04 -0700 (PDT)
In-Reply-To: <20120814103553.GF23370@arianrhod.panaceas.james.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James <james@madingley.org>, Ignacio Casal Quinteiro <nacho.resa@gmail.com>
Cc: linux-input@vger.kernel.org

--=-=-=

After doing some fiddling around myself, I've put together a few tools
and I think I now have the beginnings of an understanding of the report
frame structure. I've attached some notes below. The data packets
appear to be 6 bytes long, consistent with earlier versions of the
protocol.  The first and fifth bytes of the touchpad packet are still
quite mysterious. While they likely have something to do with
multitouch, they both fluctuate even with single touch events. Touchpad
packets can be distinguished from stick packets by examining the byte 5,
which is 0x3f (out of the range of the pressure field) in touchstick
packets.

I've also attached two tools I've developed. ps2-parse.py annotates PS/2
traces produced by the VM with common command names (simply pipe a trace
in to stdin, out comes the annotate trace on stdout). Alps.py is a first
attempt at communicating with the hardware. It currently has the ability
to put playback a trace (say, the attached serio-init.log) and start
dumping frames to stdout. It also has an incomplete version of the
initialization sequence (enter_absolute_mode).

Hopefully I'll find some more time in the next few days to figure out
the last few bits (primarily how multitouch events work). I wouldn't be
sad if someone finished the task for me, however.

Cheers,

- Ben



Touchpad Packet format:
  byte 0: ??? starts with 0x9f, 0x8f, changes
          0x10:  ??
          0x20:  ??
          0x8f:  Always set
          Only 0x10 and 0x20 are set with single-touch events. 0x40 seems to be set with multitouch events
          
  byte 1: X position? (- is left, + is right)
  byte 2: Y position? (- is up, + is down)
  byte 3: button state:
                0x1:  left touchpad
                0x2:  right touchpad
                0x4:  middle touchpad?
                0x8:  Always set?
                0x10: left touchstick
                0x20: right touchstick
                0x40: middle touchstick
                0x80: ???
  byte 4: ???
  byte 5: Pressure (0x00 - 0x3e)
                0x3f: Reporting stick?


Touchstick Packet format:
  byte 0: 0x10:  Y Sign
          0x20:  X Sign
          0x4f:  Always set
  byte 1: X pressure (0 - 0x7f)
  byte 2: Y pressure (0 - 0x7f)
  byte 3: always 0x48
  byte 4: Z pressure (0 - 0x7c)
  byte 5: always 0x3f


  

--=-=-=
Content-Type: text/x-python
Content-Disposition: attachment; filename=alps.py

#!/usr/bin/python3.2

import sys
from glob import glob
from time import sleep
import logging

logging.basicConfig(level=logging.DEBUG)

def find_serio_device():
        for f in glob('/sys/bus/serio/devices/serio*'):
                a = open('%s/description'%f).read()
                if 'i8042 AUX' in a:
                        return f

#dev = find_serio_device()
#logging.info("Found device %s" % dev)
#open('%s/drvctl'%dev, 'w').write('serio_raw')
#sleep(1)

serio_dev = sys.argv[1]
#serio_dev = glob('/dev/serio*')[0]
f = open(serio_dev, 'wb+')

def playback(cmds):
        for dir,data in cmds:
                if dir == 'S':
                        logging.debug('Sent %02x' % data)
                        f.write(bytes([data]))
                elif dir == 'R':
                        a = f.read(1)
                        logging.debug('Recieved %02x' % a[0])
                        if data != a[0]:
                                logging.warn('reply mismatch: expected %02x, saw %02x' % (data, a[0]))
                else:
                        raise RuntimeError("uh oh")

def recv_ack():
        a = b''
        logging.debug('Waiting for ACK')
        while len(a) == 0:
                a = f.read(1)
        print(len(a))
        if a != b'\xfa':
                raise RuntimeError("oops: %s" % str(a))

def reset():
        f.write(b'\xff')
        recv_ack()
        a = f.read(2)
        return a

def get_device_id():
        f.write(b'\xf2')
        recv_ack()
        a = f.read(1)
        return a

def set_resolution(arg):
        f.write(b'\xe8')
        recv_ack()
        f.write(arg)
        recv_ack()

def set_sample_rate(arg):
        f.write(b'\xf3')
        recv_ack()
        f.write(arg)
        recv_ack()

def set_1_1_scaling():
        f.write(b'\xe6')
        recv_ack()

def status_rq():
        f.write(b'\xe9')
        recv_ack()
        a = f.read(3)
        return a

def enable_data_reporting():
        f.write(b'\xf4')
        recv_ack()

def disable_data_reporting():
        f.write(b'\xf5')
        recv_ack()

def enter_absolute_mode():
        reset()
        reset()
        get_device_id()
        set_resolution(b'\x00')
        set_1_1_scaling()
        set_1_1_scaling()
        set_1_1_scaling()
        status_rq()
        set_resolution(b'\x03')
        set_sample_rate(b'\xc8')
        set_sample_rate(b'\x64')
        set_sample_rate(b'\x50')
        get_device_id()
        set_sample_rate(b'\xc8')
        set_sample_rate(b'\xc8')
        set_sample_rate(b'\x50')
        set_resolution(b'\x03')
        enable_data_reporting()

def format_bytes(bytes):
        return map(lambda b: '%02x' % b, bytes)


cmds = []
for l in open('serio-init.log'):
        (dir,data) = (l[0], int(l[1:4], 16))
        cmds.append((dir,data))

disable_data_reporting()
reset()
reset()
playback(cmds)

#enter_absolute_mode()
try:
        while True:
                a = f.read(6)
                print('  '.join(format_bytes(a)))
except KeyboardInterrupt:
        pass

#open('%s/drvctl'%dev, 'w').write('psmouse')


--=-=-=
Content-Type: text/x-python
Content-Disposition: attachment; filename=ps2-parse.py

#!/usr/bin/python

import sys

def get_line():
        l = sys.stdin.readline()
        return (l[0], int(l[1:], 16))

def get_ack():
        (dir,data) = get_line()
        if dir!='R' and data!=0xfa:
                print('! Unknown reply: %02x'%data)

while True:
        notes = ''
        (dir,data) = get_line()
        if dir == 'S':
                get_ack()
                if data == 0xff:
                        notes = 'reset'
                elif data == 0xfe:
                        notes = 'resend'
                elif data == 0xf6:
                        notes = 'set defaults'
                elif data == 0xf5:
                        notes = 'disable reporting'
                elif data == 0xf4:
                        notes = 'enable reporting'
                elif data == 0xf3:
                        dir,data = get_line()
                        notes = 'set_sample_rate: %02x' % data
                        get_ack()
                elif data == 0xf2:
                        _,d = get_line()
                        notes = 'get device id: %02x' % d
                elif data == 0xf0:
                        notes = 'set remote mode'
                elif data == 0xee:
                        notes = 'set wrap mode'
                elif data == 0xec:
                        notes = 'reset wrap mode'
                elif data == 0xeb:
                        notes = 'read data'
                elif data == 0xea:
                        notes = 'set stream mode'
                elif data == 0xe9:
                        _,d1 = get_line()
                        _,d2 = get_line()
                        _,d3 = get_line()
                        notes = 'status request: %02x  resolution=%02x  rate=%02x' % (d1, d2, d3)
                elif data == 0xe8:
                        _,d = get_line()
                        notes = 'set resolution: %02x' % d
                        get_ack()
                elif data == 0xe7:
                        notes = 'set scaling 2:1'
                elif data == 0xe6:
                        notes = 'set scaling 1:1'
                else:
                        notes = 'unknown command'


        print('%s %02x     %s' % (dir, data, notes))


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=serio-init.log
Content-Transfer-Encoding: base64

UyBmZgpSIGZhClIgYWEKUiAwMApTIGZmClIgZmEKUiBhYQpSIDAwClMgZjIKUiBmYQpSIDAwClMg
ZTgKUiBmYQpTIDAwClIgZmEKUyBlNgpSIGZhClMgZTYKUiBmYQpTIGU2ClIgZmEKUyBlOQpSIGZh
ClIgMDAKUiAwMApSIDY0ClMgZTgKUiBmYQpTIDAzClIgZmEKUyBmMwpSIGZhClMgYzgKUiBmYQpT
IGYzClIgZmEKUyA2NApSIGZhClMgZjMKUiBmYQpTIDUwClIgZmEKUyBmMgpSIGZhClIgMDAKUyBm
MwpSIGZhClMgYzgKUiBmYQpTIGYzClIgZmEKUyBjOApSIGZhClMgZjMKUiBmYQpTIDUwClIgZmEK
UyBmMgpSIGZhClIgMDAKUyBmMwpSIGZhClMgNjQKUiBmYQpTIGU4ClIgZmEKUyAwMwpSIGZhClMg
ZjQKUiBmYQpTIGY1ClIgZmEKUyBmZgpSIGZhClIgYWEKUiAwMApTIGU3ClIgZmEKUyBlNwpSIGZh
ClMgZTcKUiBmYQpTIGU5ClIgZmEKUiA3MwpSIDAzClIgMGEKUyBlYQpSIGZhClMgZWMKUiBmYQpT
IGVjClIgZmEKUyBlYwpSIGZhClMgZTkKUiBmYQpSIDg4ClIgMDgKUiAxZApTIGVjClIgZmEKUyBl
OApSIGZhClMgMDEKUiBmYQpTIGU3ClIgZmEKUyBlOApSIGZhClMgMDEKUiBmYQpTIGYzClIgZmEK
UyA2NApSIGZhClMgZTkKUiBmYQpSIGMyClIgYzgKUiA4MApTIGYzClIgZmEKUyA2NApSIGZhClMg
ZjYKUiBmYQpTIGVhClIgZmEKUyBlNwpSIGZhClMgZTcKUiBmYQpTIGU3ClIgZmEKUyBlOQpSIGZh
ClIgNDIKUiAwMgpSIDNjClMgZTYKUiBmYQpTIGU2ClIgZmEKUyBlNgpSIGZhClMgZjMKUiBmYQpT
IGM4ClIgZmEKUyBmMwpSIGZhClMgMTQKUiBmYQpTIGVhClIgZmEKUyBlYwpSIGZhClMgZWMKUiBm
YQpTIGVjClIgZmEKUyBlOQpSIGZhClIgODgKUiAwOApSIDFkClMgZWMKUiBmYQpTIGU4ClIgZmEK
UyAwMQpSIGZhClMgZTcKUiBmYQpTIGU4ClIgZmEKUyAwMQpSIGZhClMgZjMKUiBmYQpTIDY0ClIg
ZmEKUyBmMwpSIGZhClMgNjQKUiBmYQpTIGU3ClIgZmEKUyBlYwpSIGZhClMgZTgKUiBmYQpTIDAx
ClIgZmEKUyBlNwpSIGZhClMgZTgKUiBmYQpTIDAxClIgZmEKUyBmMwpSIGZhClMgMTQKUiBmYQpT
IGU5ClIgZmEKUiBjMgpSIGM0ClIgMDAKUyBmMApSIGZhClMgZTcKUiBmYQpTIGVjClIgZmEKUyBl
OApSIGZhClMgMDEKUiBmYQpTIGU3ClIgZmEKUyBlOApSIGZhClMgMDIKUiBmYQpTIGYzClIgZmEK
UyBjOApSIGZhClMgZTkKUiBmYQpSIGMyClIgZDkKUiAwMApTIGVjClIgZmEKUyBlOApSIGZhClMg
MDEKUiBmYQpTIGU3ClIgZmEKUyBlOApSIGZhClMgMDEKUiBmYQpTIGU4ClIgZmEKUyAwMApSIGZh
ClMgZjAKUiBmYQpTIGYwClIgZmEKUyBlYwpSIGZhClMgZTgKUiBmYQpTIDAxClIgZmEKUyBlNwpS
IGZhClMgZTgKUiBmYQpTIDAxClIgZmEKUyBmMwpSIGZhClMgNjQKUiBmYQpTIGU5ClIgZmEKUiBj
MgpSIGM4ClIgODIKUyBmMwpSIGZhClMgNjQKUiBmYQpTIGU3ClIgZmEKUyBlYQpSIGZhClMgZjMK
UiBmYQpTIDY0ClIgZmEKUyBmNApSIGZhClMgZjUKUiBmYQpTIGZmClIgZmEKUiBhYQpTIGY1ClMg
ZmYKUiBmYQpSIGZhClIgYWEKUiAwMApTIGU3ClIgZmEKUyBlNwpSIGZhClMgZTcKUiBmYQpTIGU5
ClIgZmEKUiA3MwpSIDAzClIgMGEKUyBlYQpSIGZhClMgZWMKUiBmYQpTIGVjClIgZmEKUyBlYwpS
IGZhClMgZTkKUiBmYQpSIDg4ClIgMDgKUiAxZApTIGVjClIgZmEKUyBlOApSIGZhClMgMDEKUiBm
YQpTIGU3ClIgZmEKUyBlOApSIGZhClMgMDEKUiBmYQpTIGYzClIgZmEKUyA2NApSIGZhClMgZTkK
UiBmYQpSIGMyClIgYzgKUiA4MApTIGYzClIgZmEKUyA2NApSIGZhClMgZjYKUiBmYQpTIGVhClIg
ZmEKUyBlNwpSIGZhClMgZTcKUiBmYQpTIGU3ClIgZmEKUyBlOQpSIGZhClIgNDIKUiAwMgpSIDNj
ClMgZTYKUiBmYQpTIGU2ClIgZmEKUyBlNgpSIGZhClMgZjMKUiBmYQpTIGM4ClIgZmEKUyBmMwpS
IGZhClMgMTQKUiBmYQpTIGVhClIgZmEKUyBlYwpSIGZhClMgZWMKUiBmYQpTIGVjClIgZmEKUyBl
OQpSIGZhClIgODgKUiAwOApSIDFkClMgZWMKUiBmYQpTIGU4ClIgZmEKUyAwMQpSIGZhClMgZTcK
UiBmYQpTIGU4ClIgZmEKUyAwMQpSIGZhClMgZjMKUiBmYQpTIDY0ClIgZmEKUyBmMwpSIGZhClMg
NjQKUiBmYQpTIGU3ClIgZmEKUyBlYwpSIGZhClMgZTgKUiBmYQpTIDAxClIgZmEKUyBlNwpSIGZh
ClMgZTgKUiBmYQpTIDAxClIgZmEKUyBmMwpSIGZhClMgMTQKUiBmYQpTIGU5ClIgZmEKUiBjMgpS
IGM0ClIgMDAKUyBmMApSIGZhClMgZTcKUiBmYQpTIGVjClIgZmEKUyBlOApSIGZhClMgMDEKUiBm
YQpTIGU3ClIgZmEKUyBlOApSIGZhClMgMDIKUiBmYQpTIGYzClIgZmEKUyBjOApSIGZhClMgZTkK
UiBmYQpSIGMyClIgZDkKUiAwMApTIGVjClIgZmEKUyBlOApSIGZhClMgMDEKUiBmYQpTIGU3ClIg
ZmEKUyBlOApSIGZhClMgMDEKUiBmYQpTIGU4ClIgZmEKUyAwMApSIGZhClMgZjAKUiBmYQpTIGYw
ClIgZmEKUyBlYwpSIGZhClMgZTgKUiBmYQpTIDAxClIgZmEKUyBlNwpSIGZhClMgZTgKUiBmYQpT
IDAxClIgZmEKUyBmMwpSIGZhClMgNjQKUiBmYQpTIGU5ClIgZmEKUiBjMgpSIGM4ClIgODIKUyBm
MwpSIGZhClMgNjQKUiBmYQpTIGU3ClIgZmEKUyBlYQpSIGZhClMgZjMKUiBmYQpTIDY0ClIgZmEK
UyBmNApSIGZhClMgZjUKUiBmYQpTIGYyClIgZmEKUiAwMApTIGVhClIgZmEKUyBlYwpSIGZhClMg
ZWMKUiBmYQpTIGVjClIgZmEKUyBlOQpSIGZhClIgODgKUiAwOApSIDFkClMgZWMKUiBmYQpTIGU4
ClIgZmEKUyAwMQpSIGZhClMgZTcKUiBmYQpTIGU4ClIgZmEKUyAwMQpSIGZhClMgZjMKUiBmYQpT
IDI4ClIgZmEKUyBlOQpSIGZhClIgYzIKUiBjNQpSIDY5ClMgZjMKUiBmYQpTIDNjClIgZmEKUyBm
MwpSIGZhClMgYzgKUiBmYQpTIGVhClIgZmEKUyBmNApSIGZhCg==
--=-=-=--

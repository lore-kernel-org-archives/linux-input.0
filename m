From: Keith Lawson <lawsonk@libertas-tech.com>
Subject: Lenovo L430 Elantech touchpad problems
Date: Sat, 03 Nov 2012 17:02:17 -0400
Message-ID: <bda3ec1b3d5c6879ecdc6dda88f55eb0@www.nowhere.ca>
Reply-To: <lawsonk@libertas-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from client-208-92-234-63.sevenl.net ([208.92.234.63]:36028 "EHLO
	can.libertas-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab2KCVCS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Nov 2012 17:02:18 -0400
Received: from vegas.nowhere.ca (198-84-197-69.cpe.teksavvy.com [198.84.197.69])
	(authenticated bits=0)
	by can.libertas-tech.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id qA3L2HOg001403
	for <linux-input@vger.kernel.org>; Sat, 3 Nov 2012 17:02:17 -0400
Received: from www-data by vegas.nowhere.ca with local (Exim 4.72)
	(envelope-from <lawsonk@libertas-tech.com>)
	id 1TUkrB-0006tr-FI
	for linux-input@vger.kernel.org; Sat, 03 Nov 2012 17:02:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm running Debian 6.0.6 (Squeeze) on a Lenovo L430 and having issues=20
with the trackpad and trackpoint. Originally I was running 3.0.4 built=20
from source and the track pad was detected as a PS2 mouse. The pad=20
worked but I wasn't able to control the advance track pad functionality=
,=20
specifically I want to disable the "tap to click".

I tried 3.6.3 with no luck, just upgraded to 3.6.5 today and I'm still=20
having the same problem.

psmouse recognizes the device as an Elantech touchpad and X sees the=20
device:

modprobe psmouse log:

Nov  3 20:37:29 l430kl kernel: [  890.307107] psmouse serio1: elantech:=
=20
assuming hardware version 3 (with firmware version 0x350f02)
Nov  3 20:37:29 l430kl kernel: [  890.320581] psmouse serio1: elantech:=
=20
Synaptics capabilities query result 0xb9, 0x15, 0x0c.
Nov  3 20:37:29 l430kl kernel: [  890.392129] input: ETPS/2 Elantech=20
Touchpad as /devices/platform/i8042/serio1/input/input15

from /proc/bus/input/devices:

I: Bus=3D0011 Vendor=3D0002 Product=3D000e Version=3D0000
N: Name=3D"ETPS/2 Elantech Touchpad"
P: Phys=3Disa0060/serio1/input0
S: Sysfs=3D/devices/platform/i8042/serio1/input/input15
U: Uniq=3D
H: Handlers=3Dmouse0 event5
B: PROP=3D1
B: EV=3Db
B: KEY=3D6420 0 30000 0 0 0 0 0 0 0 0
B: ABS=3D2608000 11000003

$ xinput list
=E2=8E=A1 Virtual core pointer                          id=3D2    [mast=
er pointer=20
(3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                id=3D4 =
   [slave  pointer=20
(2)]
=E2=8E=9C   =E2=86=B3 ETPS/2 Elantech Touchpad                  id=3D10=
   [slave  pointer=20
(2)]
=E2=8E=A3 Virtual core keyboard                         id=3D3    [mast=
er=20
keyboard (2)]
     =E2=86=B3 Virtual core XTEST keyboard               id=3D5    [sla=
ve =20
keyboard (3)]
     =E2=86=B3 Power Button                              id=3D6    [sla=
ve =20
keyboard (3)]
     =E2=86=B3 Video Bus                                 id=3D7    [sla=
ve =20
keyboard (3)]
     =E2=86=B3 Sleep Button                              id=3D8    [sla=
ve =20
keyboard (3)]
     =E2=86=B3 AT Translated Set 2 keyboard              id=3D9    [sla=
ve =20
keyboard (3)]
     =E2=86=B3 ThinkPad Extra Buttons                    id=3D11   [sla=
ve =20
keyboard (3)]
$

The track pad functions now and "xinput list-props" sees the touchpad=20
settings but now the touchpoint (eraser head) and 3 mouse buttons above=
=20
the track pad don't function. Moving the eraser head or clicking on the=
=20
3 mouse buttons above the touchpad produce the following errors in=20
messages over and over:


Nov  3 20:42:20 l430kl kernel: [ 1180.843198] psmouse serio1: Touchpad=20
at isa0060/serio1/input0 lost sync at byte 6
Nov  3 20:42:20 l430kl kernel: [ 1180.884365] psmouse serio1: Touchpad=20
at isa0060/serio1/input0 lost sync at byte 6
Nov  3 20:42:20 l430kl kernel: [ 1180.898743] psmouse serio1: Touchpad=20
at isa0060/serio1/input0 lost sync at byte 6
Nov  3 20:42:20 l430kl kernel: [ 1180.942540] psmouse serio1: Touchpad=20
at isa0060/serio1/input0 lost sync at byte 6
Nov  3 20:42:20 l430kl kernel: [ 1180.956503] psmouse serio1: Touchpad=20
at isa0060/serio1/input0 lost sync at byte 6
Nov  3 20:42:20 l430kl kernel: [ 1180.956506] psmouse serio1: issuing=20
reconnect request

Any help would be appreciated. I see lots of Ubuntu bugs about these=20
trackpads freezing after suspend/resume and read a recent thread on thi=
s=20
mailing list from Nicola Alessi but those seem to be different issues.

Thanks,

Keith

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

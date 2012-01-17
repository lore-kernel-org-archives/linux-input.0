From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: fftest: Upload effects[0]: Function not implemented
Date: Tue, 17 Jan 2012 13:44:34 +0530
Message-ID: <CAM1yFZ8A8oHhZ9m7=69mekAPZQhpaSvKk8bVqZiDTtCeYLAhGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:65048 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751939Ab2AQIOe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jan 2012 03:14:34 -0500
Received: by obcva7 with SMTP id va7so5518963obc.19
        for <linux-input@vger.kernel.org>; Tue, 17 Jan 2012 00:14:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Greetz,

The wheel is Logitech driving force DFGT.
The platform:

linux-dopx:/home/anisha/ # cat /etc/issue && uname -a=A0Welcome to
openSUSE 11.3 "Teal" - Kernel \r (\l).Linux linux-dopx
2.6.34-12-desktop #1 SMP PREEMPT 2010-06-29 02:39:08 +0200 x86_64
x86_64 x86_64 GNU/Linux


linux-dopx:/home/anisha/ # fftest /dev/input/event4
=46orce feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event4 opened
Axes query:
Effects:
Number of simultaneous effects: 0
Upload effects[0]: Function not implemented
Upload effects[1]: Function not implemented
Upload effects[2]: Function not implemented
Upload effects[3]: Function not implemented
Upload effects[4]: Function not implemented
Upload effects[5]: Function not implemented
Enter effect number, -1 to exit

# cat /proc/bus/input/devices
shows:
I: Bus=3D0003 Vendor=3D046d Product=3Dc29a Version=3D0111
N: Name=3D"Driving Force GT"
P: Phys=3Dusb-0000:00:1d.3-1/input0
S: Sysfs=3D/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/input/inpu=
t7
U: Uniq=3D
H: Handlers=3Devent4 js0
B: EV=3D1b
B: KEY=3D1f0000 0 0 0 0 0 0 ffff00000000 0 0 0 0
B: ABS=3D30007
B: MSC=3D10

How to counter this? No, I am not running any game. I just wanted to
apply these effects to my wheel.
Please help.

-Anisha
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

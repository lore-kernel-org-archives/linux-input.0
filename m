From: Vitaliy Fust <aslok.zp@gmail.com>
Subject: Force Feedback on Genius Wheel 3 MT not works =(
Date: Sun, 5 Jun 2011 16:07:49 +0300
Message-ID: <BANLkTingz2pCjx52DpiK-aSSD=1K6BinDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59237 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015Ab1FENHu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Jun 2011 09:07:50 -0400
Received: by bwz15 with SMTP id 15so2718066bwz.19
        for <linux-input@vger.kernel.org>; Sun, 05 Jun 2011 06:07:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have Genius Wheel 3 MT with force feedback, but ff dont working for
me :( This problem in kernel settings, or with drivers, or with my
configs?
I have this output:

[aslok@3r]2011.06.05-16:00:23:~$ showwellcome
Description: Ubuntu 11.04
Kernel: 2.6.38-9-generic

[aslok@3r]2011.06.05-15:59:29:~$ lsusb | grep Rock
Bus 006 Device 004: ID 0583:b003 Padix Co., Ltd (Rockfire)

[aslok@3r]2011.06.05-15:59:48:~$ lsmod | egrep '^(joy|if|usbh)'
iforce                 23111  0
joydev                 17606  0
usbhid                 46956  0

[aslok@3r]2011.06.05-15:59:59:~$ lsf
/dev/input/by-id/usb-0583_Vibration_12-Button_USB_Wheel-event-joystick
lrwxrwxrwx 1 root root 9 2011-05-29 01:31
/dev/input/by-id/usb-0583_Vibration_12-Button_USB_Wheel-event-joystick
-> ../event9

[aslok@3r]2011.06.05-16:01:15:~$ fftest /dev/input/event9
Force feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event9 opened
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
0
Now Playing: Sine vibration
Enter effect number, -1 to exit
1
Now Playing: Constant Force
Enter effect number, -1 to exit
2
Now Playing: Spring Condition
Enter effect number, -1 to exit
3
Now Playing: Damping Condition
Enter effect number, -1 to exit
4
Now Playing: Strong Rumble
Enter effect number, -1 to exit
5
Now Playing: Weak Rumble
Enter effect number, -1 to exit
-1
No such effect

[aslok@3r]2011.06.05-16:01:37:~$

Help me, please!

---------------------------------------
Vitaliy Fust

From: Roel Kluin <12o3l@tiscali.nl>
Subject: No mouse, Power Button (FF) as /class/input/input1
Date: Fri, 18 Apr 2008 18:11:57 +0200
Message-ID: <4808C84D.4020009@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:58446 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYDRQMA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2008 12:12:00 -0400
Received: from [82.171.187.43] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1JmtBv-00006p-4c
	for <linux-input@vger.kernel.org>; Fri, 18 Apr 2008 18:11:59 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a PS/2 mouse:

dmesg | grep "^input:"
input: AT Translated Set 2 keyboard as /class/input/input0
input: PS2++ Logitech Wheel Mouse as /class/input/input1
input: Power Button (FF) as /class/input/input2
input: Power Button (CM) as /class/input/input3

About once a month, however, this mouse is not working after boot.

* cat /dev/input/mice does not print when moving mouse
* /etc/rc.d/rc.udev restart; /etc/rc.d/rc.gpm restart does not give a mouse

However, usually after reboot the mouse is working again. I have had this problem
for a few years now, not sure when it started.

when comparing dmesg:
diff -u dmesg_no_mouse dmesg_mouse | grep "^[-+]\(input:\|[-+][-+]\)"
--- dmesg_no_mouse      2008-04-18 10:17:58.000000000 +0200
+++ dmesg_mouse         2008-04-18 10:59:30.000000000 +0200
+input: PS2++ Logitech Wheel Mouse as /class/input/input1
+input: Power Button (FF) as /class/input/input2
-input: Power Button (FF) as /class/input/input1
-input: Power Button (CM) as /class/input/input2
+input: Power Button (CM) as /class/input/input3

No mouse and Power Button (FF) as /class/input/input1 also occurred in dmesgs on
2007-09-15 12:35
2007-11-23 10:25
2007-12-01 18:34
2008-04-18 10:17

and Mouse as /class/input/input1 with mouse functioning in dmesgs on
2007-09-15 12:37
2007-11-23 10:28
2007-11-23 10:46
2008-04-18 10:59

Any ideas what goes wrong?

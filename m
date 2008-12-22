From: Roel Kluin <roel.kluin@gmail.com>
Subject: frequent hangs
Date: Mon, 22 Dec 2008 14:17:08 +0100
Message-ID: <494F9354.2070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:10183 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbYLVNRJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Dec 2008 08:17:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

I am experiencing frequent (twice in 4 boots) hangs on my PC, just after
entering X. Sometimes there is no problem and the PC starts up fine and keeps
working normally. It seems to happen during boot only.

Hangs are: mouse first responds wildly, then stops working altogether as well as
the keyboard.

I compared diffs of /var/log/Xorg.0.log.old and /var/log/Xorg.0.log twice after
hangs and noted these extra lines (with +) both times when boot was OK:

 enable montype: 1
+enable montype: 1
+(II) 3rd Button detected: disabling emulate3Button

I have a Logitech PS/2 wheel mouse. As normally I found in my dmesg:

mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PS2++ Logitech Wheel Mouse as /class/input/input1
input: Power Button (FF) as /class/input/input2
input: Power Button (CM) as /class/input/input3

I compile a Linus git-pulled kernel with a .config that I do not change often
and normally works. It seems that kernel changes somewhere between May and
December 2008 caused this, I didn't compile new kernels a lot in this period.

After reboot I noted (suspected to be related):
Sound signals
processor Clock settings altered



A possibly related issue is that sometimes (about once every month) my mouse
doesn't work when entering X. (I have sent an email previously for this).

cat /dev/input/mice doesn't give strange characters when moving my mouse

I stored dmesg when there was trouble:

twice dmesg contained:
psmouse.c: Failed to enable mouse on isa0060/serio1

4 other times missing was:
input: PS2++ Logitech Wheel Mouse as /class/input/input1

and instead:
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: Power Button (FF) as /class/input/input1
input: Power Button (CM) as /class/input/input2

(in earlier dmesgs "/class" was "/devices/virtual".
or /devices/platform/i8042/serio[10]/)

Roel

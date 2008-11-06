From: "Zoltan Devai" <zdevai@gmail.com>
Subject: Fwd: [PATCH] Fix PIT lockup on some chipsets when using the PC-Speaker
Date: Thu, 6 Nov 2008 23:27:30 +0100
Message-ID: <5b7270f40811061427k4edecbbduf8edfe026baa9764@mail.gmail.com>
References: <5b7270f40811021527j26c22d2ana3b5b9c437173989@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:23874 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYKFW1d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Nov 2008 17:27:33 -0500
Received: by ey-out-2122.google.com with SMTP id 6so401413eyi.37
        for <linux-input@vger.kernel.org>; Thu, 06 Nov 2008 14:27:31 -0800 (PST)
In-Reply-To: <5b7270f40811021527j26c22d2ana3b5b9c437173989@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Is this the right place for this patch ?

The ALSA version is already in mainline.

Zoltan


---------- Forwarded message ----------
From: Zoltan Devai <zdevai@gmail.com>
Date: 2008/11/3
Subject: [PATCH] Fix PIT lockup on some chipsets when using the PC-Speaker
To: linux-input@vger.kernel.org


Hi,

There've been reports [1] about the sysem bell causing a hard lockup.
My machine was affected as well: Any speaker output hung the machine
completely, nothing in the logs, no magic sysrq, etc., looked like a
hardware problem.
Had a closer look on the issue, and it turned out that the pcspkr module is
responsible. The cause is the bad setup of Timer 2 in the i8253 controller,
which probably hangs the whole PIT controller.

Intel datasheets [2] state that the timer registers are in an undefined
state after reset and they need to be programmed before enabling the
timer. (And enabling without programming the frequency first doesn't
make sense anyway).

I don't know which chipsets are affected (if not all), it also depends on
the BIOS whether it initializes the timer (e.g. to beep when you start the
machine).

The following patch solved the issue on my ICH6 notebook, couldn't
test it with any others, but should be safe to apply.

I'll also send a patch to the ALSA people for the snd-pcsp version.

Cheers,
Zoltan

[1]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/146151
https://bugs.launchpad.net/ubuntu/+bug/270790
http://ubuntuforums.org/showthread.php?t=227693
http://bugs.gentoo.org/show_bug.cgi?id=222583
https://bugzilla.redhat.com/show_bug.cgi?id=454225

[2]
http://www.intel.com/assets/pdf/datasheet/252516.pdf
http://www.intel.com/assets/pdf/datasheet/301473.pdf
http://www.intel.com/design/chipsets/datashts/29065503.pdf

------------------

Fix PIT lockup on some chipsets when using the PC-Speaker.

Signed-off-by: Zoltan Devai <zdevai@gmail.com>

--- a/drivers/input/misc/pcspkr.c
+++ b/drivers/input/misc/pcspkr.c
@@ -52,13 +52,13 @@
       spin_lock_irqsave(&i8253_lock, flags);

       if (count) {
-               /* enable counter 2 */
-               outb_p(inb_p(0x61) | 3, 0x61);
               /* set command for counter 2, 2 byte write */
               outb_p(0xB6, 0x43);
               /* select desired HZ */
               outb_p(count & 0xff, 0x42);
               outb((count >> 8) & 0xff, 0x42);
+               /* enable counter 2 */
+               outb_p(inb_p(0x61) | 3, 0x61);
       } else {
               /* disable counter 2 */
               outb(inb_p(0x61) & 0xFC, 0x61);

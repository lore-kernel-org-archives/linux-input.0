From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: calibrating a hid device
Date: Mon, 24 May 2010 16:11:12 -0400
Message-ID: <4BFADD60.7020901@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:54458 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0EXULx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 16:11:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've written a calibration tool for my touch screen that works well from user
space (just sends a few commands over usb telling the digitizer to recalibrate
and reset itself).  I've been running that with the ntrig and usbhid modules
unloaded.

Now I'm trying to translate that to something in the kernel which I can run just
by poking a sysfs node.  However as I sort of expected, it doesn't actually work
quite right.  I've been seeing something like this:

- From user space:
  S Ii:3:002:2 -115:2 94 <
  C Ii:3:002:2 0:2 94 = 033fbc07 0000a014 f012ce01 68010100 000c0701 00000000
00fa0096 00000b00

kernel space:
  S Ii:3:002:2 -115:2 94 <
  C Ii:3:002:2 -2:2 0


What sort of calls should I wrap the calibration code with?

Also, the process seems to involve telling the digitizer to go off and run
calibration, and then interrupting it after a while.  I've been using a number
of microseconds dumped to the sysfs node for that.  Is there any harm in using
"msleep(val);"?


Once I get this sorted out, I'll clean up the code a bit and send in some
patches (and documentation for this and filtering).

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkv63V0ACgkQwuRiAT9o609I3gCgg9ZKGqwWFsZQa2wyX270JlGq
qj4An1w776oL0CiLEZPnKFwvIT0PDKWV
=dtIw
-----END PGP SIGNATURE-----

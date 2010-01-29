From: Matthew Wilcox <matthew@wil.cx>
Subject: Securing non-root X input
Date: Fri, 29 Jan 2010 16:24:38 -0700
Message-ID: <20100129232437.GB6992@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:55503 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab0A2XYk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 18:24:40 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>, peter.hutterer@who-t.net
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, xorg@freedesktop.org


Dave Airlie commented at LCA that the last obstacle to running X as a
regular user (instead of setuid) was getting revoke() to work on evdev
file descriptors so that the previous user can't snoop the keypresses /
mouse movements / etc of the current user.

I respectfully disagree that this is the correct approach; making sure
that legitimate apps behave correctly in the presence of revoke()
is a significant hurdle, and one I'm not sure we want to undertake.
It's also a pain in the arse to implement in the kernel, and may take
an unacceptable amount of time or space to work.

Another approach we discussed was to implement O_EXCL without O_CREAT.
ie fail the open if another process has the device open.  This turns
out to be a bad idea as there are legitimate use cases (eg debugging)
where we want it to work even if another process has the device open.

We also discussed using leases to ensure that a given task was the
exclusive opener of a device, but the current lease code only works on
regular files, and see the previous paragraph for cases where we don't
want that behaviour anyway.

This tiny patch allows the X server to ask how many times the device has
been opened.  If it's more than one, the X server can ask the user what
they want to do about it.  For bonus points, the X server can also run
programs like lsof or fuser to find out which other processes have the
device open, and tell the user that information too.  At that point,
the sysadmin can call in the ICBM strike on the offending user.

Does this approach work for everyone?

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 258c639..c0e5ecf 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -567,6 +567,9 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 
 		return input_set_keycode(dev, t, v);
 
+	case EVIOCGOPEN:
+		return evdev->open;
+
 	case EVIOCRMFF:
 		return input_ff_erase(dev, (int)(unsigned long) p, file);
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 7be8a65..702ba54 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -62,6 +62,7 @@ struct input_absinfo {
 #define EVIOCSREP		_IOW('E', 0x03, int[2])			/* set repeat settings */
 #define EVIOCGKEYCODE		_IOR('E', 0x04, int[2])			/* get keycode */
 #define EVIOCSKEYCODE		_IOW('E', 0x04, int[2])			/* set keycode */
+#define EVIOCGOPEN		_IO('E', 0x05)				/* return open count */
 
 #define EVIOCGNAME(len)		_IOC(_IOC_READ, 'E', 0x06, len)		/* get device name */
 #define EVIOCGPHYS(len)		_IOC(_IOC_READ, 'E', 0x07, len)		/* get physical location */

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

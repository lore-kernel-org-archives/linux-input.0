From: Alan Ott <alan@signal11.us>
Subject: [PATCH v4 0/1] HID: Report Descriptor in Sysfs
Date: Sun, 23 Jan 2011 22:50:17 -0500
Message-ID: <1295841018-8561-1-git-send-email-alan@signal11.us>
References: <20110123225935.GB12488@kroah.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:34900 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015Ab1AXDuf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Jan 2011 22:50:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 0E1101CCABB7
	for <linux-input@vger.kernel.org>; Sun, 23 Jan 2011 22:50:35 -0500 (EST)
In-Reply-To: <20110123225935.GB12488@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>

This is version 4 of the patch, with Documentation as requested by Greg KH,
a version number fixed in the documentation, and sent to the right people
this time. (Sorry for the noise; I forgot to re-run get_maintainer.pl after
I added the docs for v3).

Original email follows:

So I'd like to have access to the HID report descriptor in a sysfs entry, so
I can read it without opening the device.  hid-core seemed like the place to
put it.

Using the /sys/class links, for hidraw devices, this puts a new file,
report_descriptor in the directory:
	/sys/class/hidraw/hidraw0/device/

For my USB device (for example), the new file is in:
	/sys/bus/usb/devices/1-5.3:1.0/0003:046D:C216.0001/

For my Bluetooth device, the new file is in:
	/sys/class/bluetooth/hci0/hci0:11/0005:054C:0268.0002/

I'm not super confident that these file locations are the best place, but I
made a best guess so that it could be discussed.  The current location is
where the hid-core stuff lives.  Is there a reason these directories are
named bus:vendor:product:id (instead of hid-core or something similar)?  Is
there a better way to do this?

Alan.

Alan Ott (1):
  hid: Add HID Report Descriptor to sysfs.

 Documentation/ABI/testing/sysfs-driver-hid |   10 ++++++++
 drivers/hid/hid-core.c                     |   33 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid



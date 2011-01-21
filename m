From: Alan Ott <alan@signal11.us>
Subject: [PATCH 0/1] HID: Report Descriptor in Sysfs
Date: Fri, 21 Jan 2011 01:19:44 -0500
Message-ID: <1295590785-7101-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:37674 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1AUGTv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 01:19:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id D66371CCABA9
	for <linux-input@vger.kernel.org>; Fri, 21 Jan 2011 01:19:50 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>

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

 drivers/hid/hid-core.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)



From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC v2 0/1] User-space HID I/O Driver
Date: Mon, 26 Mar 2012 22:20:08 +0200
Message-ID: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42139 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab2CZUUe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 16:20:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, anderson.lizardo@openbossa.org, marcel@holtmann.org, David Herrmann <dh.herrmann@googlemail.com>

Hi

This is the second revision of the UHID driver. It basically allows to register
hid_ll_drivers in user-space. This is needed to implement Bluetooth HoG (HID
over GATT) as discussed earlier.

Changes:
 - Improved documentation
 - Added example which emulates a 3-button mouse with wheel in user-space
 - Fixed some remaining bugs

I didn't change any major parts. I checked that writev/readv work correctly and
I documented how to use it in ./Documentation/hid/uhid.txt.

For a full example please see ./samples/uhid/uhid-example.c.

While developing it I also considered moving HIDP to user-space. If we do BT-HoG
in user-space, it should be easier to also move HIDP to user-space. The current
in-kernel HIDP is buggy, anyway.

Still open points:
 - How do I get a proper "parent" pointer for uhid->hid->dev.parent? I could use
   the uhid misc device as parent or is there some device-struct inside "struct
   file"?
 - Should user-space be able to provide "uniq" and "phys" names for HID-devices?
 - uhid_event is quite big (>4KB) which makes uhid_device really big (~70KB).
   Should I allocate the ring-buffer dynamically to avoid this?
 - Should I provide the quirks field to user-space? Probably as part of
   UHID_START?
 - Could someone review x32 COMPAT stuff? I tried to align all the public
   structures correctly so I could even remove the __packed attribute. Anyway, I
   thought keeping it is probably better for future extensions.

I spent some time on the locks and they seem all fine. I couldn't find any
races.

Jiri, Marcel, could you review the design and tell me what you think?

A short notice about the protocol:
User-space is allowed to send only as much data as is needed for the event. That
is, when sending the UHID_DESTROY event (which has no payload) it would be
actually enough to only send a __u32 field (ev->type) with write().
This is not to speed up the write()s or read()s but rather to allow extending
the uhid_event structure in the future. We can actually add arbitrary extra
event-types and still keep ABI compatibility. Therefore, I thought of adding an
"uhid_version" field to UHID_CREATE so user-space can define what UHID protocol
it is using.

Regards
David

David Herrmann (1):
  HID: User-space I/O driver support for HID subsystem

 Documentation/hid/uhid.txt  |  152 ++++++++++++++
 drivers/hid/Kconfig         |   21 ++
 drivers/hid/Makefile        |    2 +-
 drivers/hid/uhid.c          |  473 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild        |    1 +
 include/linux/uhid.h        |   84 ++++++++
 samples/uhid/Makefile       |   10 +
 samples/uhid/uhid-example.c |  381 ++++++++++++++++++++++++++++++++++
 8 files changed, 1123 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hid/uhid.txt
 create mode 100644 drivers/hid/uhid.c
 create mode 100644 include/linux/uhid.h
 create mode 100644 samples/uhid/Makefile
 create mode 100644 samples/uhid/uhid-example.c

-- 
1.7.9.4


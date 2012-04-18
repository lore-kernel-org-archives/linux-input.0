From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/5] hid: Introduce device groups
Date: Thu, 19 Apr 2012 00:00:52 +0200
Message-ID: <1334786457-2124-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:57181 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab2DRV5x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 17:57:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi all,

Here is the proposed patchset for extending the device-driver matching
mechanism. I believe the comments from Jiri and Benjamin have all been
addressed. Auto-loading from boot as well as hotplugging seems to work
well, and the bluetooth stack seems unaffected, at least I can still
run the magic trackpad. I don't have any report-fixup devices to test,
but I believe those should work too. Benjamin?

The early parsing of reports has been moved as close to the actual
device add as possible, leaving all special handling, such as ignored
devices, still in effect. Also, since only devices not listed in the
special drivers array are affected, report fixups should still apply.
The rest of the devices are parsed and placed into a device group, of
which there is currently only one (apart from the default). This
handling is done automatically for all the bus drivers, BT, HID, and
soon I2C.

Based on the extended modalias of the device id, there can now be one
generic hid driver per device group, and udev will load the
appropriate one. Currently we only have usbhid and hid-multitouch, but
more groups could likely be added to good advantage. The group
assignment logic will not take up much space and will allow the
generic event code to be broken down into smaller functional groups.

The patches apply to 3.4-rc3.

Enjoy,
Henrik

Henrik Rydberg (5):
  hid: Add device group to modalias
  hid: Parse the device before adding it
  hid-multitouch: Prepare driver for device groups
  hid-multitouch: Switch to device groups
  hid-multitouch: Remove remnant quirk handling

 drivers/hid/hid-core.c          |  112 ++++++++++--------------------
 drivers/hid/hid-input.c         |   11 ---
 drivers/hid/hid-multitouch.c    |  146 ++++++++++++++++++++-------------------
 include/linux/hid.h             |    8 ++-
 include/linux/mod_devicetable.h |    2 +-
 scripts/mod/file2alias.c        |    3 +-
 6 files changed, 123 insertions(+), 159 deletions(-)

-- 
1.7.10


From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 00/15] HID: hid-lg, hid-lg4ff: Mostly cleanup patches
Date: Wed,  8 Apr 2015 22:56:38 +0200
Message-ID: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devoid-pointer.net ([31.31.77.140]:32985 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbDHU5Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Hello everyone,

this is a mostly boring series that deals with a few inconsistencies in=
 the
code that have accumulated over the years. Besides that it patches up a=
 handful
of problems such a return values not being checked etc.

The only significant change comes in patches 8 through 10 which introdu=
ce a
spinlock to handle concurrent access to the HID report that is used by =
the
driver to send data to the wheel. I would appreciate some comments on t=
his one,
particularly on the way it handles deinitialization. Patches 8 and 9 co=
ntain
the necessary prep work, patch 10 adds the spinlocking.

v2:
  - Split previous patch 7 into three smaller patches
  - Split the long line of text in patch 5 (now patch 6)
  - Add another cleanup patch that removes unnecessary casts from void =
*

Michal Mal=C3=BD (15):
  HID: hid-lg4ff: (Cleanup) Remove double underscore prefix from numeri=
c
    types.
  HID: hid-lg4ff: (Cleanup) Remove "hid_" prefix from some functions'
    names.
  HID: hid-lg4ff: (Cleanup) Replace DEVICE_ATTR_RW with DEVICE_ATTR to
    have all internal functions prefixed with "lg4ff_"
  HID: hid-lg4ff: (Cleanup) Remove unused variable from the
    "lg4ff_device_entry" struct.
  HID: hid-lg4ff: (Cleanup) Explicit casts from void * are not necessar=
y
  HID: hid-lg4ff: Update a warning message for a case where device is
    incorrectly flagged to be handled by hid-lg4ff in hid-lg.
  HID: hid-lg: Check return values from lg[N]ff_init()
  HID: hid-lg4ff: Make lg4ff_wheel_data a separate structure stored
    within     lg4ff_device_entry. Adjust the initialization process
    accordingly.
  HID: hid-lg4ff: Stop the hid device from lg4ff.
  HID: hid-lg4ff: Protect concurrent access to output HID report with  =
=20
     a spinlock
  HID: hid-lg4ff: Store pointer to the output HID report struct in the
    device entry struct.
  HID: hid-lg4ff: Constify those members of lg4ff_device_entry struct
    whose value is not supposed to change.
  HID: hid-lg4ff: Allow the driver to continue without sysfs interface.
  HID: hid-lg4ff: Update respective sysfs interface documentation
  HID: hid-lg: Only one of LG_FF flags can be set for a given device.

 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |   8 +-
 drivers/hid/hid-lg.c                               |  21 +-
 drivers/hid/hid-lg4ff.c                            | 458 +++++++++++++=
+-------
 drivers/hid/hid-lg4ff.h                            |   4 +-
 4 files changed, 318 insertions(+), 173 deletions(-)

--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

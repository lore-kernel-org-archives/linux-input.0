From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 00/12] HID: hid-lg, hid-lg4ff: Mostly cleanup patches
Date: Sat, 21 Mar 2015 12:47:30 +0100
Message-ID: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devoid-pointer.net ([31.31.77.140]:59543 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbbCULsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 07:48:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Hello everyone,

this is a mostly boring series that deals with a few inconsistencies in=
 the
code that have accumulated over the years. Besides that it patches up a=
 handful
of problems such a return values not being checked etc.

The only significant change comes in patch 0007 which introduces a spin=
lock to
handle concurrent access to the HID report that is used by the driver t=
o send
data to the wheel. I would appreciate some comments on this one, partic=
ularly
on the way it handles deinitialization.

Michal Mal=C3=BD (12):
  HID: hid-lg4ff: (Cleanup) Remove double underscore prefix from numeri=
c
    types.
  HID: hid-lg4ff: (Cleanup) Remove "hid_" prefix from some functions
    names.
  HID: hid-lg4ff: (Cleanup) Replace DEVICE_ATTR_RW with DEVICE_ATTR to
    have all internal functions prefixed with "lg4ff_"
  HID: hid-lg4ff: (Cleanup) Remove unused variable from the
    "lg4ff_device_entry" struct.
  HID: hid-lg4ff: Update a warning message for a case where device is
    incorrectly flagged to be handled by hid-lg4ff in hid-lg.
  HID: hid-lg: Check return values from lg[N]ff_init()
  HID: hid-lg4ff: Protect concurrent access to the output HID report
    values with a spinlock.
  HID: hid-lg4ff: Store pointer to the output HID report struct in the
    device entry struct.
  HID: hid-lg4ff: Constify those members of lg4ff_device_entry struct
    whose value is not supposed to change.
  HID: hid-lg4ff: Allow the driver to continue without sysfs interface.
  HID: hid-lg4ff: Update respective sysfs interface documentation
  HID: hid-lg: Only one of LG_FF flags can be set for a given device.

 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |   8 +-
 drivers/hid/hid-lg.c                               |  21 +-
 drivers/hid/hid-lg4ff.c                            | 459 +++++++++++++=
+-------
 drivers/hid/hid-lg4ff.h                            |   4 +-
 4 files changed, 319 insertions(+), 173 deletions(-)

--=20
2.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

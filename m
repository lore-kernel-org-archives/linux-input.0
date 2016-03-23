From: =?us-ascii?B?PT9VVEYtOD9xP0NsPUMzPUE5bWVudD0yMFZ1Y2hlbmVyPz0=?=
	<clement.vuchener@gmail.com>
Subject: [PATCH 0/2] hid: corsair: Driver simplification and new supported
 device
Date: Wed, 23 Mar 2016 18:32:16 +0100
Message-ID: <cover.1458744569.git.clement.vuchener@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35298 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbcCWRcZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2016 13:32:25 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

I tried to add support for the K40 some time ago, but the vendor specif=
ic USB protocol became over-complicated because of a lot of small diffe=
rences between the K90 and the K40. Also, since I wrote the first versi=
on of this driver, I learned that USB control transfers could be done f=
rom user-space without the need to detach the kernel driver (please tel=
l me if I am wrong).

So, I decided to move all USB related features in user-space (as far as=
 I know, I was the only user, but if someone is looking for a replaceme=
nt, I wrote a small tool available here: https://github.com/cvuchener/c=
orsair-usb-config). This simplification only leaves the usage code rema=
pping part and the driver no longer depends on USB and LED subsystems. =
This should make the driver easier to maintain or to add new supported =
devices.

After the removal of USB related functions in first patch, the addition=
 of K40 support in the second patch is simply a matter of adding the de=
vice in the id list.

Cl=E9ment Vuchener (2):
  HID: corsair: Remove all features using the USB protocol
  HID: corsair: Add K40 support

 Documentation/ABI/testing/sysfs-driver-hid-corsair |  15 -
 drivers/hid/Kconfig                                |   2 +-
 drivers/hid/hid-core.c                             |   1 +
 drivers/hid/hid-corsair.c                          | 498 +------------=
--------
 drivers/hid/hid-ids.h                              |   1 +
 5 files changed, 5 insertions(+), 512 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-driver-hid-corsair

--=20
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

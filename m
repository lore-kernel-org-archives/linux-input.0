From: Edwin Velds <e.velds@gmail.com>
Subject: [PATCH 0/2] HID: Force feedback support for the Logitech G920 Wheel
Date: Sat, 21 Nov 2015 13:37:09 +0100
Message-ID: <1448109431-10459-1-git-send-email-e.velds@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36584 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbKUMhc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Nov 2015 07:37:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Edwin Velds <e.velds@gmail.com>

This patch implements force feedback support for the Logitech G920 Driving Force
Racing Wheel.

This patch is based on the basic G920 support patch by Simon Wood:
http://www.spinics.net/lists/linux-input/msg42174.html

The first patch splits and renames the HID++ driver (hid-logitech-hidpp.c) into
a basic header and implementation in order to allow building additional features
from multiple sources. Since this only satisfies the needs for the FF driver,
any comments or suggestions are welcome.

The second patch implements all supported force feedback effects. The force
feedback implementation was not made optional because the G920 (like all 
Logitech wheels) can't function without it due to very stiff to default springs.

Edwin Velds (1):
  HID: Create header for Logitech HID++ driver
  HID: Force feedback support for the Logitech G920

 drivers/hid/Makefile                  |    2 +
 drivers/hid/hid-logitech-hidpp-base.c | 1725 ++++++++++++++++++++++++++++++
 drivers/hid/hid-logitech-hidpp-base.h |   81 ++
 drivers/hid/hid-logitech-hidpp-ff.c   |  540 ++++++++++
 drivers/hid/hid-logitech-hidpp-ff.h   |    9 +
 drivers/hid/hid-logitech-hidpp.c      | 1900 ---------------------------------
 6 files changed, 2357 insertions(+), 1900 deletions(-)
 create mode 100644 drivers/hid/hid-logitech-hidpp-base.c
 create mode 100644 drivers/hid/hid-logitech-hidpp-base.h
 create mode 100644 drivers/hid/hid-logitech-hidpp-ff.c
 create mode 100644 drivers/hid/hid-logitech-hidpp-ff.h
 delete mode 100644 drivers/hid/hid-logitech-hidpp.c

-- 
2.5.0


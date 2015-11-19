From: Simon Wood <simon@mungewell.org>
Subject: [Patch-V3 0/6] HID: Support for the Logitech G920 Wheel
Date: Thu, 19 Nov 2015 16:42:09 -0700
Message-ID: <1447976535-2281-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:56238 "EHLO
	host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbbKSXmn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 18:42:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Wood <simon@mungewell.org>

Patch-V3 tweaked as per Benjamin's and Dmitry's requests.

This series of patches provide input support for the Logitech G920 gaming wheel.

This wheel is internally different from the other Logitech wheels; when first 
connected it is in X-Box mode and can instructed to switch to HID with a 'magic 
command' (1st patch). Once the wheel reconnects in HID mode it can communicate 
with the HID++ protocol, but using a 'very long' packet size (2nd patch).

Basic input operation is possible with adustment of the 'range' (the amount that 
the wheel turns) controlled via the '/sys' interface, same concept as the G25/G27/etc.

We also discovered that wheel uses some vendor specific pages, which confuse the 
HID system resulting in lots of additional axis reported. This is prevented by 
ignoring these pages (5th patch, thank you Elias).

The future... as the internals of the wheel are considerably more 'capable' we 
are working on implementing Force Feedback using the forth-coming KLGD system.

Simon Wood (6):
  INPUT: xpad: switch Logitech G920 Wheel into HID mode
  HID: hid-logitech-hidpp: Add support for very long packets
  HID: hid-logitech-hidpp: Add basic support for Logitech G920
  HID: hid-logitech-hidpp: Add range sysfs for Logitech G920
  HID: Add vendor specific usage pages for Logitech G920
  HID: hid-logitech-hidpp: G920 remove deadzones

 drivers/hid/hid-core.c           |   1 +
 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-input.c          |   4 +
 drivers/hid/hid-logitech-hidpp.c | 288 +++++++++++++++++++++++++++++++++++----
 drivers/input/joystick/xpad.c    |  16 +++
 include/linux/hid.h              |   2 +
 6 files changed, 285 insertions(+), 27 deletions(-)

-- 
2.1.4


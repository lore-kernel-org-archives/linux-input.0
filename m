From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 00/13] Input/HID: Bits and Pieces
Date: Fri,  1 Nov 2013 21:16:11 +0100
Message-ID: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:64489 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab3KAUQm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:16:42 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so2268036eaj.14
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Hi

My backlog kept growing and most of the stuff depends on the ABS_* fixes, so I
gave it another try. The first 2 patches introduce EVIOC[GS]ABS2 and friends.
The rest is wiimote stuff that was laying around for some time and just needs
new ABS bits. So once the ABS stuff is in, I see no reason to delay the wiimote
patches (as they're even tested already). Hence, I put it all in a single
series.

Jiri, Dmitry, feel free to bribe me to split / not split the series so the
other one has to take it through their tree. Highest bid wins!

And I am still running tests, so please don't merge, yet. I will report back my
results. Besides, it's probably too late for 3.13, anyway and we should put it
into -next for 3.14 for some while.

Comments welcome!
David

David Herrmann (12):
  Input: uinput: add full absinfo support
  Input: introduce ABS_MAX2/CNT2 and friends
  Input: remove ambigious gamepad comment
  Input: add motion-tracking ABS_* bits and docs
  HID: wiimote: add hid_wiimote.legacy parameter
  HID: wiimote: adjust button-mapping to gamepad rules
  HID: wiimote: map nunchuk as real gamepad
  HID: wiimote: map classic controller as gamepad
  HID: wiimote: use ABS_ACCEL_* for accelerometer
  HID: wiimote: use ABS_GYRO_* bits for MP
  Input: introduce BTN/ABS bits for drums and guitars
  HID: wiimote: add support for Guitar-Hero drums

Nicolas Adenis-Lamarre (1):
  HID: wiimote: add support for Guitar-Hero guitars

 Documentation/input/gamepad.txt          |   9 +-
 Documentation/input/motion-tracking.txt  | 149 ++++++
 drivers/hid/hid-debug.c                  |   2 +-
 drivers/hid/hid-input.c                  |   2 +-
 drivers/hid/hid-wiimote-core.c           |  23 +
 drivers/hid/hid-wiimote-modules.c        | 761 ++++++++++++++++++++++++++-----
 drivers/hid/hid-wiimote.h                |   4 +
 drivers/input/evdev.c                    |  88 +++-
 drivers/input/input.c                    |  14 +-
 drivers/input/keyboard/goldfish_events.c |   6 +-
 drivers/input/keyboard/hil_kbd.c         |   2 +-
 drivers/input/misc/uinput.c              | 146 ++++--
 include/linux/hid.h                      |   2 +-
 include/linux/input.h                    |   6 +-
 include/linux/mod_devicetable.h          |   2 +-
 include/uapi/linux/input.h               |  66 ++-
 include/uapi/linux/uinput.h              |   9 +
 17 files changed, 1125 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/input/motion-tracking.txt

-- 
1.8.4.1


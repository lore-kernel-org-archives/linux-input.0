From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] Input: gamepad - use independent axes for analog D-Pad buttons
Date: Mon, 23 Dec 2013 17:17:43 +0100
Message-ID: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:22437 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab3LWQSU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 11:18:20 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Model this part of the API after the Sony PlayStation 3 Controller which
exposes independent analog values for each one of the D-Pad buttons.

The PS3 programming API psl1ght also maps the analog D-Pad buttons
individually.

Cc: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Hi,

as David mentioned no gamepad defines analog D-Pad buttons as mentioned in the
gamepad API, so the API change should be OK.

And is it OK too to fill the holes in the ABS space or should I just use
higher codes?

Thanks,
   Antonio

 Documentation/input/gamepad.txt       | 4 ++--
 drivers/staging/et131x/Module.symvers | 0
 include/uapi/linux/input.h            | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)
 delete mode 100644 drivers/staging/et131x/Module.symvers

diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
index ed13782..aab000d 100644
--- a/Documentation/input/gamepad.txt
+++ b/Documentation/input/gamepad.txt
@@ -124,8 +124,8 @@ D-Pad:
     Digital buttons are reported as:
       BTN_DPAD_*
     Analog buttons are reported as:
-      ABS_HAT0X and ABS_HAT0Y
-      (for ABS values negative is left/up, positive is right/down)
+      ABS_DPAD_*
+      (ABS values start at 0, pressure is reported as positive values)
 
 Analog-Sticks:
   The left analog-stick is reported as ABS_X, ABS_Y. The right analog stick is
diff --git a/drivers/staging/et131x/Module.symvers b/drivers/staging/et131x/Module.symvers
deleted file mode 100644
index e69de29..0000000
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index d3fcbff..dcc73c0 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -842,6 +842,11 @@ struct input_keymap_entry {
 
 #define ABS_VOLUME		0x20
 
+#define ABS_DPAD_UP		0x21	/* Analog D-Pad Up for gamepads */
+#define ABS_DPAD_DOWN		0x22	/* Analog D-Pad Down for gamepads */
+#define ABS_DPAD_LEFT		0x23	/* Analog D-Pad Left for gamepads */
+#define ABS_DPAD_RIGHT		0x24	/* Analog D-Pad Right for gamepads */
+
 #define ABS_MISC		0x28
 
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
-- 
1.8.5.2


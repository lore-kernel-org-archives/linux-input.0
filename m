From: Daniel Stone <daniels@collabora.com>
Subject: [PATCH] Revert "HID: magicmouse: Set multi-touch keybits for Magic Mouse"
Date: Thu, 15 Jun 2017 13:35:50 +0100
Message-ID: <20170615123550.20661-1-daniels@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44955 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdFOMfy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 08:35:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Che-Liang Chiou <clchiou@chromium.org>, Thierry Escande <thierry.escande@collabora.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Setting these bits causes libinput to fail to initialize the device;
setting BTN_TOUCH and BTN_TOOL_FINGER causes it to treat the mouse as a
touchpad, and it then refuses to continue when it discovers ABS_X is not
set.

This breaks all known Wayland compositors, as well as Xorg when the
libinput driver is being used.

This reverts commit f4b65b9563216b3e01a5cc844c3ba68901d9b195.

Signed-off-by: Daniel Stone <daniels@collabora.com>
Cc: Che-Liang Chiou <clchiou@chromium.org>
Cc: Thierry Escande <thierry.escande@collabora.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-magicmouse.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Jiri, can you please get this into 4.12 final?

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 1d6c997b3001..20b40ad26325 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -349,7 +349,6 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 
 	if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
 		magicmouse_emit_buttons(msc, clicks & 3);
-		input_mt_report_pointer_emulation(input, true);
 		input_report_rel(input, REL_X, x);
 		input_report_rel(input, REL_Y, y);
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
@@ -389,16 +388,16 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__clear_bit(BTN_RIGHT, input->keybit);
 		__clear_bit(BTN_MIDDLE, input->keybit);
 		__set_bit(BTN_MOUSE, input->keybit);
+		__set_bit(BTN_TOOL_FINGER, input->keybit);
+		__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
+		__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
+		__set_bit(BTN_TOOL_QUADTAP, input->keybit);
+		__set_bit(BTN_TOOL_QUINTTAP, input->keybit);
+		__set_bit(BTN_TOUCH, input->keybit);
+		__set_bit(INPUT_PROP_POINTER, input->propbit);
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 	}
 
-	__set_bit(BTN_TOOL_FINGER, input->keybit);
-	__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
-	__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
-	__set_bit(BTN_TOOL_QUADTAP, input->keybit);
-	__set_bit(BTN_TOOL_QUINTTAP, input->keybit);
-	__set_bit(BTN_TOUCH, input->keybit);
-	__set_bit(INPUT_PROP_POINTER, input->propbit);
 
 	__set_bit(EV_ABS, input->evbit);
 
-- 
2.11.0


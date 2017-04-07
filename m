From: Thierry Escande <thierry.escande@collabora.com>
Subject: [PATCH] HID: magicmouse: Set multi-touch keybits for Magic Mouse
Date: Fri,  7 Apr 2017 10:12:36 +0200
Message-ID: <1491552756-9933-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55981 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbdDGIMp (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Apr 2017 04:12:45 -0400
Content-Transfert-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Che-Liang Chiou <clchiou@chromium.org>

The driver emits multi-touch events for Magic Trackpad as well as Magic
Mouse, but it does not set keybits that are related to multi-touch event
for Magic Mouse; so set these keybits.

The keybits that are not set cause trouble because user programs often
probe these keybits for self-configuration and thus they cannot operate
properly if the keybits are not set.

One of such troubles is that libevdev will not be able to emit correct
touch count, causing gestures library failed to do fling stop.

Signed-off-by: Che-Liang Chiou <clchiou@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/hid/hid-magicmouse.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 20b40ad..1d6c997 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -349,6 +349,7 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 
 	if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
 		magicmouse_emit_buttons(msc, clicks & 3);
+		input_mt_report_pointer_emulation(input, true);
 		input_report_rel(input, REL_X, x);
 		input_report_rel(input, REL_Y, y);
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
@@ -388,16 +389,16 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__clear_bit(BTN_RIGHT, input->keybit);
 		__clear_bit(BTN_MIDDLE, input->keybit);
 		__set_bit(BTN_MOUSE, input->keybit);
-		__set_bit(BTN_TOOL_FINGER, input->keybit);
-		__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
-		__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
-		__set_bit(BTN_TOOL_QUADTAP, input->keybit);
-		__set_bit(BTN_TOOL_QUINTTAP, input->keybit);
-		__set_bit(BTN_TOUCH, input->keybit);
-		__set_bit(INPUT_PROP_POINTER, input->propbit);
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 	}
 
+	__set_bit(BTN_TOOL_FINGER, input->keybit);
+	__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
+	__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
+	__set_bit(BTN_TOOL_QUADTAP, input->keybit);
+	__set_bit(BTN_TOOL_QUINTTAP, input->keybit);
+	__set_bit(BTN_TOUCH, input->keybit);
+	__set_bit(INPUT_PROP_POINTER, input->propbit);
 
 	__set_bit(EV_ABS, input->evbit);
 
-- 
2.7.4


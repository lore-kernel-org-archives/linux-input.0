From: Benjamin Tissoires <tissoire@cena.fr>
Subject: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.
Date: Mon, 08 Mar 2010 22:29:47 +0100
Message-ID: <1268083787.9018.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:44751 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755847Ab0CHV34 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 16:29:56 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A3EA9D4817F
	for <linux-input@vger.kernel.org>; Mon,  8 Mar 2010 22:29:51 +0100 (CET)
Received: from [192.168.0.112] (lan31-8-82-247-176-67.fbx.proxad.net [82.247.176.67])
	by smtp5-g21.free.fr (Postfix) with ESMTP id AB248D480B3
	for <linux-input@vger.kernel.org>; Mon,  8 Mar 2010 22:29:48 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


This code, related to the second input device, is unnecessary as it concerns
the previous implementation and is not used anymore.

Signed-off-by: Benjamin Tissoires <tissoire@cena.fr>
---
 drivers/hid/hid-magicmouse.c |   68 ------------------------------------------
 1 files changed, 0 insertions(+), 68 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 32d90c8..b9d605e 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -262,74 +262,6 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
-static int magicmouse_input_open(struct input_dev *dev)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-
-	return hid->ll_driver->open(hid);
-}
-
-static void magicmouse_input_close(struct input_dev *dev)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-
-	hid->ll_driver->close(hid);
-}
-
-static void magicmouse_setup_input(struct input_dev *input, struct hid_device *hdev)
-{
-	input_set_drvdata(input, hdev);
-	input->event = hdev->ll_driver->hidinput_input_event;
-	input->open = magicmouse_input_open;
-	input->close = magicmouse_input_close;
-
-	input->name = hdev->name;
-	input->phys = hdev->phys;
-	input->uniq = hdev->uniq;
-	input->id.bustype = hdev->bus;
-	input->id.vendor = hdev->vendor;
-	input->id.product = hdev->product;
-	input->id.version = hdev->version;
-	input->dev.parent = hdev->dev.parent;
-
-	__set_bit(EV_KEY, input->evbit);
-	__set_bit(BTN_LEFT, input->keybit);
-	__set_bit(BTN_RIGHT, input->keybit);
-	if (emulate_3button)
-		__set_bit(BTN_MIDDLE, input->keybit);
-	__set_bit(BTN_TOOL_FINGER, input->keybit);
-
-	__set_bit(EV_REL, input->evbit);
-	__set_bit(REL_X, input->relbit);
-	__set_bit(REL_Y, input->relbit);
-	if (emulate_scroll_wheel)
-		__set_bit(REL_WHEEL, input->relbit);
-
-	if (report_touches) {
-		__set_bit(EV_ABS, input->evbit);
-
-		input_set_abs_params(input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 4, 0);
-		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255, 4, 0);
-		input_set_abs_params(input, ABS_MT_ORIENTATION, -32, 31, 1, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_X, -1100, 1358,
-				4, 0);
-		/* Note: Touch Y position from the device is inverted relative
-		 * to how pointer motion is reported (and relative to how USB
-		 * HID recommends the coordinates work).  This driver keeps
-		 * the origin at the same position, and just uses the additive
-		 * inverse of the reported Y.
-		 */
-		input_set_abs_params(input, ABS_MT_POSITION_Y, -1589, 2047,
-				4, 0);
-	}
-
-	if (report_undeciphered) {
-		__set_bit(EV_MSC, input->evbit);
-		__set_bit(MSC_RAW, input->mscbit);
-	}
-}
-
 static int magicmouse_input_mapping(struct hid_device *hdev, struct hid_input *hinput,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
-- 1.6.6.1 



From: Ming-ting Yao Wei <mwei@lxde.org>
Subject: [PATCH 1/2] xpad: Add rumble support for Xbox One controller
Date: Mon, 13 Apr 2015 16:21:34 +0800
Message-ID: <1428913295-14332-1-git-send-email-mwei@lxde.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33007 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbDMIVo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2015 04:21:44 -0400
Received: by paboj16 with SMTP id oj16so95061290pab.0
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2015 01:21:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ming-ting Yao Wei <mwei@lxde.org>, linux-input@vger.kernel.org

This adds rumble support for Xbox One controller. Tested with fftest.

---
 drivers/input/joystick/xpad.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3aa2f3f..9b08c47 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -828,6 +828,23 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 
 			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
 
+		case XTYPE_XBOXONE:
+			xpad->odata[0] = 0x09; /* activate rumble */
+			xpad->odata[1] = 0x08;
+			xpad->odata[2] = 0x00;
+			xpad->odata[3] = 0x08; /* continuous effect */
+			xpad->odata[4] = 0x00; /* simple rumble mode */
+			xpad->odata[5] = 0x03; /* L and R actuator only */
+			xpad->odata[6] = 0x00; /* TODO: LT actuator */
+			xpad->odata[7] = 0x00; /* TODO: RT actuator */
+			xpad->odata[8] = strong / 256;	/* left actuator */
+			xpad->odata[9] = weak / 256;	/* right actuator */
+			xpad->odata[10] = 0x80;	/* length of pulse */
+			xpad->odata[11] = 0x00;	/* stop period of pulse */
+			xpad->irq_out->transfer_buffer_length = 12;
+
+			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+
 		default:
 			dev_dbg(&xpad->dev->dev,
 				"%s - rumble command sent to unsupported xpad type: %d\n",
@@ -841,7 +858,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_UNKNOWN || xpad->xtype == XTYPE_XBOXONE)
+	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
 
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
-- 
2.3.2 (Apple Git-55)


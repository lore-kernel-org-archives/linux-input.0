From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - power off wireless 360 controllers on suspend
Date: Mon, 25 Jul 2016 22:35:08 -0700
Message-ID: <6203d65c-4e15-c44c-edc9-d47cc78f1c28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36023 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbcGZFfL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2016 01:35:11 -0400
Received: by mail-pa0-f68.google.com with SMTP id ez1so12624392pab.3
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2016 22:35:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

When the USB wireless adapter is suspended, the controllers
lose their connection. This causes them to start flashing
their LED rings and searching for the wireless adapter
again, wasting the controller's battery power.

Instead, we will tell the controllers to power down when
we suspend. This mirrors the behavior of the controllers
when connected to the console itself and how the official
Xbox One wireless adapter behaves on Windows.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
This patch is independent of the other xpad patch [0] that I
submitted (and decided to wait on). It applies against
unmodified xpad.c in master.

[0] http://www.spinics.net/lists/linux-input/msg46062.html
---
 drivers/input/joystick/xpad.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a529a45..3408019 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -115,6 +115,10 @@ static bool sticks_to_null;
 module_param(sticks_to_null, bool, S_IRUGO);
 MODULE_PARM_DESC(sticks_to_null, "Do not map sticks at all for unknown pads");
 
+static bool disable_auto_poweroff;
+module_param(disable_auto_poweroff, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_auto_poweroff, "Do not power off wireless controllers on suspend");
+
 static const struct xpad_device {
 	u16 idVendor;
 	u16 idProduct;
@@ -1248,6 +1252,36 @@ static void xpad_stop_input(struct usb_xpad *xpad)
 	usb_kill_urb(xpad->irq_in);
 }
 
+static void xpad360w_poweroff_controller(struct usb_xpad *xpad)
+{
+	unsigned long flags;
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CMD_IDX];
+
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
+	packet->data[0] = 0x00;
+	packet->data[1] = 0x00;
+	packet->data[2] = 0x08;
+	packet->data[3] = 0xC0;
+	packet->data[4] = 0x00;
+	packet->data[5] = 0x00;
+	packet->data[6] = 0x00;
+	packet->data[7] = 0x00;
+	packet->data[8] = 0x00;
+	packet->data[9] = 0x00;
+	packet->data[10] = 0x00;
+	packet->data[11] = 0x00;
+	packet->len = 12;
+	packet->pending = true;
+
+	/* Reset the sequence so we send out poweroff now */
+	xpad->last_out_packet = -1;
+	xpad_try_sending_next_out_packet(xpad);
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
+}
+
 static int xpad360w_start_input(struct usb_xpad *xpad)
 {
 	int error;
@@ -1590,6 +1624,15 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 		 * or goes away.
 		 */
 		xpad360w_stop_input(xpad);
+
+		/*
+		 * The wireless adapter is going off now, so the
+		 * gamepads are going to become disconnected.
+		 * Unless explicitly disabled, power them down
+		 * so they don't just sit there flashing.
+		 */
+		if (!disable_auto_poweroff && xpad->pad_present)
+			xpad360w_poweroff_controller(xpad);
 	} else {
 		mutex_lock(&input->mutex);
 		if (input->users)
-- 
2.7.4

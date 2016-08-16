From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v2 3/4] Input: xpad - fix stuck mode button on Xbox One S pad
Date: Mon, 15 Aug 2016 21:10:15 -0700
Message-ID: <1471320616-13110-4-git-send-email-aicommander@gmail.com>
References: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33107 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcHPEKV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2016 00:10:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so4772320pfe.0
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2016 21:10:21 -0700 (PDT)
In-Reply-To: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

The Xbox One S requires an ack to its mode button report
otherwise it continuously retransmits the report. This
makes the mode button appear to be stuck down after it
is pressed for the first time.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3577253..42723ba 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -389,6 +389,7 @@ struct usb_xpad {
 
 static int xpad_init_input(struct usb_xpad *xpad);
 static void xpad_deinit_input(struct usb_xpad *xpad);
+static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 
 /*
  *	xpad_process_packet
@@ -699,6 +700,14 @@ static void xpadone_process_packet(struct usb_xpad *xpad,
 		break;
 
 	case 0x07:
+		/*
+		 * The Xbox One S controller requires these reports to be
+		 * acked otherwise it continues sending them forever and
+		 * won't report further mode button events.
+		 */
+		if (data[1] == 0x30)
+			xpadone_ack_mode_report(xpad, data[2]);
+
 		/* the xbox button has its own special report */
 		input_report_key(dev, BTN_MODE, data[4] & 0x01);
 		input_sync(dev);
@@ -974,6 +983,30 @@ static int xpad_start_xbox_one(struct usb_xpad *xpad)
 	return retval;
 }
 
+static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num)
+{
+	unsigned long flags;
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CMD_IDX];
+	static const u8 mode_report_ack[] = {
+		0x01, 0x20, 0x00, 0x09, 0x00, 0x07, 0x20, 0x02,
+		0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
+	packet->len = sizeof(mode_report_ack);
+	memcpy(packet->data, mode_report_ack, packet->len);
+	packet->data[2] = seq_num;
+	packet->pending = true;
+
+	/* Reset the sequence so we send out the ack now */
+	xpad->last_out_packet = -1;
+	xpad_try_sending_next_out_packet(xpad);
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
+}
+
 #ifdef CONFIG_JOYSTICK_XPAD_FF
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
-- 
2.7.4


From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 5/5] Input: xpad - fix stuck mode button on Xbox One S pad
Date: Sat,  4 Feb 2017 16:30:02 -0800
Message-ID: <20170205003002.28160-6-aicommander@gmail.com>
References: <20170205003002.28160-1-aicommander@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170205003002.28160-1-aicommander@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>
List-Id: linux-input@vger.kernel.org

The Xbox One S requires an ack to its mode button report
otherwise it continuously retransmits the report. This
makes the mode button appear to be stuck down after it
is pressed for the first time.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1179266..eb01c54 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -414,6 +414,7 @@ struct usb_xpad {
 
 static int xpad_init_input(struct usb_xpad *xpad);
 static void xpad_deinit_input(struct usb_xpad *xpad);
+static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 
 /*
  *	xpad_process_packet
@@ -647,6 +648,14 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 
 	/* the xbox button has its own special report */
 	if (data[0] == 0X07) {
+		/*
+		 * The Xbox One S controller requires these reports to be
+		 * acked otherwise it continues sending them forever and
+		 * won't report further mode button events.
+		 */
+		if (data[1] == 0x30)
+			xpadone_ack_mode_report(xpad, data[2]);
+
 		input_report_key(dev, BTN_MODE, data[4] & 0x01);
 		input_sync(dev);
 		return;
@@ -983,6 +992,30 @@ static int xpad_start_xbox_one(struct usb_xpad *xpad)
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
2.9.3

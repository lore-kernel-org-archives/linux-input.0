From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 1/5] Input: xpad - use a packet array to start Xbox One pads
Date: Sat,  4 Feb 2017 16:29:58 -0800
Message-ID: <20170205003002.28160-2-aicommander@gmail.com>
References: <20170205003002.28160-1-aicommander@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170205003002.28160-1-aicommander@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>
List-Id: linux-input@vger.kernel.org

This is preparatory work for supporting some 3rd party
pads that need more initialization packets than just
one. No initialization behavior change expected.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 247fd3a..6f07b5b 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -343,6 +343,15 @@ struct xpad_output_packet {
 	bool pending;
 };
 
+/* Sequence numbers will be added before the packets are sent */
+static const struct xpad_output_packet xone_init_pkt[] = {
+	/*
+	 * This packet is required for all Xbox One pads with 2015
+	 * or later firmware installed (or present from the factory).
+	 */
+	{{0x05, 0x20, 0x00, 0x01, 0x00}, 5, true},
+};
+
 #define XPAD_OUT_CMD_IDX	0
 #define XPAD_OUT_FF_IDX		1
 #define XPAD_OUT_LED_IDX	(1 + IS_ENABLED(CONFIG_JOYSTICK_XPAD_FF))
@@ -373,6 +382,7 @@ struct usb_xpad {
 
 	struct xpad_output_packet out_packets[XPAD_NUM_OUT_PACKETS];
 	int last_out_packet;
+	int init_seq;
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -742,8 +752,19 @@ static void xpad_irq_in(struct urb *urb)
 static bool xpad_prepare_next_out_packet(struct usb_xpad *xpad)
 {
 	struct xpad_output_packet *pkt, *packet = NULL;
+	const struct xpad_output_packet *init_packet;
 	int i;
 
+	if (xpad->xtype == XTYPE_XBOXONE && xpad->init_seq < ARRAY_SIZE(xone_init_pkt)) {
+		init_packet = &xone_init_pkt[xpad->init_seq++];
+		memcpy(xpad->odata, init_packet->data, init_packet->len);
+		xpad->irq_out->transfer_buffer_length = init_packet->len;
+
+		/* Update packet with current sequence number */
+		xpad->odata[2] = xpad->odata_serial++;
+		return true;
+	}
+
 	for (i = 0; i < XPAD_NUM_OUT_PACKETS; i++) {
 		if (++xpad->last_out_packet >= XPAD_NUM_OUT_PACKETS)
 			xpad->last_out_packet = 0;
@@ -929,24 +950,17 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 
 static int xpad_start_xbox_one(struct usb_xpad *xpad)
 {
-	struct xpad_output_packet *packet =
-			&xpad->out_packets[XPAD_OUT_CMD_IDX];
 	unsigned long flags;
 	int retval;
 
 	spin_lock_irqsave(&xpad->odata_lock, flags);
 
-	/* Xbox one controller needs to be initialized. */
-	packet->data[0] = 0x05;
-	packet->data[1] = 0x20;
-	packet->data[2] = xpad->odata_serial++; /* packet serial */
-	packet->data[3] = 0x01; /* rumble bit enable?  */
-	packet->data[4] = 0x00;
-	packet->len = 5;
-	packet->pending = true;
-
-	/* Reset the sequence so we send out start packet first */
-	xpad->last_out_packet = -1;
+	/*
+	 * Begin the init sequence by attempting to send a packet.
+	 * We will cycle through the init packet sequence before
+	 * sending any packets from the output ring.
+	 */
+	xpad->init_seq = 0;
 	retval = xpad_try_sending_next_out_packet(xpad);
 
 	spin_unlock_irqrestore(&xpad->odata_lock, flags);
-- 
2.9.3

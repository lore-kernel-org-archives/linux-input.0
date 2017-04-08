From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v2 1/2] Input: xpad - support some quirky Xbox One pads
Date: Sat,  8 Apr 2017 14:28:05 -0700
Message-ID: <20170408212806.7790-2-aicommander@gmail.com>
References: <20170408212806.7790-1-aicommander@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170408212806.7790-1-aicommander@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are several quirky Xbox One pads that depend on initialization
packets that the Microsoft pads don't require. To deal with these,
I've added a mechanism for issuing device-specific initialization
packets using a VID/PID-based quirks list.

For the initial set of init quirks, I have added quirk handling from
Valve's Steam Link xpad driver[0] and the 360Controller project[1] for
macOS to enable some new pads to work properly.

This should enable full functionality on the following quirky pads:
0x0e6f:0x0165 - Titanfall 2 gamepad (previously fully non-functional)
0x0f0d:0x0067 - Hori Horipad (analog sticks previously non-functional)
0x24c6:0x541a - PowerA Xbox One pad (previously fully non-functional)
0x24c6:0x542a - PowerA Xbox One pad (previously fully non-functional)
0x24c6:0x543a - PowerA Xbox One pad (previously fully non-functional)

[0]: https://github.com/ValveSoftware/steamlink-sdk/blob/master/kernel/drivers/input/joystick/xpad.c
[1]: https://github.com/360Controller/360Controller

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
v2:
- Fixed up the commit message which had some lines incorrectly copied
  from the previous submission.
- Added more details as the previous commit message was a bit sparse.

---
 drivers/input/joystick/xpad.c | 114 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 155fcb3..efb798a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -337,6 +337,64 @@ static struct usb_device_id xpad_table[] = {
 
 MODULE_DEVICE_TABLE(usb, xpad_table);
 
+struct xboxone_init_packet {
+	u16 idVendor;
+	u16 idProduct;
+	const u8 *data;
+	u8 len;
+};
+
+#define XBOXONE_INIT_PKT(_vid, _pid, _data)		\
+	{						\
+		.idVendor	= (_vid),		\
+		.idProduct	= (_pid),		\
+		.data		= (_data),		\
+		.len		= ARRAY_SIZE(_data),	\
+	}
+
+
+/*
+ * This packet is required for all Xbox One pads with 2015
+ * or later firmware installed (or present from the factory).
+ */
+static const u8 xboxone_fw2015_init[] = {
+	0x05, 0x20, 0x00, 0x01, 0x00
+};
+
+ /*
+  * This packet is required for the Titanfall 2 Xbox One pads
+  * (0x0e6f:0x0165) to finish initialization and for Hori pads
+  * (0x0f0d:0x0067) to make the analog sticks work.
+  */
+static const u8 xboxone_hori_init[] = {
+	0x01, 0x20, 0x00, 0x09, 0x00, 0x04, 0x20, 0x3a,
+	0x00, 0x00, 0x00, 0x80, 0x00
+};
+
+/*
+ * A rumble packet is required for some PowerA pads to start
+ * sending input reports. One of those pads is (0x24c6:0x543a).
+ */
+static const u8 xboxone_zerorumble_init[] = {
+	0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/*
+ * This specifies the selection of init packets that a gamepad
+ * will be sent on init *and* the order in which they will be
+ * sent. The correct sequence number will be added when the
+ * packet is going to be sent.
+ */
+static const struct xboxone_init_packet xboxone_init_packets[] = {
+	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
+	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
+	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_zerorumble_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_zerorumble_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_zerorumble_init),
+};
+
 struct xpad_output_packet {
 	u8 data[XPAD_PKT_LEN];
 	u8 len;
@@ -373,6 +431,7 @@ struct usb_xpad {
 
 	struct xpad_output_packet out_packets[XPAD_NUM_OUT_PACKETS];
 	int last_out_packet;
+	int init_seq;
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -748,11 +807,47 @@ static void xpad_irq_in(struct urb *urb)
 }
 
 /* Callers must hold xpad->odata_lock spinlock */
+static bool xpad_prepare_next_init_packet(struct usb_xpad *xpad)
+{
+	const struct xboxone_init_packet *init_packet;
+
+	if (xpad->xtype != XTYPE_XBOXONE)
+		return false;
+
+	/* Perform initialization sequence for Xbox One pads that require it */
+	while (xpad->init_seq < ARRAY_SIZE(xboxone_init_packets)) {
+		init_packet = &xboxone_init_packets[xpad->init_seq++];
+
+		if (init_packet->idVendor != 0 &&
+		    init_packet->idVendor != xpad->dev->id.vendor)
+			continue;
+
+		if (init_packet->idProduct != 0 &&
+		    init_packet->idProduct != xpad->dev->id.product)
+			continue;
+
+		/* This packet applies to our device, so prepare to send it */
+		memcpy(xpad->odata, init_packet->data, init_packet->len);
+		xpad->irq_out->transfer_buffer_length = init_packet->len;
+
+		/* Update packet with current sequence number */
+		xpad->odata[2] = xpad->odata_serial++;
+		return true;
+	}
+
+	return false;
+}
+
+/* Callers must hold xpad->odata_lock spinlock */
 static bool xpad_prepare_next_out_packet(struct usb_xpad *xpad)
 {
 	struct xpad_output_packet *pkt, *packet = NULL;
 	int i;
 
+	/* We may have init packets to send before we can send user commands */
+	if (xpad_prepare_next_init_packet(xpad))
+		return true;
+
 	for (i = 0; i < XPAD_NUM_OUT_PACKETS; i++) {
 		if (++xpad->last_out_packet >= XPAD_NUM_OUT_PACKETS)
 			xpad->last_out_packet = 0;
@@ -938,24 +1033,17 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 
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

From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 1/2] add additional reverse-engineered information
Date: Sun,  9 Jul 2017 20:54:50 +0200
Message-ID: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:37776 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdGITEE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 9 Jul 2017 15:04:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>

Due to recent reverse engineering efforts, a lot more information is now 
available about the internals of the SUR40. We document this in the kernel
driver for future use.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 128e5bd..12bdee9 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -59,7 +59,7 @@ struct sur40_blob {
 	__le16 blob_id;
 
 	u8 action;         /* 0x02 = enter/exit, 0x03 = update (?) */
-	u8 unknown;        /* always 0x01 or 0x02 (no idea what this is?) */
+	u8 type;           /* bitmask (0x01 blob,  0x02 touch, 0x04 tag) */
 
 	__le16 bb_pos_x;   /* upper left corner of bounding box */
 	__le16 bb_pos_y;
@@ -133,12 +133,19 @@ struct sur40_image_header {
 
 /* control commands */
 #define SUR40_GET_VERSION 0xb0 /* 12 bytes string    */
-#define SUR40_UNKNOWN1    0xb3 /*  5 bytes           */
-#define SUR40_UNKNOWN2    0xc1 /* 24 bytes           */
+#define SUR40_ACCEL_CAPS  0xb3 /*  5 bytes           */
+#define SUR40_SENSOR_CAPS 0xc1 /* 24 bytes           */
+
+#define SUR40_POKE        0xc5 /* poke register byte */
+#define SUR40_PEEK        0xc4 /* 48 bytes registers */
 
 #define SUR40_GET_STATE   0xc5 /*  4 bytes state (?) */
 #define SUR40_GET_SENSORS 0xb1 /*  8 bytes sensors   */
 
+#define SUR40_BLOB   0x01
+#define SUR40_TOUCH	0x02
+#define SUR40_TAG    0x04
+
 static const struct v4l2_pix_format sur40_pix_format[] = {
 	{
 		.pixelformat = V4L2_TCH_FMT_TU08,
@@ -238,11 +245,11 @@ static int sur40_init(struct sur40_state *dev)
 	if (result < 0)
 		goto error;
 
-	result = sur40_command(dev, SUR40_UNKNOWN2,    0x00, buffer, 24);
+	result = sur40_command(dev, SUR40_SENSOR_CAPS, 0x00, buffer, 24);
 	if (result < 0)
 		goto error;
 
-	result = sur40_command(dev, SUR40_UNKNOWN1,    0x00, buffer,  5);
+	result = sur40_command(dev, SUR40_ACCEL_CAPS, 0x00, buffer, 5);
 	if (result < 0)
 		goto error;
 
@@ -367,10 +374,13 @@ static void sur40_poll(struct input_polled_dev *polldev)
 		/*
 		 * Sanity check. when video data is also being retrieved, the
 		 * packet ID will usually increase in the middle of a series
-		 * instead of at the end.
-		 */
-		if (packet_id != le32_to_cpu(header->packet_id))
+		 * instead of at the end. however, the data is still consistent,
+		 * so the packet ID is probably just valid for the first packet
+		 * in a series.
+
+		if (packet_id != header->packet_id)
 			dev_dbg(sur40->dev, "packet ID mismatch\n");
+		 */
 
 		packet_blobs = result / sizeof(struct sur40_blob);
 		dev_dbg(sur40->dev, "received %d blobs\n", packet_blobs);
-- 
2.7.4


From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH v2 1/3] add additional reverse-engineered information
Date: Mon, 10 Jul 2017 17:42:24 +0200
Message-ID: <1499701346-12110-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:42409 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753646AbdGJPmh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 11:42:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, peter.hutterer@who-t.net
Cc: Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>

Due to recent reverse engineering efforts, a lot more information is now 
available about the internals of the SUR40. We document this in the kernel
driver for future use.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 128e5bd..259aef5 100644
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
 
+#define SUR40_BLOB	0x01
+#define SUR40_TOUCH	0x02
+#define SUR40_TAG	0x04
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
 
-- 
2.7.4


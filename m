From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: ALPS - split protocol data from model info
Date: Wed, 14 Jan 2015 14:55:51 -0800
Message-ID: <1421276154-8689-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:62985 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbbANW4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 17:56:13 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so11784562ieb.7
        for <linux-input@vger.kernel.org>; Wed, 14 Jan 2015 14:56:12 -0800 (PST)
In-Reply-To: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

In preparation of reworking the way we set protocol parameters let's
split certain protocol items from alps_model_info into a separate
structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c | 58 +++++++++++++++++++++++-----------------------
 drivers/input/mouse/alps.h | 26 ++++++++++++++-------
 2 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 80aa6f8..1de0345 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -102,32 +102,32 @@ static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
 #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
 
 static const struct alps_model_info alps_model_data[] = {
-	{ { 0x32, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },	/* Toshiba Salellite Pro M10 */
-	{ { 0x33, 0x02, 0x0a },	0x00, ALPS_PROTO_V1, 0x88, 0xf8, 0 },				/* UMAX-530T */
-	{ { 0x53, 0x02, 0x0a },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, 0 },
-	{ { 0x53, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, 0 },
-	{ { 0x60, 0x03, 0xc8 }, 0x00, ALPS_PROTO_V2, 0xf8, 0xf8, 0 },				/* HP ze1115 */
-	{ { 0x63, 0x02, 0x0a },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, 0 },
-	{ { 0x63, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, 0 },
-	{ { 0x63, 0x02, 0x28 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 },		/* Fujitsu Siemens S6010 */
-	{ { 0x63, 0x02, 0x3c },	0x00, ALPS_PROTO_V2, 0x8f, 0x8f, ALPS_WHEEL },			/* Toshiba Satellite S2400-103 */
-	{ { 0x63, 0x02, 0x50 },	0x00, ALPS_PROTO_V2, 0xef, 0xef, ALPS_FW_BK_1 },		/* NEC Versa L320 */
-	{ { 0x63, 0x02, 0x64 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, 0 },
-	{ { 0x63, 0x03, 0xc8 }, 0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },	/* Dell Latitude D800 */
-	{ { 0x73, 0x00, 0x0a },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_DUALPOINT },		/* ThinkPad R61 8918-5QG */
-	{ { 0x73, 0x02, 0x0a },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, 0 },
-	{ { 0x73, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 },		/* Ahtec Laptop */
-	{ { 0x20, 0x02, 0x0e },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },	/* XXX */
-	{ { 0x22, 0x02, 0x0a },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
-	{ { 0x22, 0x02, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT },	/* Dell Latitude D600 */
+	{ { 0x32, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* Toshiba Salellite Pro M10 */
+	{ { 0x33, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V1, 0x88, 0xf8, 0 } },				/* UMAX-530T */
+	{ { 0x53, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x53, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x60, 0x03, 0xc8 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },				/* HP ze1115 */
+	{ { 0x63, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x02, 0x28 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },		/* Fujitsu Siemens S6010 */
+	{ { 0x63, 0x02, 0x3c }, 0x00, { ALPS_PROTO_V2, 0x8f, 0x8f, ALPS_WHEEL } },		/* Toshiba Satellite S2400-103 */
+	{ { 0x63, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xef, 0xef, ALPS_FW_BK_1 } },		/* NEC Versa L320 */
+	{ { 0x63, 0x02, 0x64 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x03, 0xc8 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* Dell Latitude D800 */
+	{ { 0x73, 0x00, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_DUALPOINT } },		/* ThinkPad R61 8918-5QG */
+	{ { 0x73, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x73, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },		/* Ahtec Laptop */
+	{ { 0x20, 0x02, 0x0e }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* XXX */
+	{ { 0x22, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },
+	{ { 0x22, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT } },	/* Dell Latitude D600 */
 	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
-	{ { 0x62, 0x02, 0x14 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf,
-		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
-	{ { 0x73, 0x00, 0x14 }, 0x00, ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT },		/* Dell XT2 */
-	{ { 0x73, 0x02, 0x50 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },		/* Dell Vostro 1400 */
-	{ { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
-		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },				/* Toshiba Tecra A11-11L */
-	{ { 0x73, 0x02, 0x64 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
+	{ { 0x62, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },
+	{ { 0x73, 0x00, 0x14 }, 0x00, { ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT } },		/* Dell XT2 */
+	{ { 0x73, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },	/* Dell Vostro 1400 */
+	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba Tecra A11-11L */
+	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
 };
 
 static void alps_set_abs_params_st(struct alps_data *priv,
@@ -2263,12 +2263,12 @@ static int alps_match_table(struct psmouse *psmouse, struct alps_data *priv,
 		    (!model->command_mode_resp ||
 		     model->command_mode_resp == ec[2])) {
 
-			priv->proto_version = model->proto_version;
+			priv->proto_version = model->protocol_info.version;
 			alps_set_defaults(priv);
 
-			priv->flags = model->flags;
-			priv->byte0 = model->byte0;
-			priv->mask0 = model->mask0;
+			priv->flags = model->protocol_info.flags;
+			priv->byte0 = model->protocol_info.byte0;
+			priv->mask0 = model->protocol_info.mask0;
 
 			return 0;
 		}
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index f19908a..c795235 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -47,18 +47,28 @@ enum V7_PACKET_ID {
 };
 
 /**
+ * struct alps_protocol_info - information about protocol used by a device
+ * @version: Indicates V1/V2/V3/...
+ * @byte0: Helps figure out whether a position report packet matches the
+ *   known format for this model.  The first byte of the report, ANDed with
+ *   mask0, should match byte0.
+ * @mask0: The mask used to check the first byte of the report.
+ * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
+ */
+struct alps_protocol_info {
+	u16 version;
+	u8 byte0, mask0;
+	unsigned int flags;
+};
+
+/**
  * struct alps_model_info - touchpad ID table
  * @signature: E7 response string to match.
  * @command_mode_resp: For V3/V4 touchpads, the final byte of the EC response
  *   (aka command mode response) identifies the firmware minor version.  This
  *   can be used to distinguish different hardware models which are not
  *   uniquely identifiable through their E7 responses.
- * @proto_version: Indicates V1/V2/V3/...
- * @byte0: Helps figure out whether a position report packet matches the
- *   known format for this model.  The first byte of the report, ANDed with
- *   mask0, should match byte0.
- * @mask0: The mask used to check the first byte of the report.
- * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
+ * @protocol_info: information about protcol used by the device.
  *
  * Many (but not all) ALPS touchpads can be identified by looking at the
  * values returned in the "E7 report" and/or the "EC report."  This table
@@ -67,9 +77,7 @@ enum V7_PACKET_ID {
 struct alps_model_info {
 	u8 signature[3];
 	u8 command_mode_resp;
-	u16 proto_version;
-	u8 byte0, mask0;
-	unsigned int flags;
+	struct alps_protocol_info protocol_info;
 };
 
 /**
-- 
2.2.0.rc0.207.ga3a616c


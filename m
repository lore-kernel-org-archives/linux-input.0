From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 3/3] Input: alps - cleanup alps_model_data
Date: Sat,  4 Mar 2017 12:24:26 +0100
Message-ID: <1488626666-16577-4-git-send-email-pali.rohar@gmail.com>
References: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34961 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdCDLbc (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Mar 2017 06:31:32 -0500
In-Reply-To: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Sort all devices in alps_model_data by signature and remove
command_mode_resp which is not used anymore.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   56 ++++++++++++++++++++------------------------
 drivers/input/mouse/alps.h |    5 ----
 2 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 9908f18..6fc608d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -106,38 +106,36 @@
 #define ALPS_DUALPOINT_WITH_PRESSURE	0x400	/* device can report trackpoint pressure */
 
 static const struct alps_model_info alps_model_data[] = {
-	{ { 0x32, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* Toshiba Salellite Pro M10 */
-	{ { 0x33, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V1, 0x88, 0xf8, 0 } },				/* UMAX-530T */
-	{ { 0x53, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x53, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x60, 0x03, 0xc8 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },				/* HP ze1115 */
-	{ { 0x63, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x63, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x63, 0x02, 0x28 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },		/* Fujitsu Siemens S6010 */
-	{ { 0x63, 0x02, 0x3c }, 0x00, { ALPS_PROTO_V2, 0x8f, 0x8f, ALPS_WHEEL } },		/* Toshiba Satellite S2400-103 */
-	{ { 0x63, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xef, 0xef, ALPS_FW_BK_1 } },		/* NEC Versa L320 */
-	{ { 0x63, 0x02, 0x64 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x63, 0x03, 0xc8 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* Dell Latitude D800 */
-	{ { 0x73, 0x00, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_DUALPOINT } },		/* ThinkPad R61 8918-5QG */
-	{ { 0x73, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x73, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },		/* Ahtec Laptop */
-
 	/*
 	 * XXX This entry is suspicious. First byte has zero lower nibble,
 	 * which is what a normal mouse would report. Also, the value 0x0e
 	 * isn't valid per PS/2 spec.
 	 */
-	{ { 0x20, 0x02, 0x0e }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },
-
-	{ { 0x22, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },
-	{ { 0x22, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT } },	/* Dell Latitude D600 */
-	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
-	{ { 0x62, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf,
-		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },
-	{ { 0x73, 0x00, 0x14 }, 0x00, { ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT } },		/* Dell XT2 */
-	{ { 0x73, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },	/* Dell Vostro 1400 */
-	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
+	{ { 0x20, 0x02, 0x0e }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },
+
+	{ { 0x22, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },
+	{ { 0x22, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT } },	/* Dell Latitude D600 */
+	{ { 0x32, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* Toshiba Salellite Pro M10 */
+	{ { 0x33, 0x02, 0x0a }, { ALPS_PROTO_V1, 0x88, 0xf8, 0 } },				/* UMAX-530T */
+	{ { 0x52, 0x01, 0x14 }, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba Tecra A11-11L */
+	{ { 0x53, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x53, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x60, 0x03, 0xc8 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },				/* HP ze1115 */
+	{ { 0x62, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xcf, 0xcf,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
+	{ { 0x63, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x02, 0x28 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },			/* Fujitsu Siemens S6010 */
+	{ { 0x63, 0x02, 0x3c }, { ALPS_PROTO_V2, 0x8f, 0x8f, ALPS_WHEEL } },			/* Toshiba Satellite S2400-103 */
+	{ { 0x63, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xef, 0xef, ALPS_FW_BK_1 } },			/* NEC Versa L320 */
+	{ { 0x63, 0x02, 0x64 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x03, 0xc8 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* Dell Latitude D800 */
+	{ { 0x73, 0x00, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_DUALPOINT } },		/* ThinkPad R61 8918-5QG */
+	{ { 0x73, 0x00, 0x14 }, { ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT } },		/* Dell XT2 */
+	{ { 0x73, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x73, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },			/* Ahtec Laptop */
+	{ { 0x73, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },		/* Dell Vostro 1400 */
 };
 
 static const struct alps_protocol_info alps_v3_protocol_data = {
@@ -2779,12 +2777,8 @@ static const struct alps_protocol_info *alps_match_table(unsigned char *e7,
 	for (i = 0; i < ARRAY_SIZE(alps_model_data); i++) {
 		model = &alps_model_data[i];
 
-		if (!memcmp(e7, model->signature, sizeof(model->signature)) &&
-		    (!model->command_mode_resp ||
-		     model->command_mode_resp == ec[2])) {
-
+		if (!memcmp(e7, model->signature, sizeof(model->signature)))
 			return &model->protocol_info;
-		}
 	}
 
 	return NULL;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 54f9f44..dea3163 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -163,10 +163,6 @@ struct alps_protocol_info {
 /**
  * struct alps_model_info - touchpad ID table
  * @signature: E7 response string to match.
- * @command_mode_resp: For V3/V4 touchpads, the final byte of the EC response
- *   (aka command mode response) identifies the firmware minor version.  This
- *   can be used to distinguish different hardware models which are not
- *   uniquely identifiable through their E7 responses.
  * @protocol_info: information about protocol used by the device.
  *
  * Many (but not all) ALPS touchpads can be identified by looking at the
@@ -175,7 +171,6 @@ struct alps_protocol_info {
  */
 struct alps_model_info {
 	u8 signature[3];
-	u8 command_mode_resp;
 	struct alps_protocol_info protocol_info;
 };
 
-- 
1.7.9.5


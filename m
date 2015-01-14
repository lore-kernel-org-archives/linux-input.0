From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: ALPS - renumber protocol numbers
Date: Wed, 14 Jan 2015 14:55:49 -0800
Message-ID: <1421276154-8689-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:61127 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbbANW4J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 17:56:09 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so25176543igd.2
        for <linux-input@vger.kernel.org>; Wed, 14 Jan 2015 14:56:08 -0800 (PST)
In-Reply-To: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

In order to accommodate new protocol number for Rushmore touchpads
let's shift protocol numbers by 8 bits (i.e. 1 -> 0x100) - this way
we keep protocol version reported in input device id the same as it
was, but add some holes in numbering.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c |  2 +-
 drivers/input/mouse/alps.h | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f719f28..d995523 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2526,7 +2526,7 @@ int alps_detect(struct psmouse *psmouse, bool set_properties)
 		psmouse->vendor = "ALPS";
 		psmouse->name = dummy.flags & ALPS_DUALPOINT ?
 				"DualPoint TouchPad" : "GlidePoint";
-		psmouse->model = dummy.proto_version << 8;
+		psmouse->model = dummy.proto_version;
 	}
 	return 0;
 }
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 66240b4..94645bf 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -14,13 +14,13 @@
 
 #include <linux/input/mt.h>
 
-#define ALPS_PROTO_V1	1
-#define ALPS_PROTO_V2	2
-#define ALPS_PROTO_V3	3
-#define ALPS_PROTO_V4	4
-#define ALPS_PROTO_V5	5
-#define ALPS_PROTO_V6	6
-#define ALPS_PROTO_V7	7	/* t3btl t4s */
+#define ALPS_PROTO_V1		0x100
+#define ALPS_PROTO_V2		0x200
+#define ALPS_PROTO_V3		0x300
+#define ALPS_PROTO_V4		0x400
+#define ALPS_PROTO_V5		0x500
+#define ALPS_PROTO_V6		0x600
+#define ALPS_PROTO_V7		0x700	/* t3btl t4s */
 
 #define MAX_TOUCHES	2
 
@@ -64,11 +64,11 @@ enum V7_PACKET_ID {
  * lists a number of such touchpads.
  */
 struct alps_model_info {
-	unsigned char signature[3];
-	unsigned char command_mode_resp;
-	unsigned char proto_version;
-	unsigned char byte0, mask0;
-	int flags;
+	u8 signature[3];
+	u8 command_mode_resp;
+	u16 proto_version;
+	u8 byte0, mask0;
+	unsigned int flags;
 };
 
 /**
@@ -166,9 +166,9 @@ struct alps_data {
 	/* these are autodetected when the device is identified */
 	const struct alps_nibble_commands *nibble_commands;
 	int addr_command;
-	unsigned char proto_version;
-	unsigned char byte0, mask0;
-	unsigned char fw_ver[3];
+	u16 proto_version;
+	u8 byte0, mask0;
+	u8 fw_ver[3];
 	int flags;
 	int x_max;
 	int y_max;
-- 
2.2.0.rc0.207.ga3a616c


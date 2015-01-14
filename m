From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/6] Input: ALPS - make Rushmore a separate protocol
Date: Wed, 14 Jan 2015 14:55:50 -0800
Message-ID: <1421276154-8689-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:39788 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbANW4L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 17:56:11 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so11769197iec.9
        for <linux-input@vger.kernel.org>; Wed, 14 Jan 2015 14:56:10 -0800 (PST)
In-Reply-To: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

Even though Rushmore is very close to V3 protocol it is sufficiently
different to warrant it's own protocol name.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c | 26 ++++++++++++++++----------
 drivers/input/mouse/alps.h |  1 +
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index d995523..80aa6f8 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -99,7 +99,6 @@ static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
 #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
 					   6-byte ALPS packet */
-#define ALPS_IS_RUSHMORE	0x100	/* device is a rushmore */
 #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
 
 static const struct alps_model_info alps_model_data[] = {
@@ -412,7 +411,7 @@ static int alps_process_bitmap(struct alps_data *priv,
 		(2 * (priv->y_bits - 1));
 
 	/* y-bitmap order is reversed, except on rushmore */
-	if (!(priv->flags & ALPS_IS_RUSHMORE)) {
+	if (priv->proto_version != ALPS_PROTO_V3_RUSHMORE) {
 		fields->mt[0].y = priv->y_max - fields->mt[0].y;
 		fields->mt[1].y = priv->y_max - fields->mt[1].y;
 	}
@@ -1275,7 +1274,7 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 			    psmouse->pktcnt - 1,
 			    psmouse->packet[psmouse->pktcnt - 1]);
 
-		if (priv->proto_version == ALPS_PROTO_V3 &&
+		if (priv->proto_version == ALPS_PROTO_V3_RUSHMORE &&
 		    psmouse->pktcnt == psmouse->pktsize) {
 			/*
 			 * Some Dell boxes, such as Latitude E6440 or E7440
@@ -2182,6 +2181,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->x_max = 1023;
 		priv->y_max = 767;
 		break;
+
 	case ALPS_PROTO_V3:
 		priv->hw_init = alps_hw_init_v3;
 		priv->process_packet = alps_process_packet_v3;
@@ -2190,6 +2190,18 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
 		break;
+
+	case ALPS_PROTO_V3_RUSHMORE:
+		priv->hw_init = alps_hw_init_rushmore_v3;
+		priv->process_packet = alps_process_packet_v3;
+		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->decode_fields = alps_decode_rushmore;
+		priv->nibble_commands = alps_v3_nibble_commands;
+		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
+		priv->x_bits = 16;
+		priv->y_bits = 12;
+		break;
+
 	case ALPS_PROTO_V4:
 		priv->hw_init = alps_hw_init_v4;
 		priv->process_packet = alps_process_packet_v4;
@@ -2313,15 +2325,9 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 
 		return 0;
 	} else if (ec[0] == 0x88 && ec[1] == 0x08) {
-		priv->proto_version = ALPS_PROTO_V3;
+		priv->proto_version = ALPS_PROTO_V3_RUSHMORE;
 		alps_set_defaults(priv);
 
-		priv->hw_init = alps_hw_init_rushmore_v3;
-		priv->decode_fields = alps_decode_rushmore;
-		priv->x_bits = 16;
-		priv->y_bits = 12;
-		priv->flags |= ALPS_IS_RUSHMORE;
-
 		/* hack to make addr_command, nibble_command available */
 		psmouse->private = priv;
 
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 94645bf..f19908a 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -17,6 +17,7 @@
 #define ALPS_PROTO_V1		0x100
 #define ALPS_PROTO_V2		0x200
 #define ALPS_PROTO_V3		0x300
+#define ALPS_PROTO_V3_RUSHMORE	0x310
 #define ALPS_PROTO_V4		0x400
 #define ALPS_PROTO_V5		0x500
 #define ALPS_PROTO_V6		0x600
-- 
2.2.0.rc0.207.ga3a616c


From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 03/14] alps: process_bitmap: Don't invert the Y-axis on Rushmore
Date: Wed,  9 Jul 2014 17:24:08 +0200
Message-ID: <1404919459-23561-4-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554AbaGIPYd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:33 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Rushmore models don't have the Y-axis data in the bitmap inverted. Since
we now have 2 different Y orientations, make the Y bitmap data processing
use a forward loop like the X bitmap data processing, unifying the 2,
and invert the data later, except on Rushmore.

So far no-one has noticed this because the synaptics driver only uses the non
mt coordinates (except on clickpads, and there are no alps clickpads using
process_bitmap).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 17 ++++++++++-------
 drivers/input/mouse/alps.h |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index b69205e..5768fb6 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -99,6 +99,7 @@ static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
 #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
 					   6-byte ALPS packet */
+#define ALPS_IS_RUSHMORE	0x100	/* device is a rushmore */
 
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },	/* Toshiba Salellite Pro M10 */
@@ -376,15 +377,10 @@ static int alps_process_bitmap(struct alps_data *priv,
 		prev_bit = bit;
 	}
 
-	/*
-	 * y bitmap is reversed for what we need (lower positions are in
-	 * higher bits), so we process from the top end.
-	 */
-	y_map = y_map << (sizeof(y_map) * BITS_PER_BYTE - priv->y_bits);
 	prev_bit = 0;
 	point = &y_low;
-	for (i = 0; y_map != 0; i++, y_map <<= 1) {
-		bit = y_map & (1 << (sizeof(y_map) * BITS_PER_BYTE - 1));
+	for (i = 0; y_map != 0; i++, y_map >>= 1) {
+		bit = y_map & 1;
 		if (bit) {
 			if (!prev_bit) {
 				point->start_bit = i;
@@ -435,6 +431,12 @@ static int alps_process_bitmap(struct alps_data *priv,
 	       (2 * y_high.start_bit + y_high.num_bits - 1)) /
 	      (2 * (priv->y_bits - 1));
 
+	/* y-bitmap order is reversed, except on rushmore */
+	if (!(priv->flags & ALPS_IS_RUSHMORE)) {
+		*y1 = priv->y_max - *y1;
+		*y2 = priv->y_max - *y2;
+	}
+
 	return fingers;
 }
 
@@ -1981,6 +1983,7 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		priv->decode_fields = alps_decode_rushmore;
 		priv->x_bits = 16;
 		priv->y_bits = 12;
+		priv->flags |= ALPS_IS_RUSHMORE;
 
 		/* hack to make addr_command, nibble_command available */
 		psmouse->private = priv;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 03f88b6..6d2666c 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -46,7 +46,7 @@ struct alps_model_info {
 	unsigned char command_mode_resp;
 	unsigned char proto_version;
 	unsigned char byte0, mask0;
-	unsigned char flags;
+	int flags;
 };
 
 /**
@@ -142,7 +142,7 @@ struct alps_data {
 	int addr_command;
 	unsigned char proto_version;
 	unsigned char byte0, mask0;
-	unsigned char flags;
+	int flags;
 	int x_max;
 	int y_max;
 	int x_bits;
-- 
2.0.0


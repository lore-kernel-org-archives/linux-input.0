From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 1/2] input: rotary-encoder: refactor and clean up
Date: Tue,  5 Apr 2011 20:15:12 +0200
Message-ID: <1302027313-27130-2-git-send-email-jhovold@gmail.com>
References: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54438 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab1DESPr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 14:15:47 -0400
Received: by eyx24 with SMTP id 24so205122eyx.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 11:15:46 -0700 (PDT)
In-Reply-To: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Refactor state retrieval and event reporting in interrupt handler.
Remove a few empty lines.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/input/misc/rotary_encoder.c |   83 ++++++++++++++++++++--------------
 1 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 7e64d01..253e502 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -40,58 +40,74 @@ struct rotary_encoder {
 	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
 };
 
-static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
+static int rotary_encoder_get_state(struct rotary_encoder_platform_data *pdata)
 {
-	struct rotary_encoder *encoder = dev_id;
-	struct rotary_encoder_platform_data *pdata = encoder->pdata;
 	int a = !!gpio_get_value(pdata->gpio_a);
 	int b = !!gpio_get_value(pdata->gpio_b);
-	int state;
 
 	a ^= pdata->inverted_a;
 	b ^= pdata->inverted_b;
-	state = (a << 1) | b;
 
-	switch (state) {
+	return ((a << 1) | b);
+}
 
-	case 0x0:
-		if (!encoder->armed)
-			break;
+static void rotary_encoder_report_event(struct rotary_encoder *encoder)
+{
+	struct rotary_encoder_platform_data *pdata = encoder->pdata;
+	unsigned pos;
+	int value;
 
-		if (pdata->relative_axis) {
-			input_report_rel(encoder->input, pdata->axis,
-					 encoder->dir ? -1 : 1);
-		} else {
-			unsigned int pos = encoder->pos;
-
-			if (encoder->dir) {
-				/* turning counter-clockwise */
-				if (pdata->rollover)
-					pos += pdata->steps;
-				if (pos)
-					pos--;
-			} else {
-				/* turning clockwise */
-				if (pdata->rollover || pos < pdata->steps)
-					pos++;
-			}
+	if (pdata->relative_axis) {
+		if (encoder->dir)
+			value = -1;
+		else
+			value = 1;
+
+		input_report_rel(encoder->input, pdata->axis, value);
+	} else {
+		pos = encoder->pos;
+
+		if (encoder->dir) {
+			/* turning counter-clockwise */
 			if (pdata->rollover)
-				pos %= pdata->steps;
-			encoder->pos = pos;
-			input_report_abs(encoder->input, pdata->axis,
-					 encoder->pos);
+				pos += pdata->steps;
+			if (pos)
+				pos--;
+		} else {
+			/* turning clockwise */
+			if (pdata->rollover || pos < pdata->steps)
+				pos++;
 		}
-		input_sync(encoder->input);
 
+		if (pdata->rollover)
+			pos %= pdata->steps;
+
+		encoder->pos = pos;
+		input_report_abs(encoder->input, pdata->axis, encoder->pos);
+	}
+
+	input_sync(encoder->input);
+}
+
+static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
+{
+	struct rotary_encoder *encoder = dev_id;
+	int state;
+
+	state = rotary_encoder_get_state(encoder->pdata);
+
+	switch (state) {
+	case 0x0:
+		if (!encoder->armed)
+			break;
+		rotary_encoder_report_event(encoder);
 		encoder->armed = false;
 		break;
-
 	case 0x1:
 	case 0x2:
 		if (encoder->armed)
 			encoder->dir = state - 1;
 		break;
-
 	case 0x3:
 		encoder->armed = true;
 		break;
@@ -254,4 +270,3 @@ MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_DESCRIPTION("GPIO rotary encoder driver");
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_LICENSE("GPL v2");
-
-- 
1.7.4.1


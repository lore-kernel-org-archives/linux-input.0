From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] input: rotary encoder: implement quarter period mode
Date: Wed, 18 Dec 2013 15:43:18 +0100
Message-ID: <1387377798-22344-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54683 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3LROnW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Dec 2013 09:43:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@zonque.org>, devicetree@vger.kernel.org

Some rotary encoders have a stable state in all output state
combinations. Add support for this type of encoder.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
 Documentation/input/rotary-encoder.txt             |  9 +++++--
 drivers/input/misc/rotary_encoder.c                | 30 ++++++++++++++++++++--
 include/linux/rotary_encoder.h                     |  1 +
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 3315495..cbdb29b 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -15,6 +15,7 @@ Optional properties:
 - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
 - rotary-encoder,half-period: Makes the driver work on half-period mode.
+- rotary-encoder,quarter-period: Makes the driver work on quarter-period mode.
 
 See Documentation/input/rotary-encoder.txt for more information.
 
diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 92e68bc..0bbff7e 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -9,8 +9,10 @@ peripherals with two wires. The outputs are phase-shifted by 90 degrees
 and by triggering on falling and rising edges, the turn direction can
 be determined.
 
-Some encoders have both outputs low in stable states, whereas others also have
-a stable state with both outputs high (half-period mode).
+
+Some encoders have both outputs low in stable states, others also have
+a stable state with both outputs high (half-period mode) and some have
+a stable state in all steps (quarter-period mode).
 
 The phase diagram of these two outputs look like this:
 
@@ -32,6 +34,9 @@ The phase diagram of these two outputs look like this:
                 |<-->|
 	          one step (half-period mode)
 
+                |<>|
+	          one step (quarter-period mode)
+
 For more information, please see
 	http://en.wikipedia.org/wiki/Rotary_encoder
 
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 5b1aff8..264501c 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -42,7 +42,7 @@ struct rotary_encoder {
 	bool armed;
 	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
 
-	char last_stable;
+	int last_stable;
 };
 
 static int rotary_encoder_get_state(const struct rotary_encoder_platform_data *pdata)
@@ -117,6 +117,28 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *dev_id)
+{
+	struct rotary_encoder *encoder = dev_id;
+	int state;
+	static const u8 states[4][4] = {
+		{ -1,  1,  0, -1 },
+		{  0, -1, -1,  1 },
+		{  1, -1, -1,  0 },
+		{ -1,  0,  1, -1 },
+	};
+
+	state = rotary_encoder_get_state(encoder->pdata);
+
+	encoder->dir = states[encoder->last_stable][state];
+	encoder->last_stable = state;
+
+	if (encoder->dir >= 0)
+		rotary_encoder_report_event(encoder);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 {
 	struct rotary_encoder *encoder = dev_id;
@@ -180,7 +202,8 @@ static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct devic
 					"rotary-encoder,rollover", NULL);
 	pdata->half_period = !!of_get_property(np,
 					"rotary-encoder,half-period", NULL);
-
+	pdata->quarter_period = !!of_get_property(np,
+					"rotary-encoder,quarter-period", NULL);
 	return pdata;
 }
 #else
@@ -254,6 +277,9 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	if (pdata->half_period) {
 		handler = &rotary_encoder_half_period_irq;
 		encoder->last_stable = rotary_encoder_get_state(pdata);
+	} else if (pdata->quarter_period) {
+		handler = &rotary_encoder_quarter_period_irq;
+		encoder->last_stable = rotary_encoder_get_state(pdata);
 	} else {
 		handler = &rotary_encoder_irq;
 	}
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index 3f594dc..fd0a70f 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -11,6 +11,7 @@ struct rotary_encoder_platform_data {
 	bool relative_axis;
 	bool rollover;
 	bool half_period;
+	bool quarter_period;
 };
 
 #endif /* __ROTARY_ENCODER_H__ */
-- 
1.8.5.1


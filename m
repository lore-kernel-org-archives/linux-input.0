From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 1/1] Input: rotary-encoder: Add 'stepped' irq handler
Date: Sat, 28 Sep 2013 15:26:38 -0300
Message-ID: <1380392798-23345-2-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1380392798-23345-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:44236 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3I1S1N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 14:27:13 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so3995647wgh.17
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 11:27:12 -0700 (PDT)
In-Reply-To: <1380392798-23345-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some rotary-encoder devices (such as those with detents) are capable
of producing a stable event on each step. This commit adds support
for this case, by implementing a new interruption handler.

The handler needs only detect the direction of the turn and generate
an event according to this detection.

Cc: Daniel Mack <zonque@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/input/misc/rotary_encoder.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/rotary_encoder.h      |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 5b1aff8..8802221 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -117,6 +117,37 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rotary_encoder_stepped_irq(int irq, void *dev_id)
+{
+	struct rotary_encoder *encoder = dev_id;
+	int state, sum;
+
+	state = rotary_encoder_get_state(encoder->pdata);
+
+	/*
+	 * We encode the previous and the current state,
+	 * in the 'sum' variable and then use a table
+	 * to decide the direction of the turn.
+	 */
+	sum = (encoder->last_stable << 2) + state;
+	switch (sum) {
+	case 0b1101:
+	case 0b0100:
+	case 0b0010:
+	case 0b1011:
+		encoder->dir = 0; /* clockwise */
+		break;
+	default:
+		encoder->dir = 1;
+	}
+
+	rotary_encoder_report_event(encoder);
+
+	encoder->last_stable = state;
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 {
 	struct rotary_encoder *encoder = dev_id;
@@ -254,6 +285,9 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	if (pdata->half_period) {
 		handler = &rotary_encoder_half_period_irq;
 		encoder->last_stable = rotary_encoder_get_state(pdata);
+	} else if (pdata->on_each_step) {
+		handler = &rotary_encoder_stepped_irq;
+		encoder->last_stable = rotary_encoder_get_state(pdata);
 	} else {
 		handler = &rotary_encoder_irq;
 	}
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index 3f594dc..499f6f7 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -11,6 +11,7 @@ struct rotary_encoder_platform_data {
 	bool relative_axis;
 	bool rollover;
 	bool half_period;
+	bool on_each_step;
 };
 
 #endif /* __ROTARY_ENCODER_H__ */
-- 
1.8.1.5


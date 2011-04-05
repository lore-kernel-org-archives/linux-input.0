From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 2/2 v2] input: rotary-encoder: add support for half-period encoders
Date: Tue,  5 Apr 2011 21:39:41 +0200
Message-ID: <1302032381-31453-1-git-send-email-jhovold@gmail.com>
References: <1302027313-27130-3-git-send-email-jhovold@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37356 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1DETkH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 15:40:07 -0400
Received: by ewy4 with SMTP id 4so226818ewy.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 12:40:06 -0700 (PDT)
In-Reply-To: <1302027313-27130-3-git-send-email-jhovold@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Add support for encoders that have two detents per input signal period.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---

v2: fix typo in documentation (s/inputs/outputs/)

 Documentation/input/rotary-encoder.txt |   13 ++++++++++
 drivers/input/misc/rotary_encoder.c    |   41 +++++++++++++++++++++++++++++--
 include/linux/rotary_encoder.h         |    1 +
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 8b4129d..64fbed0 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -9,6 +9,9 @@ peripherals with two wires. The outputs are phase-shifted by 90 degrees
 and by triggering on falling and rising edges, the turn direction can
 be determined.
 
+Some encoders have both outputs low in stable states, whereas others also have
+a stable state with both ouputs high (half-period mode).
+
 The phase diagram of these two outputs look like this:
 
                   _____       _____       _____
@@ -26,6 +29,8 @@ The phase diagram of these two outputs look like this:
                 |<-------->|
 	          one step
 
+                |<-->|
+	          one step (half-period mode)
 
 For more information, please see
 	http://en.wikipedia.org/wiki/Rotary_encoder
@@ -34,6 +39,13 @@ For more information, please see
 1. Events / state machine
 -------------------------
 
+In half-period mode, state a) and c) above are used to determine the
+rotational direction based on the last stable state. Events are reported in
+states b) and d) given that the new stable state is different from the last
+(i.e. the rotation was not reversed half-way).
+
+Otherwise, the following apply:
+
 a) Rising edge on channel A, channel B in low state
 	This state is used to recognize a clockwise turn
 
@@ -96,6 +108,7 @@ static struct rotary_encoder_platform_data my_rotary_encoder_info = {
 	.gpio_b		= GPIO_ROTARY_B,
 	.inverted_a	= 0,
 	.inverted_b	= 0,
+	.half_period	= false,
 };
 
 static struct platform_device rotary_encoder_device = {
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 253e502..ce329a6 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -2,6 +2,7 @@
  * rotary_encoder.c
  *
  * (c) 2009 Daniel Mack <daniel@caiaq.de>
+ * Copyright (C) 2011 Johan Hovold <jhovold@gmail.com>
  *
  * state machine code inspired by code from Tim Ruetz
  *
@@ -38,6 +39,8 @@ struct rotary_encoder {
 
 	bool armed;
 	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
+
+	char last_stable;
 };
 
 static int rotary_encoder_get_state(struct rotary_encoder_platform_data *pdata)
@@ -116,11 +119,36 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
+{
+	struct rotary_encoder *encoder = dev_id;
+	int state;
+
+	state = rotary_encoder_get_state(encoder->pdata);
+
+	switch (state) {
+	case 0x00:
+	case 0x03:
+		if (state == encoder->last_stable)
+			break;
+		rotary_encoder_report_event(encoder);
+		encoder->last_stable = state;
+		break;
+	case 0x01:
+	case 0x02:
+		encoder->dir = (encoder->last_stable + state) & 0x01;
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 {
 	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
+	irq_handler_t handler;
 	int err;
 
 	if (!pdata) {
@@ -191,7 +219,14 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	}
 
 	/* request the IRQs */
-	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
+	if (pdata->half_period) {
+		handler = &rotary_encoder_half_period_irq;
+		encoder->last_stable = rotary_encoder_get_state(pdata);
+	} else {
+		handler = &rotary_encoder_irq;
+	}
+
+	err = request_irq(encoder->irq_a, handler,
 			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  DRV_NAME, encoder);
 	if (err) {
@@ -200,7 +235,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 		goto exit_free_gpio_b;
 	}
 
-	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
+	err = request_irq(encoder->irq_b, handler,
 			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  DRV_NAME, encoder);
 	if (err) {
@@ -268,5 +303,5 @@ module_exit(rotary_encoder_exit);
 
 MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_DESCRIPTION("GPIO rotary encoder driver");
-MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
+MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>, Johan Hovold");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index 215278b..3f594dc 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -10,6 +10,7 @@ struct rotary_encoder_platform_data {
 	unsigned int inverted_b;
 	bool relative_axis;
 	bool rollover;
+	bool half_period;
 };
 
 #endif /* __ROTARY_ENCODER_H__ */
-- 
1.7.4.1


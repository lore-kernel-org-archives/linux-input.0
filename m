From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH 2/2] input: qt2160: Add support for LEDs.
Date: Tue, 16 Oct 2012 17:19:31 +0200
Message-ID: <1350400771-7950-2-git-send-email-javier.martin@vista-silicon.com>
References: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34009 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab2JPPTn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Oct 2012 11:19:43 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so5515908wgb.1
        for <linux-input@vger.kernel.org>; Tue, 16 Oct 2012 08:19:42 -0700 (PDT)
In-Reply-To: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: axel.lin@gmail.com, dmitry.torokhov@gmail.com, Javier Martin <javier.martin@vista-silicon.com>

Outputs x8..x0 of the qt2160 can have leds attached to it.
This patch handles those outputs using EV_LED events.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/input/keyboard/qt2160.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 73ea4b0..7070372 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -39,6 +39,7 @@
 #define QT2160_CMD_GPIOS      6
 #define QT2160_CMD_SUBVER     7
 #define QT2160_CMD_CALIBRATE  10
+#define QT2160_CMD_LEDS       70
 
 #define QT2160_CYCLE_INTERVAL	(2*HZ)
 
@@ -217,6 +218,30 @@ static int __devinit qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 	return ret;
 }
 
+static int qt2160_event(struct input_dev *dev,
+			unsigned int type, unsigned int code, int value)
+{
+	struct qt2160_data *qt2160 = input_get_drvdata(dev);
+	struct i2c_client *client = qt2160->client;
+	u32 val;
+
+	switch (type) {
+	case EV_LED:
+		val = qt2160_read(qt2160->client, QT2160_CMD_LEDS);
+		if (value)
+			val |= (1 << code);
+		else
+			val &= ~(1 << code);
+		qt2160_write(qt2160->client, QT2160_CMD_LEDS, val);
+		break;
+	default:
+		dev_err(&client->dev, "%s: Got type %d, code %d, value %d\n",
+		       __func__, type, code, value);
+		return -1;
+	}
+
+	return 0;
+}
 
 static bool __devinit qt2160_identify(struct i2c_client *client)
 {
@@ -290,8 +315,21 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 	input->keycodesize = sizeof(qt2160->keycodes[0]);
 	input->keycodemax = ARRAY_SIZE(qt2160_key2code);
 
+	input->event = qt2160_event;
+
+	input_set_drvdata(input, qt2160);
+
 	__set_bit(EV_KEY, input->evbit);
 	__clear_bit(EV_REP, input->evbit);
+	__set_bit(EV_LED, input->evbit);
+	__set_bit(LED_NUML, input->ledbit);
+	__set_bit(LED_CAPSL, input->ledbit);
+	__set_bit(LED_SCROLLL, input->ledbit);
+	__set_bit(LED_COMPOSE, input->ledbit);
+	__set_bit(LED_KANA, input->ledbit);
+	__set_bit(LED_SLEEP, input->ledbit);
+	__set_bit(LED_SUSPEND, input->ledbit);
+	__set_bit(LED_MUTE, input->ledbit);
 	for (i = 0; i < ARRAY_SIZE(qt2160_key2code); i++) {
 		qt2160->keycodes[i] = qt2160_key2code[i];
 		__set_bit(qt2160_key2code[i], input->keybit);
-- 
1.7.9.5


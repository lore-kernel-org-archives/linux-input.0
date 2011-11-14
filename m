From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: migor-ts - convert to a threaded IRQ
Date: Mon, 14 Nov 2011 00:33:41 -0800
Message-ID: <1321259623-10887-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37120 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab1KNIdr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:33:47 -0500
Received: by gyc15 with SMTP id 15so4642913gyc.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:33:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/migor_ts.c |   65 ++++++++++++---------------------
 1 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
index 5803bd0..af746b7 100644
--- a/drivers/input/touchscreen/migor_ts.c
+++ b/drivers/input/touchscreen/migor_ts.c
@@ -36,7 +36,6 @@
 struct migor_ts_priv {
 	struct i2c_client *client;
 	struct input_dev *input;
-	struct delayed_work work;
 	int irq;
 };
 
@@ -44,15 +43,24 @@ static const u_int8_t migor_ts_ena_seq[17] = { 0x33, 0x22, 0x11,
 					       0x01, 0x06, 0x07, };
 static const u_int8_t migor_ts_dis_seq[17] = { };
 
-static void migor_ts_poscheck(struct work_struct *work)
+static irqreturn_t migor_ts_isr(int irq, void *dev_id)
 {
-	struct migor_ts_priv *priv = container_of(work,
-						  struct migor_ts_priv,
-						  work.work);
+	struct migor_ts_priv *priv = dev_id;
 	unsigned short xpos, ypos;
 	unsigned char event;
 	u_int8_t buf[16];
 
+	/*
+	 * The touch screen controller chip is hooked up to the CPU
+	 * using I2C and a single interrupt line. The interrupt line
+	 * is pulled low whenever someone taps the screen. To deassert
+	 * the interrupt line we need to acknowledge the interrupt by
+	 * communicating with the controller over the slow i2c bus.
+	 *
+	 * Since I2C bus controller may sleep we are using threaded
+	 * IRQ here.
+	 */
+
 	memset(buf, 0, sizeof(buf));
 
 	/* Set Index 0 */
@@ -72,41 +80,25 @@ static void migor_ts_poscheck(struct work_struct *work)
 	xpos = ((buf[11] & 0x03) << 8 | buf[10]);
 	event = buf[12];
 
-	if (event == EVENT_PENDOWN || event == EVENT_REPEAT) {
+	switch (event) {
+	case EVENT_PENDOWN:
+	case EVENT_REPEAT:
 		input_report_key(priv->input, BTN_TOUCH, 1);
 		input_report_abs(priv->input, ABS_X, ypos); /*X-Y swap*/
 		input_report_abs(priv->input, ABS_Y, xpos);
 		input_sync(priv->input);
-	} else if (event == EVENT_PENUP) {
+		break;
+
+	case EVENT_PENUP:
 		input_report_key(priv->input, BTN_TOUCH, 0);
 		input_sync(priv->input);
+		break;
 	}
- out:
-	enable_irq(priv->irq);
-}
-
-static irqreturn_t migor_ts_isr(int irq, void *dev_id)
-{
-	struct migor_ts_priv *priv = dev_id;
-
-	/* the touch screen controller chip is hooked up to the cpu
-	 * using i2c and a single interrupt line. the interrupt line
-	 * is pulled low whenever someone taps the screen. to deassert
-	 * the interrupt line we need to acknowledge the interrupt by
-	 * communicating with the controller over the slow i2c bus.
-	 *
-	 * we can't acknowledge from interrupt context since the i2c
-	 * bus controller may sleep, so we just disable the interrupt
-	 * here and handle the acknowledge using delayed work.
-	 */
-
-	disable_irq_nosync(irq);
-	schedule_delayed_work(&priv->work, HZ / 20);
 
+ out:
 	return IRQ_HANDLED;
 }
 
-
 static int migor_ts_open(struct input_dev *dev)
 {
 	struct migor_ts_priv *priv = input_get_drvdata(dev);
@@ -131,15 +123,6 @@ static void migor_ts_close(struct input_dev *dev)
 
 	disable_irq(priv->irq);
 
-	/* cancel pending work and wait for migor_ts_poscheck() to finish */
-	if (cancel_delayed_work_sync(&priv->work)) {
-		/*
-		 * if migor_ts_poscheck was canceled we need to enable IRQ
-		 * here to balance disable done in migor_ts_isr.
-		 */
-		enable_irq(priv->irq);
-	}
-
 	/* disable controller */
 	i2c_master_send(client, migor_ts_dis_seq, sizeof(migor_ts_dis_seq));
 
@@ -186,15 +169,15 @@ static int migor_ts_probe(struct i2c_client *client,
 
 	priv->client = client;
 	priv->input = input;
-	INIT_DELAYED_WORK(&priv->work, migor_ts_poscheck);
 	priv->irq = client->irq;
 
 	error = input_register_device(input);
 	if (error)
 		goto err1;
 
-	error = request_irq(priv->irq, migor_ts_isr, IRQF_TRIGGER_LOW,
-			    client->name, priv);
+	error = request_threaded_irq(priv->irq, NULL, migor_ts_isr,
+                                     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+                                     client->name, priv);
 	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
 		goto err2;
-- 
1.7.6.4


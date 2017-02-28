From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 08/10] Input: eeti_ts - switch to using threaded interrupt
Date: Tue, 28 Feb 2017 14:46:30 -0800
Message-ID: <20170228224632.3401-8-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36491 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdB1W5Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 17:57:16 -0500
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Instead of having standard interrupt handler and manually firing work item
to perform I2C reads, let's switch to threaded interrupts, which were
designed specifically for this purpose.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/eeti_ts.c | 79 +++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index fc61dbea4736..ee6b87c606ef 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -47,9 +47,8 @@ MODULE_PARM_DESC(flip_y, "flip y coordinate");
 struct eeti_ts {
 	struct i2c_client *client;
 	struct input_dev *input;
-	struct work_struct work;
-	struct mutex mutex;
 	int irq_gpio, irq_active_high;
+	bool running;
 };
 
 #define EETI_TS_BITDEPTH	(11)
@@ -66,29 +65,11 @@ static inline int eeti_ts_irq_active(struct eeti_ts *eeti)
 	return gpio_get_value_cansleep(eeti->irq_gpio) == eeti->irq_active_high;
 }
 
-static void eeti_ts_read(struct work_struct *work)
+static void eeti_ts_report_event(struct eeti_ts *eeti, u8 *buf)
 {
-	char buf[6];
-	unsigned int x, y, res, pressed, to = 100;
-	struct eeti_ts *eeti =
-		container_of(work, struct eeti_ts, work);
-
-	mutex_lock(&eeti->mutex);
-
-	while (eeti_ts_irq_active(eeti) && --to)
-		i2c_master_recv(eeti->client, buf, sizeof(buf));
-
-	if (!to) {
-		dev_err(&eeti->client->dev,
-			"unable to clear IRQ - line stuck?\n");
-		goto out;
-	}
+	unsigned int res;
+	u16 x, y;
 
-	/* drop non-report packets */
-	if (!(buf[0] & 0x80))
-		goto out;
-
-	pressed = buf[0] & REPORT_BIT_PRESSED;
 	res = REPORT_RES_BITS(buf[0] & (REPORT_BIT_AD0 | REPORT_BIT_AD1));
 
 	x = get_unaligned_be16(&buf[1]);
@@ -109,35 +90,48 @@ static void eeti_ts_read(struct work_struct *work)
 
 	input_report_abs(eeti->input, ABS_X, x);
 	input_report_abs(eeti->input, ABS_Y, y);
-	input_report_key(eeti->input, BTN_TOUCH, !!pressed);
+	input_report_key(eeti->input, BTN_TOUCH, buf[0] & REPORT_BIT_PRESSED);
 	input_sync(eeti->input);
-
-out:
-	mutex_unlock(&eeti->mutex);
 }
 
 static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
 {
 	struct eeti_ts *eeti = dev_id;
+	int len;
+	int error;
+	char buf[6];
 
-	 /* postpone I2C transactions as we are atomic */
-	schedule_work(&eeti->work);
+	do {
+		len = i2c_master_recv(eeti->client, buf, sizeof(buf));
+		if (len != sizeof(buf)) {
+			error = len < 0 ? len : -EIO;
+			dev_err(&eeti->client->dev,
+				"failed to read touchscreen data: %d\n",
+				error);
+			break;
+		}
+
+		if (buf[0] & 0x80) {
+			/* Motion packet */
+			eeti_ts_report_event(eeti, buf);
+		}
+	} while (eeti->running && eeti_ts_irq_active(eeti));
 
 	return IRQ_HANDLED;
 }
 
 static void eeti_ts_start(struct eeti_ts *eeti)
 {
+	eeti->running = true;
+	wmb();
 	enable_irq(eeti->client->irq);
-
-	/* Read the events once to arm the IRQ */
-	eeti_ts_read(&eeti->work);
 }
 
 static void eeti_ts_stop(struct eeti_ts *eeti)
 {
+	eeti->running = false;
+	wmb();
 	disable_irq(eeti->client->irq);
-	cancel_work_sync(&eeti->work);
 }
 
 static int eeti_ts_open(struct input_dev *dev)
@@ -179,8 +173,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	mutex_init(&eeti->mutex);
-
 	input = devm_input_allocate_device(dev);
 	if (!input) {
 		dev_err(dev, "Failed to allocate input device.\n");
@@ -210,18 +202,15 @@ static int eeti_ts_probe(struct i2c_client *client,
 	eeti->irq_active_high = pdata->irq_active_high;
 
 	irq_flags = eeti->irq_active_high ?
-		IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
+		IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW;
 
-	INIT_WORK(&eeti->work, eeti_ts_read);
 	i2c_set_clientdata(client, eeti);
 	input_set_drvdata(input, eeti);
 
-	error = input_register_device(input);
-	if (error)
-		return error;
-
-	error = devm_request_irq(dev, client->irq, eeti_ts_isr, irq_flags,
-				 client->name, eeti);
+	error = devm_request_threaded_irq(dev, client->irq,
+					  NULL, eeti_ts_isr,
+					  irq_flags | IRQF_ONESHOT,
+					  client->name, eeti);
 	if (error) {
 		dev_err(dev, "Unable to request touchscreen IRQ: %d\n",
 			error);
@@ -234,6 +223,10 @@ static int eeti_ts_probe(struct i2c_client *client,
 	 */
 	eeti_ts_stop(eeti);
 
+	error = input_register_device(input);
+	if (error)
+		return error;
+
 	return 0;
 }
 
-- 
2.11.0.483.g087da7b7c-goog


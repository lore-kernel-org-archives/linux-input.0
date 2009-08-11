From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] input: eeti_ts: allow active high irq lines
Date: Tue, 11 Aug 2009 17:52:52 +0200
Message-ID: <1250005972-27095-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:49457 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZHKPxC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2009 11:53:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>

This adds a struct eeti_ts_platform_data which currently holds only one
value to specify the interrupt polarity.

The driver has a fallback if no platform data is passed in via the
i2c_board_info, so no regression is caused.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 drivers/input/touchscreen/eeti_ts.c |   22 +++++++++++++++++++---
 include/linux/input/eeti_ts.h       |    9 +++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/input/eeti_ts.h

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 3ab9222..9029bd3 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -32,6 +32,7 @@
 #include <linux/i2c.h>
 #include <linux/timer.h>
 #include <linux/gpio.h>
+#include <linux/input/eeti_ts.h>
 
 static int flip_x;
 module_param(flip_x, bool, 0644);
@@ -46,7 +47,7 @@ struct eeti_ts_priv {
 	struct input_dev *input;
 	struct work_struct work;
 	struct mutex mutex;
-	int irq;
+	int irq, irq_active_high;
 };
 
 #define EETI_TS_BITDEPTH	(11)
@@ -58,6 +59,11 @@ struct eeti_ts_priv {
 #define REPORT_BIT_HAS_PRESSURE	(1 << 6)
 #define REPORT_RES_BITS(v)	(((v) >> 1) + EETI_TS_BITDEPTH)
 
+static inline int eeti_ts_irq_active(struct eeti_ts_priv *priv)
+{
+	return gpio_get_value(irq_to_gpio(priv->irq)) == priv->irq_active_high;
+}
+
 static void eeti_ts_read(struct work_struct *work)
 {
 	char buf[6];
@@ -67,7 +73,7 @@ static void eeti_ts_read(struct work_struct *work)
 
 	mutex_lock(&priv->mutex);
 
-	while (!gpio_get_value(irq_to_gpio(priv->irq)) && --to)
+	while (eeti_ts_irq_active(priv) && --to)
 		i2c_master_recv(priv->client, buf, sizeof(buf));
 
 	if (!to) {
@@ -140,8 +146,10 @@ static void eeti_ts_close(struct input_dev *dev)
 static int __devinit eeti_ts_probe(struct i2c_client *client,
 				   const struct i2c_device_id *idp)
 {
+	struct eeti_ts_platform_data *pdata;
 	struct eeti_ts_priv *priv;
 	struct input_dev *input;
+	unsigned int irq_flags;
 	int err = -ENOMEM;
 
 	/* In contrast to what's described in the datasheet, there seems
@@ -180,6 +188,14 @@ static int __devinit eeti_ts_probe(struct i2c_client *client,
 	priv->input = input;
 	priv->irq = client->irq;
 
+	pdata = client->dev.platform_data;
+
+	if (pdata)
+		priv->irq_active_high = pdata->irq_active_high;
+
+	irq_flags = priv->irq_active_high ?
+		IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
+
 	INIT_WORK(&priv->work, eeti_ts_read);
 	i2c_set_clientdata(client, priv);
 	input_set_drvdata(input, priv);
@@ -188,7 +204,7 @@ static int __devinit eeti_ts_probe(struct i2c_client *client,
 	if (err)
 		goto err1;
 
-	err = request_irq(priv->irq, eeti_ts_isr, IRQF_TRIGGER_FALLING,
+	err = request_irq(priv->irq, eeti_ts_isr, irq_flags,
 			  client->name, priv);
 	if (err) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
diff --git a/include/linux/input/eeti_ts.h b/include/linux/input/eeti_ts.h
new file mode 100644
index 0000000..f875b31
--- /dev/null
+++ b/include/linux/input/eeti_ts.h
@@ -0,0 +1,9 @@
+#ifndef LINUX_INPUT_EETI_TS_H
+#define LINUX_INPUT_EETI_TS_H
+
+struct eeti_ts_platform_data {
+	unsigned int irq_active_high;
+};
+
+#endif /* LINUX_INPUT_EETI_TS_H */
+
-- 
1.6.3.3


From: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Subject: [PATCH v2] input:bu21013:added the regulator support
Date: Wed, 12 Jan 2011 17:33:37 +0530
Message-ID: <1294833817-2655-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:41117 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755841Ab1ALMEh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 07:04:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org, rydberg@euromail.se, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

Added the regulator support in ROHM BU21013 touch
panel driver.

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
---
Changes in v2:
	Updated the Dmitry and Marc comments on v1 patch

 drivers/input/touchscreen/bu21013_ts.c |   35 +++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index f7fa9ef..d58b421 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -12,6 +12,7 @@
 #include <linux/input.h>
 #include <linux/input/bu21013.h>
 #include <linux/slab.h>
+#include <linux/regulator/consumer.h>
 
 #define PEN_DOWN_INTR	0
 #define MAX_FINGERS	2
@@ -139,6 +140,7 @@
  * @chip: pointer to the touch panel controller
  * @in_dev: pointer to the input device structure
  * @intr_pin: interrupt pin value
+ * @regulator: pointer to the Regulator used for touch screen
  *
  * Touch panel device data structure
  */
@@ -149,6 +151,7 @@ struct bu21013_ts_data {
 	const struct bu21013_platform_device *chip;
 	struct input_dev *in_dev;
 	unsigned int intr_pin;
+	struct regulator *regulator;
 };
 
 /**
@@ -456,6 +459,20 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	bu21013_data->in_dev = in_dev;
 	bu21013_data->chip = pdata;
 	bu21013_data->client = client;
+
+	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
+	if (IS_ERR(bu21013_data->regulator)) {
+		dev_err(&client->dev, "regulator_get failed\n");
+		bu21013_data->regulator = NULL;
+		goto err_free_mem;
+	} else {
+		error = regulator_enable(bu21013_data->regulator);
+		if (error < 0) {
+			dev_err(&client->dev, "regulator enable failed\n");
+			goto err_get_regulator;
+		}
+	}
+
 	bu21013_data->touch_stopped = false;
 	init_waitqueue_head(&bu21013_data->wait);
 
@@ -464,7 +481,7 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 		error = pdata->cs_en(pdata->cs_pin);
 		if (error < 0) {
 			dev_err(&client->dev, "chip init failed\n");
-			goto err_free_mem;
+			goto err_free_regulator;
 		}
 	}
 
@@ -513,6 +530,10 @@ err_free_irq:
 	bu21013_free_irq(bu21013_data);
 err_cs_disable:
 	pdata->cs_dis(pdata->cs_pin);
+err_free_regulator:
+	regulator_disable(bu21013_data->regulator);
+err_get_regulator:
+	regulator_put(bu21013_data->regulator);
 err_free_mem:
 	input_free_device(in_dev);
 	kfree(bu21013_data);
@@ -535,6 +556,10 @@ static int __devexit bu21013_remove(struct i2c_client *client)
 	bu21013_data->chip->cs_dis(bu21013_data->chip->cs_pin);
 
 	input_unregister_device(bu21013_data->in_dev);
+
+	regulator_disable(bu21013_data->regulator);
+	regulator_put(bu21013_data->regulator);
+
 	kfree(bu21013_data);
 
 	device_init_wakeup(&client->dev, false);
@@ -561,6 +586,8 @@ static int bu21013_suspend(struct device *dev)
 	else
 		disable_irq(bu21013_data->chip->irq);
 
+	regulator_disable(bu21013_data->regulator);
+
 	return 0;
 }
 
@@ -577,6 +604,12 @@ static int bu21013_resume(struct device *dev)
 	struct i2c_client *client = bu21013_data->client;
 	int retval;
 
+	retval = regulator_enable(bu21013_data->regulator);
+	if (retval < 0) {
+		dev_err(&client->dev, "bu21013 regulator enable failed\n");
+		return retval;
+	}
+
 	retval = bu21013_init_chip(bu21013_data);
 	if (retval < 0) {
 		dev_err(&client->dev, "bu21013 controller config failed\n");
-- 
1.7.2.dirty


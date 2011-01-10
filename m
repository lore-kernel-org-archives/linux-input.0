From: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Subject: [PATCH v1] input:Regulator support in ROHM BU21013 touch panel
Date: Mon, 10 Jan 2011 14:52:38 +0530
Message-ID: <1294651358-7690-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:46369 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986Ab1AJJWy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 04:22:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org, rydberg@euromail.se, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

Added the regulator support in ROHM BU21013 touch
panel driver.

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
---
 drivers/input/touchscreen/bu21013_ts.c |   33 +++++++++++++++++++++++++++++--
 include/linux/input/bu21013.h          |    6 +---
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index f7fa9ef..62c4956 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -12,6 +12,7 @@
 #include <linux/input.h>
 #include <linux/input/bu21013.h>
 #include <linux/slab.h>
+#include <linux/regulator/consumer.h>
 
 #define PEN_DOWN_INTR	0
 #define MAX_FINGERS	2
@@ -129,7 +130,7 @@
 #define BU21013_NUMBER_OF_X_SENSORS	(6)
 #define BU21013_NUMBER_OF_Y_SENSORS	(11)
 
-#define DRIVER_TP	"bu21013_tp"
+#define DRIVER_TP	"bu21013_ts"
 
 /**
  * struct bu21013_ts_data - touch panel data structure
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
@@ -456,6 +459,16 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	bu21013_data->in_dev = in_dev;
 	bu21013_data->chip = pdata;
 	bu21013_data->client = client;
+	dev_set_name(&client->dev, pdata->name);
+
+	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
+	if (IS_ERR(bu21013_data->regulator)) {
+		dev_warn(&client->dev, "regulator_get failed\n");
+		bu21013_data->regulator = NULL;
+	}
+	if (bu21013_data->regulator)
+		regulator_enable(bu21013_data->regulator);
+
 	bu21013_data->touch_stopped = false;
 	init_waitqueue_head(&bu21013_data->wait);
 
@@ -485,9 +498,9 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	__set_bit(EV_ABS, in_dev->evbit);
 
 	input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0,
-						pdata->x_max_res, 0, 0);
+						pdata->touch_x_max, 0, 0);
 	input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0,
-						pdata->y_max_res, 0, 0);
+						pdata->touch_y_max, 0, 0);
 	input_set_drvdata(in_dev, bu21013_data);
 
 	error = request_threaded_irq(pdata->irq, NULL, bu21013_gpio_irq,
@@ -514,6 +527,10 @@ err_free_irq:
 err_cs_disable:
 	pdata->cs_dis(pdata->cs_pin);
 err_free_mem:
+	if (bu21013_data->regulator) {
+		regulator_disable(bu21013_data->regulator);
+		regulator_put(bu21013_data->regulator);
+	}
 	input_free_device(in_dev);
 	kfree(bu21013_data);
 
@@ -535,6 +552,10 @@ static int __devexit bu21013_remove(struct i2c_client *client)
 	bu21013_data->chip->cs_dis(bu21013_data->chip->cs_pin);
 
 	input_unregister_device(bu21013_data->in_dev);
+	if (bu21013_data->regulator) {
+		regulator_disable(bu21013_data->regulator);
+		regulator_put(bu21013_data->regulator);
+	}
 	kfree(bu21013_data);
 
 	device_init_wakeup(&client->dev, false);
@@ -561,6 +582,9 @@ static int bu21013_suspend(struct device *dev)
 	else
 		disable_irq(bu21013_data->chip->irq);
 
+	if (bu21013_data->regulator)
+		regulator_disable(bu21013_data->regulator);
+
 	return 0;
 }
 
@@ -577,6 +601,9 @@ static int bu21013_resume(struct device *dev)
 	struct i2c_client *client = bu21013_data->client;
 	int retval;
 
+	if (bu21013_data->regulator)
+		regulator_enable(bu21013_data->regulator);
+
 	retval = bu21013_init_chip(bu21013_data);
 	if (retval < 0) {
 		dev_err(&client->dev, "bu21013 controller config failed\n");
diff --git a/include/linux/input/bu21013.h b/include/linux/input/bu21013.h
index e470d38..14bb641 100644
--- a/include/linux/input/bu21013.h
+++ b/include/linux/input/bu21013.h
@@ -9,11 +9,10 @@
 
 /**
  * struct bu21013_platform_device - Handle the platform data
+ * @name:	name of the touch panel device
  * @cs_en:	pointer to the cs enable function
  * @cs_dis:	pointer to the cs disable function
  * @irq_read_val:    pointer to read the pen irq value function
- * @x_max_res: xmax resolution
- * @y_max_res: ymax resolution
  * @touch_x_max: touch x max
  * @touch_y_max: touch y max
  * @cs_pin: chip select pin
@@ -26,11 +25,10 @@
  * This is used to handle the platform data
  */
 struct bu21013_platform_device {
+	const char *name;
 	int (*cs_en)(int reset_pin);
 	int (*cs_dis)(int reset_pin);
 	int (*irq_read_val)(void);
-	int x_max_res;
-	int y_max_res;
 	int touch_x_max;
 	int touch_y_max;
 	unsigned int cs_pin;
-- 
1.7.2.dirty


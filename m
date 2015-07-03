From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/2] Input: zforce - convert to use the gpiod interface
Date: Fri, 3 Jul 2015 11:07:49 +0200
Message-ID: <1435914469-8955-3-git-send-email-dirk.behme@de.bosch.com>
References: <1435914469-8955-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:17742 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbbGCJH5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jul 2015 05:07:57 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id EA06F840684
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:55 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta24.fe.bosch.de (Postfix) with ESMTP id D3C00D80187
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:54 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 99631A40437
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:54 +0200 (CEST)
In-Reply-To: <1435914469-8955-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Dirk Behme <dirk.behme@de.bosch.com>

Use the new GPIO descriptor interface to handle the zForce GPIOs.
This simplifies the code. No functional change.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c   | 50 +++++++++++----------------------
 include/linux/platform_data/zforce_ts.h |  7 ++---
 2 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 125311d..e840497 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
 #include <linux/input/mt.h>
@@ -32,7 +32,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 #define WAIT_TIMEOUT		msecs_to_jiffies(1000)
 
@@ -166,14 +165,14 @@ static void zforce_reset_assert(struct zforce_ts *ts)
 {
 	const struct zforce_ts_platdata *pdata = ts->pdata;
 
-	gpio_set_value(pdata->gpio_rst, pdata->reset_active_low ? 0 : 1);
+	gpiod_set_value(pdata->gpio_rst, 1);
 }
 
 static void zforce_reset_deassert(struct zforce_ts *ts)
 {
 	const struct zforce_ts_platdata *pdata = ts->pdata;
 
-	gpio_set_value(pdata->gpio_rst, pdata->reset_active_low ? 1 : 0);
+	gpiod_set_value(pdata->gpio_rst, 0);
 }
 
 static int zforce_send_wait(struct zforce_ts *ts, const char *buf, int len)
@@ -514,7 +513,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	if (!ts->suspending && device_may_wakeup(&client->dev))
 		pm_stay_awake(&client->dev);
 
-	while (!gpio_get_value(pdata->gpio_int)) {
+	while (!gpiod_get_value(pdata->gpio_int)) {
 		ret = zforce_read_packet(ts, payload_buffer);
 		if (ret < 0) {
 			dev_err(&client->dev,
@@ -717,7 +716,6 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 {
 	struct zforce_ts_platdata *pdata;
 	struct device_node *np = dev->of_node;
-	enum of_gpio_flags flags;
 
 	if (!np)
 		return ERR_PTR(-ENOENT);
@@ -728,20 +726,22 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	pdata->gpio_int = of_get_gpio(np, 0);
-	if (!gpio_is_valid(pdata->gpio_int)) {
-		dev_err(dev, "failed to get interrupt gpio\n");
-		return ERR_PTR(-EINVAL);
+	/* INT GPIO */
+	pdata->gpio_int = devm_gpiod_get_index(dev, NULL, 0, GPIOD_IN);
+	if (IS_ERR(pdata->gpio_int)) {
+		dev_err(dev, "failed to request interrupt GPIO: %ld\n",
+			PTR_ERR(pdata->gpio_int));
+		return ERR_CAST(pdata->gpio_int);
 	}
 
-	pdata->gpio_rst = of_get_gpio_flags(np, 1, &flags);
-	if (!gpio_is_valid(pdata->gpio_rst)) {
-		dev_err(dev, "failed to get reset gpio\n");
-		return ERR_PTR(-EINVAL);
+	/* RST GPIO */
+	pdata->gpio_rst = devm_gpiod_get_index(dev, NULL, 1, GPIOD_OUT_HIGH);
+	if (IS_ERR(pdata->gpio_rst)) {
+		dev_err(dev, "failed to request reset GPIO: %ld\n",
+			PTR_ERR(pdata->gpio_rst));
+		return ERR_CAST(pdata->gpio_rst);
 	}
 
-	pdata->reset_active_low = flags & OF_GPIO_ACTIVE_LOW;
-
 	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
 		dev_err(dev, "failed to get x-size property\n");
 		return ERR_PTR(-EINVAL);
@@ -773,24 +773,6 @@ static int zforce_probe(struct i2c_client *client,
 	if (!ts)
 		return -ENOMEM;
 
-	ret = devm_gpio_request_one(&client->dev, pdata->gpio_int, GPIOF_IN,
-				    "zforce_ts_int");
-	if (ret) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_int, ret);
-		return ret;
-	}
-
-	ret = devm_gpio_request_one(&client->dev, pdata->gpio_rst,
-				    pdata->reset_active_low ?
-				    GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
-				    "zforce_ts_rst");
-	if (ret) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_rst, ret);
-		return ret;
-	}
-
 	ts->reg_vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	if (IS_ERR(ts->reg_vdd)) {
 		ret = PTR_ERR(ts->reg_vdd);
diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
index 44cd90f..1794268 100644
--- a/include/linux/platform_data/zforce_ts.h
+++ b/include/linux/platform_data/zforce_ts.h
@@ -15,12 +15,9 @@
 #ifndef _LINUX_INPUT_ZFORCE_TS_H
 #define _LINUX_INPUT_ZFORCE_TS_H
 
-#include <linux/of_gpio.h>
-
 struct zforce_ts_platdata {
-	int gpio_int;
-	int gpio_rst;
-	enum of_gpio_flags reset_active_low;
+	struct gpio_desc *gpio_int;
+	struct gpio_desc *gpio_rst;
 
 	unsigned int x_max;
 	unsigned int y_max;
-- 
2.3.4


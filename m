From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] input: zforce_ts: add DT support for reset GPIO polarity
Date: Mon, 15 Jun 2015 07:54:25 +0200
Message-ID: <1434347665-24396-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:11903 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbFOGE0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 02:04:26 -0400
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 6D449840291
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2015 07:54:31 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id B15B9158022A
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2015 07:54:29 +0200 (CEST)
Received: from SI-HUB1001.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 63E4DA40669
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2015 07:54:29 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, Dirk Behme <dirk.behme@de.bosch.com>

From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>

According to

Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt

the RST GPIO is supposed to provide a polarity flag parameter

gpios = <&GPIO_BANK GPIO_NUMBER GPIO_POLARITY>

with GPIO_POLARITY

reset active low  = 1 (GPIO_ACTIVE_LOW)
reset active high = 0 (GPIO_ACTIVE_HIGH)

Example for GPIO_ACTIVE_LOW (1) reset GPIO:

	zforce_ts@50 { /* Neonode zForce I2C */
		compatible = "neonode,zforce-ts";
		...
		gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>, /* INT */
			<&gpio1 29 GPIO_ACTIVE_LOW>; /* RST */
		...
	};

Add the missing polarity flag evaluation to the driver.

Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/input/touchscreen/zforce_ts.c   | 27 +++++++++++++++++++++++----
 include/linux/platform_data/zforce_ts.h |  3 +++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 19880c7..125311d 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -162,6 +162,20 @@ static int zforce_command(struct zforce_ts *ts, u8 cmd)
 	return 0;
 }
 
+static void zforce_reset_assert(struct zforce_ts *ts)
+{
+	const struct zforce_ts_platdata *pdata = ts->pdata;
+
+	gpio_set_value(pdata->gpio_rst, pdata->reset_active_low ? 0 : 1);
+}
+
+static void zforce_reset_deassert(struct zforce_ts *ts)
+{
+	const struct zforce_ts_platdata *pdata = ts->pdata;
+
+	gpio_set_value(pdata->gpio_rst, pdata->reset_active_low ? 1 : 0);
+}
+
 static int zforce_send_wait(struct zforce_ts *ts, const char *buf, int len)
 {
 	struct i2c_client *client = ts->client;
@@ -691,7 +705,7 @@ static void zforce_reset(void *data)
 {
 	struct zforce_ts *ts = data;
 
-	gpio_set_value(ts->pdata->gpio_rst, 0);
+	zforce_reset_assert(ts);
 
 	udelay(10);
 
@@ -703,6 +717,7 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 {
 	struct zforce_ts_platdata *pdata;
 	struct device_node *np = dev->of_node;
+	enum of_gpio_flags flags;
 
 	if (!np)
 		return ERR_PTR(-ENOENT);
@@ -719,12 +734,14 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 		return ERR_PTR(-EINVAL);
 	}
 
-	pdata->gpio_rst = of_get_gpio(np, 1);
+	pdata->gpio_rst = of_get_gpio_flags(np, 1, &flags);
 	if (!gpio_is_valid(pdata->gpio_rst)) {
 		dev_err(dev, "failed to get reset gpio\n");
 		return ERR_PTR(-EINVAL);
 	}
 
+	pdata->reset_active_low = flags & OF_GPIO_ACTIVE_LOW;
+
 	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
 		dev_err(dev, "failed to get x-size property\n");
 		return ERR_PTR(-EINVAL);
@@ -765,7 +782,9 @@ static int zforce_probe(struct i2c_client *client,
 	}
 
 	ret = devm_gpio_request_one(&client->dev, pdata->gpio_rst,
-				    GPIOF_OUT_INIT_LOW, "zforce_ts_rst");
+				    pdata->reset_active_low ?
+				    GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
+				    "zforce_ts_rst");
 	if (ret) {
 		dev_err(&client->dev, "request of gpio %d failed, %d\n",
 			pdata->gpio_rst, ret);
@@ -864,7 +883,7 @@ static int zforce_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ts);
 
 	/* let the controller boot */
-	gpio_set_value(pdata->gpio_rst, 1);
+	zforce_reset_deassert(ts);
 
 	ts->command_waiting = NOTIFICATION_BOOTCOMPLETE;
 	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) == 0)
diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
index 0472ab2..44cd90f 100644
--- a/include/linux/platform_data/zforce_ts.h
+++ b/include/linux/platform_data/zforce_ts.h
@@ -15,9 +15,12 @@
 #ifndef _LINUX_INPUT_ZFORCE_TS_H
 #define _LINUX_INPUT_ZFORCE_TS_H
 
+#include <linux/of_gpio.h>
+
 struct zforce_ts_platdata {
 	int gpio_int;
 	int gpio_rst;
+	enum of_gpio_flags reset_active_low;
 
 	unsigned int x_max;
 	unsigned int y_max;
-- 
2.3.4


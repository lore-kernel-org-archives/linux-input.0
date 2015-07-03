From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/2] Input: zforce - add DT support for reset GPIO polarity
Date: Fri, 3 Jul 2015 11:07:48 +0200
Message-ID: <1435914469-8955-2-git-send-email-dirk.behme@de.bosch.com>
References: <1435914469-8955-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:17741 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbbGCJH4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jul 2015 05:07:56 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 00A30C050D
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:55 +0200 (CEST)
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id DB012D8025B
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:53 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 9BEEC1B8040E
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:53 +0200 (CEST)
In-Reply-To: <1435914469-8955-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

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


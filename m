From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: zforce - convert to use the gpiod interface
Date: Mon, 6 Jul 2015 16:25:51 -0700
Message-ID: <20150706232551.GD32140@dtor-ws>
References: <1435914469-8955-1-git-send-email-dirk.behme@de.bosch.com>
 <1435914469-8955-3-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33205 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136AbbGFXZ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 19:25:56 -0400
Received: by igh16 with SMTP id 16so38361484igh.0
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2015 16:25:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435914469-8955-3-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org

Hi Dirk,

On Fri, Jul 03, 2015 at 11:07:49AM +0200, Dirk Behme wrote:
> diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
> index 44cd90f..1794268 100644
> --- a/include/linux/platform_data/zforce_ts.h
> +++ b/include/linux/platform_data/zforce_ts.h
> @@ -15,12 +15,9 @@
>  #ifndef _LINUX_INPUT_ZFORCE_TS_H
>  #define _LINUX_INPUT_ZFORCE_TS_H
>  
> -#include <linux/of_gpio.h>
> -
>  struct zforce_ts_platdata {
> -	int gpio_int;
> -	int gpio_rst;
> -	enum of_gpio_flags reset_active_low;
> +	struct gpio_desc *gpio_int;
> +	struct gpio_desc *gpio_rst;
>  
>  	unsigned int x_max;
>  	unsigned int y_max;

I do not think we should be plumbing GPIO descriptors directly into
platform data. If board doe snot want to use DT/ACPI they will simply
have to attach GPIO lookup table to the device (via
gpiod_add_lookup_table).

So I intend to apply the version below...

Thanks.

-- 
Dmitry


Input: zforce_ts - convert to use the gpiod interface

From: Dirk Behme <dirk.behme@de.bosch.com>

Use the new GPIO descriptor interface to handle the zForce GPIOs.
This simplifies the code and allows transparently handle GPIO polarity, as
specified in device tree data.

Also switch to using gpio_{set|get}_value_cansleep() since none of the
callers is in atomic context and cansleep variant allows more GPIO
controllers to be used with the touchscreen.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/zforce_ts.c   |   58 ++++++++++++++++---------------
 include/linux/platform_data/zforce_ts.h |    3 --
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index f58a196..c4cffcf 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -24,14 +24,13 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
 #include <linux/input/mt.h>
 #include <linux/platform_data/zforce_ts.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 #define WAIT_TIMEOUT		msecs_to_jiffies(1000)
 
@@ -120,6 +119,9 @@ struct zforce_ts {
 
 	struct regulator	*reg_vdd;
 
+	struct gpio_desc	*gpio_int;
+	struct gpio_desc	*gpio_rst;
+
 	bool			suspending;
 	bool			suspended;
 	bool			boot_complete;
@@ -161,6 +163,16 @@ static int zforce_command(struct zforce_ts *ts, u8 cmd)
 	return 0;
 }
 
+static void zforce_reset_assert(struct zforce_ts *ts)
+{
+	gpiod_set_value_cansleep(ts->gpio_rst, 1);
+}
+
+static void zforce_reset_deassert(struct zforce_ts *ts)
+{
+	gpiod_set_value_cansleep(ts->gpio_rst, 0);
+}
+
 static int zforce_send_wait(struct zforce_ts *ts, const char *buf, int len)
 {
 	struct i2c_client *client = ts->client;
@@ -479,7 +491,6 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 {
 	struct zforce_ts *ts = dev_id;
 	struct i2c_client *client = ts->client;
-	const struct zforce_ts_platdata *pdata = ts->pdata;
 	int ret;
 	u8 payload_buffer[FRAME_MAXSIZE];
 	u8 *payload;
@@ -499,7 +510,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	if (!ts->suspending && device_may_wakeup(&client->dev))
 		pm_stay_awake(&client->dev);
 
-	while (!gpio_get_value(pdata->gpio_int)) {
+	while (!gpiod_get_value_cansleep(ts->gpio_int)) {
 		ret = zforce_read_packet(ts, payload_buffer);
 		if (ret < 0) {
 			dev_err(&client->dev,
@@ -690,7 +701,7 @@ static void zforce_reset(void *data)
 {
 	struct zforce_ts *ts = data;
 
-	gpio_set_value(ts->pdata->gpio_rst, 0);
+	zforce_reset_assert(ts);
 
 	udelay(10);
 
@@ -712,18 +723,6 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	pdata->gpio_int = of_get_gpio(np, 0);
-	if (!gpio_is_valid(pdata->gpio_int)) {
-		dev_err(dev, "failed to get interrupt gpio\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	pdata->gpio_rst = of_get_gpio(np, 1);
-	if (!gpio_is_valid(pdata->gpio_rst)) {
-		dev_err(dev, "failed to get reset gpio\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
 		dev_err(dev, "failed to get x-size property\n");
 		return ERR_PTR(-EINVAL);
@@ -755,19 +754,22 @@ static int zforce_probe(struct i2c_client *client,
 	if (!ts)
 		return -ENOMEM;
 
-	ret = devm_gpio_request_one(&client->dev, pdata->gpio_int, GPIOF_IN,
-				    "zforce_ts_int");
-	if (ret) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_int, ret);
+	/* INT GPIO */
+	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, GPIOD_IN);
+	if (IS_ERR(ts->gpio_int)) {
+		ret = PTR_ERR(ts->gpio_int);
+		dev_err(&client->dev,
+			"failed to request interrupt GPIO: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_gpio_request_one(&client->dev, pdata->gpio_rst,
-				    GPIOF_OUT_INIT_LOW, "zforce_ts_rst");
-	if (ret) {
-		dev_err(&client->dev, "request of gpio %d failed, %d\n",
-			pdata->gpio_rst, ret);
+	/* RST GPIO */
+	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
+					    GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->gpio_rst)) {
+		ret = PTR_ERR(ts->gpio_rst);
+		dev_err(&client->dev,
+			"failed to request reset GPIO: %d\n", ret);
 		return ret;
 	}
 
@@ -863,7 +865,7 @@ static int zforce_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ts);
 
 	/* let the controller boot */
-	gpio_set_value(pdata->gpio_rst, 1);
+	zforce_reset_deassert(ts);
 
 	ts->command_waiting = NOTIFICATION_BOOTCOMPLETE;
 	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) == 0)
diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
index 0472ab2..7bdece8 100644
--- a/include/linux/platform_data/zforce_ts.h
+++ b/include/linux/platform_data/zforce_ts.h
@@ -16,9 +16,6 @@
 #define _LINUX_INPUT_ZFORCE_TS_H
 
 struct zforce_ts_platdata {
-	int gpio_int;
-	int gpio_rst;
-
 	unsigned int x_max;
 	unsigned int y_max;
 };

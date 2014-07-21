From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH RESEND] input: zforce: add regulator handling
Date: Mon, 21 Jul 2014 17:20:11 +0200
Message-ID: <2184295.fEH4OJRW3F@diego>
References: <2587208.XYbbI8xJiH@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:54336 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264AbaGUPS4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 11:18:56 -0400
In-Reply-To: <2587208.XYbbI8xJiH@phil>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

It's possible that the controller has an individually switchable power supply.
Therefore add support to control a supplying regulator.

As this is not always the case, the regulator is requested as optional.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 .../bindings/input/touchscreen/zforce_ts.txt       |  4 +++
 drivers/input/touchscreen/zforce_ts.c              | 30 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
index 2faf1f1..80c37df 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
@@ -9,6 +9,9 @@ Required properties:
 - x-size: horizontal resolution of touchscreen
 - y-size: vertical resolution of touchscreen
 
+Optional properties:
+- vdd-supply: Regulator controlling the controller supply
+
 Example:
 
 	i2c@00000000 {
@@ -18,6 +21,7 @@ Example:
 			compatible = "neonode,zforce";
 			reg = <0x50>;
 			interrupts = <2 0>;
+			vdd-supply = <&reg_zforce_vdd>;
 
 			gpios = <&gpio5 6 0>, /* INT */
 				<&gpio5 9 0>; /* RST */
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 01d30ce..39ca962 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -29,6 +29,8 @@
 #include <linux/sysfs.h>
 #include <linux/input/mt.h>
 #include <linux/platform_data/zforce_ts.h>
+#include <linux/regulator/consumer.h>
+#include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
@@ -117,6 +119,8 @@ struct zforce_ts {
 	const struct zforce_ts_platdata *pdata;
 	char			phys[32];
 
+	struct regulator	*reg_vdd;
+
 	bool			suspending;
 	bool			suspended;
 	bool			boot_complete;
@@ -690,6 +694,11 @@ static void zforce_reset(void *data)
 	struct zforce_ts *ts = data;
 
 	gpio_set_value(ts->pdata->gpio_rst, 0);
+
+	udelay(10);
+
+	if (!IS_ERR(ts->reg_vdd))
+		regulator_disable(ts->reg_vdd);
 }
 
 static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
@@ -765,10 +774,31 @@ static int zforce_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ts->reg_vdd = devm_regulator_get_optional(&client->dev, "vdd");
+	if (IS_ERR(ts->reg_vdd) && PTR_ERR(ts->reg_vdd) == -EPROBE_DEFER)
+		return PTR_ERR(ts->reg_vdd);
+
+	if (!IS_ERR(ts->reg_vdd)) {
+		ret = regulator_enable(ts->reg_vdd);
+		if (ret)
+			return ret;
+
+		/*
+		 * according to datasheet add 100us grace time after regular
+		 * regulator enable delay.
+		 */
+		udelay(100);
+	}
+
 	ret = devm_add_action(&client->dev, zforce_reset, ts);
 	if (ret) {
 		dev_err(&client->dev, "failed to register reset action, %d\n",
 			ret);
+
+		/* hereafter the regulator will be disabled by the action */
+		if (!IS_ERR(ts->reg_vdd))
+			regulator_disable(ts->reg_vdd);
+
 		return ret;
 	}
 
-- 
1.9.0


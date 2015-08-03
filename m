From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCHv v2] Input: zforce - make the interrupt GPIO optional
Date: Mon, 3 Aug 2015 08:34:06 +0200
Message-ID: <1438583646-14022-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:23815 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbbHCGeL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 02:34:11 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id C7E4615801B0
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2015 08:34:09 +0200 (CEST)
Received: from FE-HUB1001.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 8264BA40558
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2015 08:34:09 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko.stuebner@bq.com>, Dirk Behme <dirk.behme@de.bosch.com>

Add support for hardware which uses an I2C Serializer / Deserializer
(SerDes) to communicate with the zFroce touch driver. In this case the
SerDes will be configured as an interrupt controller and the zForce driver
will have no access to poll the GPIO line.

To support this, we add two dedicated new GPIOs in the device tree:
reset-gpio and irq-gpio. With the irq-gpio being optional, then.

To not break the existing device trees, the index based 'gpios' entries
are still supported, but marked as deprecated.

With this, if the interrupt GPIO is available, either via the old or new
device tree style, the while loop will read and handle the packets as long
as the GPIO indicates that the interrupt is asserted (existing, unchanged
driver behavior).

If the interrupt GPIO isn't available, i.e. not configured via the new
device tree style, we are falling back to one read per ISR invocation
(new behavior to support the SerDes).

Note that the gpiod functions help to handle the optional GPIO:
devm_gpiod_get_index_optional() will return NULL in case the interrupt
GPIO isn't available. And gpiod_get_value_cansleep() does cover this, too,
by returning 0 in this case.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---

Changes in v2: Fix review comments

 .../bindings/input/touchscreen/zforce_ts.txt       |  8 +--
 drivers/input/touchscreen/zforce_ts.c              | 63 +++++++++++++++++-----
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
index 80c37df..e3c27c4 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
@@ -4,12 +4,12 @@ Required properties:
 - compatible: must be "neonode,zforce"
 - reg: I2C address of the chip
 - interrupts: interrupt to which the chip is connected
-- gpios: gpios the chip is connected to
-  first one is the interrupt gpio and second one the reset gpio
+- reset-gpios: reset gpio the chip is connected to
 - x-size: horizontal resolution of touchscreen
 - y-size: vertical resolution of touchscreen
 
 Optional properties:
+- irq-gpios : interrupt gpio the chip is connected to
 - vdd-supply: Regulator controlling the controller supply
 
 Example:
@@ -23,8 +23,8 @@ Example:
 			interrupts = <2 0>;
 			vdd-supply = <&reg_zforce_vdd>;
 
-			gpios = <&gpio5 6 0>, /* INT */
-				<&gpio5 9 0>; /* RST */
+			reset-gpios = <&gpio5 9 0>; /* RST */
+			irq-gpios = <&gpio5 6 0>; /* IRQ, optional */
 
 			x-size = <800>;
 			y-size = <600>;
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index edf01c3..64f0068 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -510,7 +510,16 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	if (!ts->suspending && device_may_wakeup(&client->dev))
 		pm_stay_awake(&client->dev);
 
-	while (gpiod_get_value_cansleep(ts->gpio_int)) {
+	/*
+	 * Run at least once and exit the loop if
+	 * - the optional interrupt GPIO isn't specified
+	 *   (there is only one packet read per ISR invocation, then)
+	 * or
+	 * - the GPIO isn't active any more
+	 *   (packet read until the level GPIO indicates that there is
+	 *    no IRQ any more)
+	 */
+	do {
 		ret = zforce_read_packet(ts, payload_buffer);
 		if (ret < 0) {
 			dev_err(&client->dev,
@@ -577,7 +586,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 				payload[RESPONSE_ID]);
 			break;
 		}
-	}
+	} while (gpiod_get_value_cansleep(ts->gpio_int));
 
 	if (!ts->suspending && device_may_wakeup(&client->dev))
 		pm_relax(&client->dev);
@@ -754,18 +763,8 @@ static int zforce_probe(struct i2c_client *client,
 	if (!ts)
 		return -ENOMEM;
 
-	/* INT GPIO */
-	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, GPIOD_IN);
-	if (IS_ERR(ts->gpio_int)) {
-		ret = PTR_ERR(ts->gpio_int);
-		dev_err(&client->dev,
-			"failed to request interrupt GPIO: %d\n", ret);
-		return ret;
-	}
-
-	/* RST GPIO */
-	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
-					    GPIOD_OUT_HIGH);
+	ts->gpio_rst = devm_gpiod_get_optional(&client->dev, "reset",
+					       GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->gpio_rst)) {
 		ret = PTR_ERR(ts->gpio_rst);
 		dev_err(&client->dev,
@@ -773,6 +772,42 @@ static int zforce_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	if (ts->gpio_rst) {
+		ts->gpio_int = devm_gpiod_get_optional(&client->dev, "irq",
+						       GPIOD_IN);
+		if (IS_ERR(ts->gpio_int)) {
+			ret = PTR_ERR(ts->gpio_int);
+			dev_err(&client->dev,
+				"failed to request interrupt GPIO: %d\n", ret);
+			return ret;
+		}
+	} else {
+		/*
+		 * Deprecated GPIO handling for compatibility
+		 * with legacy binding.
+		 */
+
+		/* INT GPIO */
+		ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0,
+						    GPIOD_IN);
+		if (IS_ERR(ts->gpio_int)) {
+			ret = PTR_ERR(ts->gpio_int);
+			dev_err(&client->dev,
+				"failed to request interrupt GPIO: %d\n", ret);
+			return ret;
+		}
+
+		/* RST GPIO */
+		ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
+					    GPIOD_OUT_HIGH);
+		if (IS_ERR(ts->gpio_rst)) {
+			ret = PTR_ERR(ts->gpio_rst);
+			dev_err(&client->dev,
+				"failed to request reset GPIO: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ts->reg_vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	if (IS_ERR(ts->reg_vdd)) {
 		ret = PTR_ERR(ts->reg_vdd);
-- 
2.3.4


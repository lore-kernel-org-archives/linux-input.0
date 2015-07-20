From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 3/4 v2] Input: zforce - make the interrupt GPIO optional
Date: Mon, 20 Jul 2015 14:56:36 +0200
Message-ID: <1437396997-3182-4-git-send-email-dirk.behme@de.bosch.com>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:30547 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbbGTM4m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 08:56:42 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta24.fe.bosch.de (Postfix) with ESMTP id A5B94D8022B
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:40 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 6487C238050D
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:40 +0200 (CEST)
In-Reply-To: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>

Add support for hardware which uses an I2C Serializer / Deserializer
(SerDes) to communicate with the zFroce touch driver. In this case the
SerDes will be configured as an interrupt controller and the zForce driver
will have no access to poll the GPIO line.

To support this, we make the interrupt GPIO optional and use it only if
it is specified.

With this, if the GPIO is available, the while loop will read and handle
the packets as long as the GPIO indicates that the interrupt is asserted
(existing, unchanged driver behavior).

If the GPIO isn't available, we are falling back to one read per ISR
invocation (new behavior to support the SerDes).

Note that the gpiod functions help to handle the optional GPIO:
devm_gpiod_get_index_optional() will return NULL in case the interrupt
GPIO isn't available. And gpiod_get_value_cansleep() does cover this, too,
by returning 0 in this case.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Changes in v2: Instead of dropping the interrupt GPIO completely, make
               it optional.

 .../bindings/input/touchscreen/zforce_ts.txt          |  2 +-
 drivers/input/touchscreen/zforce_ts.c                 | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
index a19b508..5843957 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
@@ -24,7 +24,7 @@ Example:
 			vdd-supply = <&reg_zforce_vdd>;
 
 			gpios = <&gpio5 9 0>, /* RST */
-				<&gpio5 6 0>; /* INT */
+				<&gpio5 6 0>; /* INT, optional */
 
 			x-size = <800>;
 			y-size = <600>;
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index ac7b661..fdd00b1 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -494,6 +494,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	int ret;
 	u8 payload_buffer[FRAME_MAXSIZE];
 	u8 *payload;
+	int run = 1;
 
 	/*
 	 * When still suspended, return.
@@ -510,7 +511,18 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	if (!ts->suspending && device_may_wakeup(&client->dev))
 		pm_stay_awake(&client->dev);
 
-	while (gpiod_get_value_cansleep(ts->gpio_int)) {
+	while (run) {
+		/*
+		 * Exit the loop if either
+		 * - the optional interrupt GPIO isn't specified
+		 *   (there is only one packet read per ISR invocation, then)
+		 * or
+		 * - the GPIO isn't active any more
+		 *   (packet read until the level GPIO indicates that there is
+		 *    no IRQ any more)
+		 */
+		run = gpiod_get_value_cansleep(ts->gpio_int);
+
 		ret = zforce_read_packet(ts, payload_buffer);
 		if (ret < 0) {
 			dev_err(&client->dev,
@@ -764,8 +776,9 @@ static int zforce_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/* INT GPIO */
-	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 1, GPIOD_IN);
+	/* INT GPIO, optional, can return NULL if not used */
+	ts->gpio_int = devm_gpiod_get_index_optional(&client->dev, NULL, 1,
+						     GPIOD_IN);
 	if (IS_ERR(ts->gpio_int)) {
 		ret = PTR_ERR(ts->gpio_int);
 		dev_err(&client->dev,
-- 
2.3.4


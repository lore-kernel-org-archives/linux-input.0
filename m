From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/4] Input: zforce - swap reset and interrupt GPIO
Date: Mon, 20 Jul 2015 14:56:35 +0200
Message-ID: <1437396997-3182-3-git-send-email-dirk.behme@de.bosch.com>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:30546 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbbGTM4l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 08:56:41 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 171A1D80222
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:40 +0200 (CEST)
Received: from FE-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id B91EE23803A4
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:39 +0200 (CEST)
In-Reply-To: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dirk Behme <dirk.behme@gmail.com>

From: Dirk Behme <dirk.behme@gmail.com>

Swap the order of the reset and interrupt GPIO. This is the preparation
to make the interrupt GPIO optional.

Note that this needs the same change in the device tree. But as mainline
doesn't contain any zforce device tree entries, nothing has to be done
for us, here.

All non-mainline device trees have to be adapted, though.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
 .../bindings/input/touchscreen/zforce_ts.txt         |  4 ++--
 drivers/input/touchscreen/zforce_ts.c                | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
index 80c37df..a19b508 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
@@ -23,8 +23,8 @@ Example:
 			interrupts = <2 0>;
 			vdd-supply = <&reg_zforce_vdd>;
 
-			gpios = <&gpio5 6 0>, /* INT */
-				<&gpio5 9 0>; /* RST */
+			gpios = <&gpio5 9 0>, /* RST */
+				<&gpio5 6 0>; /* INT */
 
 			x-size = <800>;
 			y-size = <600>;
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index edf01c3..ac7b661 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -754,17 +754,8 @@ static int zforce_probe(struct i2c_client *client,
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
 	/* RST GPIO */
-	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
+	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 0,
 					    GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->gpio_rst)) {
 		ret = PTR_ERR(ts->gpio_rst);
@@ -773,6 +764,15 @@ static int zforce_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* INT GPIO */
+	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 1, GPIOD_IN);
+	if (IS_ERR(ts->gpio_int)) {
+		ret = PTR_ERR(ts->gpio_int);
+		dev_err(&client->dev,
+			"failed to request interrupt GPIO: %d\n", ret);
+		return ret;
+	}
+
 	ts->reg_vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	if (IS_ERR(ts->reg_vdd)) {
 		ret = PTR_ERR(ts->reg_vdd);
-- 
2.3.4


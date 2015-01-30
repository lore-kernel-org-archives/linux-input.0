From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 18/20] power_supply: bq2415x_charger: Decrement the power
 supply's device reference counter
Date: Fri, 30 Jan 2015 15:47:56 +0100
Message-ID: <1422629278-12202-19-git-send-email-k.kozlowski@samsung.com>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57414 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbbA3Osx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 09:48:53 -0500
In-reply-to: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Use power_supply_put() to decrement the power supply's device reference
counter (increased by power_supply_get_by_name() or
power_supply_get_by_phandle()).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/bq2415x_charger.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index cb92022df8eb..4adcd65bef5b 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1601,27 +1601,27 @@ static int bq2415x_probe(struct i2c_client *client,
 		ret = of_property_read_u32(np, "ti,current-limit",
 				&bq->init_data.current_limit);
 		if (ret)
-			goto error_2;
+			goto error_3;
 		ret = of_property_read_u32(np, "ti,weak-battery-voltage",
 				&bq->init_data.weak_battery_voltage);
 		if (ret)
-			goto error_2;
+			goto error_3;
 		ret = of_property_read_u32(np, "ti,battery-regulation-voltage",
 				&bq->init_data.battery_regulation_voltage);
 		if (ret)
-			goto error_2;
+			goto error_3;
 		ret = of_property_read_u32(np, "ti,charge-current",
 				&bq->init_data.charge_current);
 		if (ret)
-			goto error_2;
+			goto error_3;
 		ret = of_property_read_u32(np, "ti,termination-current",
 				&bq->init_data.termination_current);
 		if (ret)
-			goto error_2;
+			goto error_3;
 		ret = of_property_read_u32(np, "ti,resistor-sense",
 				&bq->init_data.resistor_sense);
 		if (ret)
-			goto error_2;
+			goto error_3;
 	} else {
 		memcpy(&bq->init_data, pdata, sizeof(bq->init_data));
 	}
@@ -1631,19 +1631,19 @@ static int bq2415x_probe(struct i2c_client *client,
 	ret = bq2415x_power_supply_init(bq);
 	if (ret) {
 		dev_err(bq->dev, "failed to register power supply: %d\n", ret);
-		goto error_2;
+		goto error_3;
 	}
 
 	ret = bq2415x_sysfs_init(bq);
 	if (ret) {
 		dev_err(bq->dev, "failed to create sysfs entries: %d\n", ret);
-		goto error_3;
+		goto error_4;
 	}
 
 	ret = bq2415x_set_defaults(bq);
 	if (ret) {
 		dev_err(bq->dev, "failed to set default values: %d\n", ret);
-		goto error_4;
+		goto error_5;
 	}
 
 	if (bq->notify_psy) {
@@ -1651,7 +1651,7 @@ static int bq2415x_probe(struct i2c_client *client,
 		ret = power_supply_reg_notifier(&bq->nb);
 		if (ret) {
 			dev_err(bq->dev, "failed to reg notifier: %d\n", ret);
-			goto error_5;
+			goto error_6;
 		}
 
 		/* Query for initial reported_mode and set it */
@@ -1671,11 +1671,14 @@ static int bq2415x_probe(struct i2c_client *client,
 	dev_info(bq->dev, "driver registered\n");
 	return 0;
 
+error_6:
 error_5:
-error_4:
 	bq2415x_sysfs_exit(bq);
-error_3:
+error_4:
 	bq2415x_power_supply_exit(bq);
+error_3:
+	if (!IS_ERR(bq->notify_psy))
+		power_supply_put(bq->notify_psy);
 error_2:
 	kfree(name);
 error_1:
@@ -1692,8 +1695,10 @@ static int bq2415x_remove(struct i2c_client *client)
 {
 	struct bq2415x_device *bq = i2c_get_clientdata(client);
 
-	if (bq->notify_psy)
+	if (bq->notify_psy) {
 		power_supply_unreg_notifier(&bq->nb);
+		power_supply_put(bq->notify_psy);
+	}
 
 	bq2415x_sysfs_exit(bq);
 	bq2415x_power_supply_exit(bq);
-- 
1.9.1


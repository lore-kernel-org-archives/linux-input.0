From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v5 18/20] power_supply: bq2415x_charger: Decrement the power
 supply's device reference counter
Date: Fri, 27 Feb 2015 09:19:59 +0100
Message-ID: <1425025201-15926-19-git-send-email-k.kozlowski@samsung.com>
References: <1425025201-15926-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1425025201-15926-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>, Pavel Machek <pavel@ucw.cz>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-input@vger.kernel.org

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
index 413fcaa0f15c..10a81a8f928f 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1595,27 +1595,27 @@ static int bq2415x_probe(struct i2c_client *client,
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
@@ -1625,19 +1625,19 @@ static int bq2415x_probe(struct i2c_client *client,
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
@@ -1645,7 +1645,7 @@ static int bq2415x_probe(struct i2c_client *client,
 		ret = power_supply_reg_notifier(&bq->nb);
 		if (ret) {
 			dev_err(bq->dev, "failed to reg notifier: %d\n", ret);
-			goto error_5;
+			goto error_6;
 		}
 
 		/* Query for initial reported_mode and set it */
@@ -1665,11 +1665,14 @@ static int bq2415x_probe(struct i2c_client *client,
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
+	if (bq->notify_psy)
+		power_supply_put(bq->notify_psy);
 error_2:
 	kfree(name);
 error_1:
@@ -1686,8 +1689,10 @@ static int bq2415x_remove(struct i2c_client *client)
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

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH v6 15/22] power_supply: Increment power supply use
 counter when obtaining references
Date: Thu, 12 Mar 2015 08:44:13 +0100
Message-ID: <1426146260-30081-16-git-send-email-k.kozlowski@samsung.com>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Increment the power_supply.use_cnt usage counter on:
 - power_supply_get_by_phandle()
 - power_supply_get_by_name()
and decrement it on power_supply_put() call.

This helps tracking of valid usage of power supply instance by
consumers. The usage counter itself also allows safe calling of
power_supply_get_property-like functions even when driver unregisters
this power supply.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/power/power_supply_core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index b4ec14683b7f..2ed4a4a6b3c5 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -349,10 +349,16 @@ static int power_supply_match_device_by_name(struct device *dev, const void *dat
  */
 struct power_supply *power_supply_get_by_name(const char *name)
 {
+	struct power_supply *psy = NULL;
 	struct device *dev = class_find_device(power_supply_class, NULL, name,
 					power_supply_match_device_by_name);
 
-	return dev ? dev_get_drvdata(dev) : NULL;
+	if (dev) {
+		psy = dev_get_drvdata(dev);
+		atomic_inc(&psy->use_cnt);
+	}
+
+	return psy;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_name);
 
@@ -367,6 +373,7 @@ void power_supply_put(struct power_supply *psy)
 {
 	might_sleep();
 
+	atomic_dec(&psy->use_cnt);
 	put_device(&psy->dev);
 }
 EXPORT_SYMBOL_GPL(power_supply_put);
@@ -393,6 +400,7 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 							const char *property)
 {
 	struct device_node *power_supply_np;
+	struct power_supply *psy = NULL;
 	struct device *dev;
 
 	power_supply_np = of_parse_phandle(np, property, 0);
@@ -404,7 +412,12 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 
 	of_node_put(power_supply_np);
 
-	return dev ? dev_get_drvdata(dev) : NULL;
+	if (dev) {
+		psy = dev_get_drvdata(dev);
+		atomic_inc(&psy->use_cnt);
+	}
+
+	return psy;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
-- 
1.9.1

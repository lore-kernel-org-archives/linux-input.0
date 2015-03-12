From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH v6 05/22] power_supply: Add API for safe access of power
 supply function attrs
Date: Thu, 12 Mar 2015 08:44:03 +0100
Message-ID: <1426146260-30081-6-git-send-email-k.kozlowski@samsung.com>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Add simple wrappers for accessing power supply's function attributes:
 - get_property -> power_supply_get_property
 - set_property -> power_supply_set_property
 - property_is_writeable -> power_supply_property_is_writeable
 - external_power_changed -> power_supply_external_power_changed

This API along with atomic usage counter adds a safe way of accessing a
power supply from another driver. If power supply is unregistered after
obtaining reference to it by some driver, then the API wrappers won't be
executed in invalid (freed) context.

Next patch changing the ownership of power supply class is still needed
to fully fix race conditions in accessing freed power supply.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/power_supply_core.c | 47 ++++++++++++++++++++++++++++++++++++++-
 include/linux/power_supply.h      | 16 +++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index a21e36ed8d41..583dece8845b 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -314,7 +314,9 @@ EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
 
 int power_supply_set_battery_charged(struct power_supply *psy)
 {
-	if (psy->type == POWER_SUPPLY_TYPE_BATTERY && psy->set_charged) {
+	if (atomic_read(&psy->use_cnt) >= 0 &&
+			psy->type == POWER_SUPPLY_TYPE_BATTERY &&
+			psy->set_charged) {
 		psy->set_charged(psy);
 		return 0;
 	}
@@ -366,6 +368,47 @@ struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
 
+int power_supply_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val)
+{
+	if (atomic_read(&psy->use_cnt) <= 0)
+		return -ENODEV;
+
+	return psy->get_property(psy, psp, val);
+}
+EXPORT_SYMBOL_GPL(power_supply_get_property);
+
+int power_supply_set_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    const union power_supply_propval *val)
+{
+	if (atomic_read(&psy->use_cnt) <= 0 || !psy->set_property)
+		return -ENODEV;
+
+	return psy->set_property(psy, psp, val);
+}
+EXPORT_SYMBOL_GPL(power_supply_set_property);
+
+int power_supply_property_is_writeable(struct power_supply *psy,
+					enum power_supply_property psp)
+{
+	if (atomic_read(&psy->use_cnt) <= 0 || !psy->property_is_writeable)
+		return -ENODEV;
+
+	return psy->property_is_writeable(psy, psp);
+}
+EXPORT_SYMBOL_GPL(power_supply_property_is_writeable);
+
+void power_supply_external_power_changed(struct power_supply *psy)
+{
+	if (atomic_read(&psy->use_cnt) <= 0 || !psy->external_power_changed)
+		return;
+
+	psy->external_power_changed(psy);
+}
+EXPORT_SYMBOL_GPL(power_supply_external_power_changed);
+
 int power_supply_powers(struct power_supply *psy, struct device *dev)
 {
 	return sysfs_create_link(&psy->dev->kobj, &dev->kobj, "powers");
@@ -555,6 +598,7 @@ static int __power_supply_register(struct device *parent,
 	dev->release = power_supply_dev_release;
 	dev_set_drvdata(dev, psy);
 	psy->dev = dev;
+	atomic_inc(&psy->use_cnt);
 	if (cfg) {
 		psy->drv_data = cfg->drv_data;
 		psy->of_node = cfg->of_node;
@@ -676,6 +720,7 @@ EXPORT_SYMBOL_GPL(devm_power_supply_register_no_ws);
 
 void power_supply_unregister(struct power_supply *psy)
 {
+	WARN_ON(atomic_dec_return(&psy->use_cnt));
 	cancel_work_sync(&psy->changed_work);
 	sysfs_remove_link(&psy->dev->kobj, "powers");
 	power_supply_remove_triggers(psy);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0d7c95f634a5..7ae60346465f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -199,6 +199,12 @@ struct power_supply {
 	size_t num_supplies;
 	struct device_node *of_node;
 
+	/*
+	 * Functions for drivers implementing power supply class.
+	 * These shouldn't be called directly by other drivers for accessing
+	 * this power supply. Instead use power_supply_*() functions (for
+	 * example power_supply_get_property()).
+	 */
 	int (*get_property)(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val);
@@ -227,6 +233,7 @@ struct power_supply {
 	struct work_struct changed_work;
 	spinlock_t changed_lock;
 	bool changed;
+	atomic_t use_cnt;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
 	struct thermal_cooling_device *tcd;
@@ -287,6 +294,15 @@ extern int power_supply_is_system_supplied(void);
 static inline int power_supply_is_system_supplied(void) { return -ENOSYS; }
 #endif
 
+extern int power_supply_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val);
+extern int power_supply_set_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    const union power_supply_propval *val);
+extern int power_supply_property_is_writeable(struct power_supply *psy,
+					enum power_supply_property psp);
+extern void power_supply_external_power_changed(struct power_supply *psy);
 extern int power_supply_register(struct device *parent,
 				 struct power_supply *psy,
 				 const struct power_supply_config *cfg);
-- 
1.9.1


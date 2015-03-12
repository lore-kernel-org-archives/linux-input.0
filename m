From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH v6 03/22] power_supply: Add driver private data
Date: Thu, 12 Mar 2015 08:44:01 +0100
Message-ID: <1426146260-30081-4-git-send-email-k.kozlowski@samsung.com>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Allow drivers to store private data inside power_supply structure for
later usage in power supply operations.

Usage of driver private data is necessary to access driver's state
container object from power supply calls (like get_property()) if struct
'power_supply' is a stored there as a pointer, for example:

struct some_driver_info {
	struct i2c_client       *client;
	struct power_supply     *power_supply;
	...
}

In such case one cannot use container_of() and must store pointer to
state container as private data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/power_supply_core.c | 6 ++++++
 include/linux/power_supply.h      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 44c810456212..1c0978f961ea 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -674,6 +674,12 @@ void power_supply_unregister(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_unregister);
 
+void *power_supply_get_drvdata(struct power_supply *psy)
+{
+	return psy->drv_data;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_drvdata);
+
 static int __init power_supply_class_init(void)
 {
 	power_supply_class = class_create(THIS_MODULE, "power_supply");
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f606d6b4bd56..e30d85c0158d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -209,6 +209,9 @@ struct power_supply {
 	/* For APM emulation, think legacy userspace. */
 	int use_for_apm;
 
+	/* Driver private data */
+	void *drv_data;
+
 	/* private */
 	struct device *dev;
 	struct work_struct changed_work;
@@ -285,6 +288,7 @@ extern int devm_power_supply_register_no_ws(struct device *parent,
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
+extern void *power_supply_get_drvdata(struct power_supply *psy);
 /* For APM emulation, think legacy userspace. */
 extern struct class *power_supply_class;
 
-- 
1.9.1


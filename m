From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v5 01/20] power_supply: Add driver private data
Date: Fri, 27 Feb 2015 09:19:42 +0100
Message-ID: <1425025201-15926-2-git-send-email-k.kozlowski@samsung.com>
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

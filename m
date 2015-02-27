From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v5 13/20] power_supply: Increment power supply use counter when
 obtaining references
Date: Fri, 27 Feb 2015 09:19:54 +0100
Message-ID: <1425025201-15926-14-git-send-email-k.kozlowski@samsung.com>
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

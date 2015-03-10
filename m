From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 15/22] power_supply: Increment power supply use counter when
 obtaining references
Date: Tue, 10 Mar 2015 09:27:19 +0100
Message-ID: <1425976046-20973-16-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1425976046-20973-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Cezary Jackiewicz <cezary.jackiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.orglinux-
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Increment the power_supply.use_cnt usage counter on:
 - power_supply_get_by_phandle()
 - power_supply_get_by_name()
and decrement it on power_supply_put() call.

This helps tracking of valid usage of power supply instance by
consumers. The usage counter itself also allows safe calling of
power_supply_get_property-like functions even when driver unregisters
this power supply.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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

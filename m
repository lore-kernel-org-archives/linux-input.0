From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v4 17/20] power_supply: 88pm860x_charger: Decrement the power
 supply's device reference counter
Date: Mon, 23 Feb 2015 12:47:38 +0100
Message-ID: <1424692061-30624-18-git-send-email-k.kozlowski@samsung.com>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Use power_supply_put() to decrement the power supply's device reference
counter.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/88pm860x_charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index a7f32a5b2299..bf822aa00c14 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -298,13 +298,18 @@ static int set_charging_fsm(struct pm860x_charger_info *info)
 		return -EINVAL;
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW,
 			&data);
-	if (ret)
+	if (ret) {
+		power_supply_put(psy);
 		return ret;
+	}
 	vbatt = data.intval / 1000;
 
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_PRESENT, &data);
-	if (ret)
+	if (ret) {
+		power_supply_put(psy);
 		return ret;
+	}
+	power_supply_put(psy);
 
 	mutex_lock(&info->lock);
 	info->present = data.intval;
@@ -447,6 +452,7 @@ static irqreturn_t pm860x_temp_handler(int irq, void *data)
 
 	set_charging_fsm(info);
 out:
+	power_supply_put(psy);
 	return IRQ_HANDLED;
 }
 
@@ -507,6 +513,7 @@ static irqreturn_t pm860x_done_handler(int irq, void *data)
 
 out:
 	mutex_unlock(&info->lock);
+	power_supply_put(psy);
 	dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
 	set_charging_fsm(info);
 
-- 
1.9.1


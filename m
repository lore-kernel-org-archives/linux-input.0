From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 6/9] power_supply: wm97xx_battery: use power_supply_get_drvdata
Date: Wed, 26 Oct 2016 21:41:44 +0200
Message-ID: <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

As the power supply framework provides a way to store and retrieve
private supply data, use it.

In the process, change the platform data for wm97xx_battery from a
container of a single struct wm97xx_batt_pdata to the direct point to wm97xx_batt_pdata.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/input/touchscreen/wm97xx-core.c |  2 +-
 drivers/power/supply/wm97xx_battery.c   | 25 ++++++++++---------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 90d6be3c26cc..83cf11312fd9 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -682,7 +682,7 @@ static int wm97xx_probe(struct device *dev)
 	}
 	platform_set_drvdata(wm->battery_dev, wm);
 	wm->battery_dev->dev.parent = dev;
-	wm->battery_dev->dev.platform_data = pdata;
+	wm->battery_dev->dev.platform_data = pdata->batt_pdata;
 	ret = platform_device_add(wm->battery_dev);
 	if (ret < 0)
 		goto batt_reg_err;
diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index 6285626d142a..e3edb31ac880 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -30,8 +30,7 @@ static enum power_supply_property *prop;
 
 static unsigned long wm97xx_read_bat(struct power_supply *bat_ps)
 {
-	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
-	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
+	struct wm97xx_batt_pdata *pdata = power_supply_get_drvdata(bat_ps);
 
 	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev.parent),
 					pdata->batt_aux) * pdata->batt_mult /
@@ -40,8 +39,7 @@ static unsigned long wm97xx_read_bat(struct power_supply *bat_ps)
 
 static unsigned long wm97xx_read_temp(struct power_supply *bat_ps)
 {
-	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
-	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
+	struct wm97xx_batt_pdata *pdata = power_supply_get_drvdata(bat_ps);
 
 	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev.parent),
 					pdata->temp_aux) * pdata->temp_mult /
@@ -52,8 +50,7 @@ static int wm97xx_bat_get_property(struct power_supply *bat_ps,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
-	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
+	struct wm97xx_batt_pdata *pdata = power_supply_get_drvdata(bat_ps);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -103,8 +100,7 @@ static void wm97xx_bat_external_power_changed(struct power_supply *bat_ps)
 static void wm97xx_bat_update(struct power_supply *bat_ps)
 {
 	int old_status = bat_status;
-	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
-	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
+	struct wm97xx_batt_pdata *pdata = power_supply_get_drvdata(bat_ps);
 
 	mutex_lock(&work_lock);
 
@@ -166,15 +162,15 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	int ret = 0;
 	int props = 1;	/* POWER_SUPPLY_PROP_PRESENT */
 	int i = 0;
-	struct wm97xx_pdata *wmdata = dev->dev.platform_data;
-	struct wm97xx_batt_pdata *pdata;
+	struct wm97xx_batt_pdata *pdata = dev->dev.platform_data;
+	struct power_supply_config cfg = {};
 
-	if (!wmdata) {
+	if (!pdata) {
 		dev_err(&dev->dev, "No platform data supplied\n");
 		return -EINVAL;
 	}
 
-	pdata = wmdata->batt_pdata;
+	cfg.drv_data = pdata;
 
 	if (dev->id != -1)
 		return -EINVAL;
@@ -243,7 +239,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	bat_psy_desc.properties = prop;
 	bat_psy_desc.num_properties = props;
 
-	bat_psy = power_supply_register(&dev->dev, &bat_psy_desc, NULL);
+	bat_psy = power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
 	if (!IS_ERR(bat_psy)) {
 		schedule_work(&bat_work);
 	} else {
@@ -266,8 +262,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 
 static int wm97xx_bat_remove(struct platform_device *dev)
 {
-	struct wm97xx_pdata *wmdata = dev->dev.platform_data;
-	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
+	struct wm97xx_batt_pdata *pdata = dev->dev.platform_data;
 
 	if (pdata && gpio_is_valid(pdata->charge_gpio)) {
 		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
-- 
2.1.4


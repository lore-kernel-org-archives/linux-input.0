From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH v6 04/22] power_supply: Move run-time configuration to
 separate structure
Date: Thu, 12 Mar 2015 08:44:02 +0100
Message-ID: <1426146260-30081-5-git-send-email-k.kozlowski@samsung.com>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Add new structure 'power_supply_config' for holding run-time
initialization data like of_node, supplies and private driver data.

The power_supply_register() function is changed so all power supply
drivers need updating.

When registering the power supply this new 'power_supply_config' should be
used instead of directly initializing 'struct power_supply'. This allows
changing the ownership of power_supply structure from driver to the
power supply core in next patches.

When a driver does not use of_node or supplies then it should use NULL
as config. If driver uses of_node or supplies then it should allocate
config on stack and initialize it with proper values.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>

[for the nvec part]
Reviewed-by: Marc Dietrich <marvin24@gmx.de>

[for drivers/platform/x86/compal-laptop.c]
Reviewed-by: Darren Hart <dvhart@linux.intel.com>

[for drivers/hid/*]
Reviewed-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/acpi/ac.c                     |  2 +-
 drivers/acpi/battery.c                |  3 ++-
 drivers/acpi/sbs.c                    |  4 ++--
 drivers/hid/hid-input.c               |  2 +-
 drivers/hid/hid-sony.c                |  2 +-
 drivers/hid/hid-wiimote-modules.c     |  2 +-
 drivers/hid/wacom_sys.c               |  5 +++--
 drivers/platform/x86/compal-laptop.c  |  2 +-
 drivers/power/88pm860x_battery.c      |  2 +-
 drivers/power/88pm860x_charger.c      |  7 ++++---
 drivers/power/ab8500_btemp.c          |  7 ++++---
 drivers/power/ab8500_charger.c        | 15 +++++++++------
 drivers/power/ab8500_fg.c             |  8 +++++---
 drivers/power/abx500_chargalg.c       |  8 +++++---
 drivers/power/axp288_fuel_gauge.c     |  2 +-
 drivers/power/bq2415x_charger.c       |  2 +-
 drivers/power/bq24190_charger.c       |  4 ++--
 drivers/power/bq24735-charger.c       | 10 ++++++----
 drivers/power/bq27x00_battery.c       |  2 +-
 drivers/power/charger-manager.c       |  2 +-
 drivers/power/collie_battery.c        |  4 ++--
 drivers/power/da9030_battery.c        |  2 +-
 drivers/power/da9052-battery.c        |  2 +-
 drivers/power/da9150-charger.c        |  4 ++--
 drivers/power/ds2760_battery.c        |  2 +-
 drivers/power/ds2780_battery.c        |  2 +-
 drivers/power/ds2781_battery.c        |  2 +-
 drivers/power/ds2782_battery.c        |  2 +-
 drivers/power/generic-adc-battery.c   |  2 +-
 drivers/power/goldfish_battery.c      |  4 ++--
 drivers/power/gpio-charger.c          | 10 ++++++----
 drivers/power/intel_mid_battery.c     |  4 ++--
 drivers/power/ipaq_micro_battery.c    |  4 ++--
 drivers/power/isp1704_charger.c       |  2 +-
 drivers/power/jz4740-battery.c        |  2 +-
 drivers/power/lp8727_charger.c        | 14 +++++++-------
 drivers/power/lp8788-charger.c        | 11 +++++++----
 drivers/power/ltc2941-battery-gauge.c |  2 +-
 drivers/power/max14577_charger.c      |  2 +-
 drivers/power/max17040_battery.c      |  2 +-
 drivers/power/max17042_battery.c      |  2 +-
 drivers/power/max77693_charger.c      |  2 +-
 drivers/power/max8903_charger.c       |  2 +-
 drivers/power/max8925_power.c         | 14 +++++++-------
 drivers/power/max8997_charger.c       |  2 +-
 drivers/power/max8998_charger.c       |  2 +-
 drivers/power/olpc_battery.c          |  4 ++--
 drivers/power/pcf50633-charger.c      | 16 +++++++---------
 drivers/power/pda_power.c             | 18 ++++++++----------
 drivers/power/pm2301_charger.c        |  8 +++++---
 drivers/power/pmu_battery.c           |  4 ++--
 drivers/power/power_supply_core.c     | 30 +++++++++++++++++++++---------
 drivers/power/rt5033_battery.c        |  2 +-
 drivers/power/rx51_battery.c          |  2 +-
 drivers/power/s3c_adc_battery.c       |  4 ++--
 drivers/power/sbs-battery.c           |  6 ++++--
 drivers/power/smb347-charger.c        | 13 ++++++-------
 drivers/power/test_power.c            | 21 ++++++++++++++++-----
 drivers/power/tosa_battery.c          |  6 +++---
 drivers/power/tps65090-charger.c      | 10 ++++++----
 drivers/power/twl4030_charger.c       |  4 ++--
 drivers/power/twl4030_madc_battery.c  |  2 +-
 drivers/power/wm831x_backup.c         |  2 +-
 drivers/power/wm831x_power.c          |  6 +++---
 drivers/power/wm8350_power.c          |  6 +++---
 drivers/power/wm97xx_battery.c        |  2 +-
 drivers/power/z2_battery.c            |  2 +-
 drivers/staging/nvec/nvec_power.c     |  7 ++++---
 include/linux/power_supply.h          | 22 ++++++++++++++++++----
 69 files changed, 224 insertions(+), 167 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 36b0e61f9c09..8bf516885ede 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -351,7 +351,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->charger.properties = ac_props;
 	ac->charger.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger.get_property = get_ac_property;
-	result = power_supply_register(&ac->device->dev, &ac->charger);
+	result = power_supply_register(&ac->device->dev, &ac->charger, NULL);
 	if (result)
 		goto end;
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d98ba4355819..fd8c06f492a1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -624,7 +624,8 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	battery->bat.get_property = acpi_battery_get_property;
 
-	result = power_supply_register_no_ws(&battery->device->dev, &battery->bat);
+	result = power_supply_register_no_ws(&battery->device->dev,
+			&battery->bat, NULL);
 
 	if (result)
 		return result;
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index a7a3edd28beb..2038ec1d021d 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -540,7 +540,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		    ARRAY_SIZE(sbs_energy_battery_props);
 	}
 	battery->bat.get_property = acpi_sbs_battery_get_property;
-	result = power_supply_register(&sbs->device->dev, &battery->bat);
+	result = power_supply_register(&sbs->device->dev, &battery->bat, NULL);
 	if (result)
 		goto end;
 
@@ -580,7 +580,7 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 	sbs->charger.properties = sbs_ac_props;
 	sbs->charger.num_properties = ARRAY_SIZE(sbs_ac_props);
 	sbs->charger.get_property = sbs_get_ac_property;
-	power_supply_register(&sbs->device->dev, &sbs->charger);
+	power_supply_register(&sbs->device->dev, &sbs->charger, NULL);
 	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       ACPI_AC_DIR_NAME, sbs->charger_present ? "on-line" : "off-line");
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 052869d0ab78..6182265a6571 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -439,7 +439,7 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
 
-	ret = power_supply_register(&dev->dev, battery);
+	ret = power_supply_register(&dev->dev, battery, NULL);
 	if (ret != 0) {
 		hid_warn(dev, "can't register power supply: %d\n", ret);
 		kfree(battery->name);
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31e9d2561106..16fc6a17ac63 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1718,7 +1718,7 @@ static int sony_battery_probe(struct sony_sc *sc)
 	if (!sc->battery.name)
 		return -ENOMEM;
 
-	ret = power_supply_register(&hdev->dev, &sc->battery);
+	ret = power_supply_register(&hdev->dev, &sc->battery, NULL);
 	if (ret) {
 		hid_err(hdev, "Unable to register battery device\n");
 		goto err_free;
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 6b61f01e01e7..91cb00abcb8e 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -250,7 +250,7 @@ static int wiimod_battery_probe(const struct wiimod_ops *ops,
 	if (!wdata->battery.name)
 		return -ENOMEM;
 
-	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery);
+	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery, NULL);
 	if (ret) {
 		hid_err(wdata->hdev, "cannot register battery device\n");
 		goto err_free;
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f0568a7e6de9..148949c0e039 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1021,13 +1021,14 @@ static int wacom_initialize_battery(struct wacom *wacom)
 		wacom->ac.use_for_apm = 0;
 
 		error = power_supply_register(&wacom->hdev->dev,
-					      &wacom->battery);
+					      &wacom->battery, NULL);
 		if (error)
 			return error;
 
 		power_supply_powers(&wacom->battery, &wacom->hdev->dev);
 
-		error = power_supply_register(&wacom->hdev->dev, &wacom->ac);
+		error = power_supply_register(&wacom->hdev->dev, &wacom->ac,
+					      NULL);
 		if (error) {
 			power_supply_unregister(&wacom->battery);
 			return error;
diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index bceb30b539f3..041a592fe753 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1036,7 +1036,7 @@ static int compal_probe(struct platform_device *pdev)
 
 	/* Power supply */
 	initialize_power_supply_data(data);
-	err = power_supply_register(&compal_device->dev, &data->psy);
+	err = power_supply_register(&compal_device->dev, &data->psy, NULL);
 	if (err < 0)
 		goto remove;
 
diff --git a/drivers/power/88pm860x_battery.c b/drivers/power/88pm860x_battery.c
index bd3c997f4fee..a99d7f2829a7 100644
--- a/drivers/power/88pm860x_battery.c
+++ b/drivers/power/88pm860x_battery.c
@@ -953,7 +953,7 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 	else
 		info->resistor = 300;	/* set default internal resistor */
 
-	ret = power_supply_register(&pdev->dev, &info->battery);
+	ret = power_supply_register(&pdev->dev, &info->battery, NULL);
 	if (ret)
 		return ret;
 	info->battery.dev->parent = &pdev->dev;
diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 734ec4afa14d..ac352a6c03ea 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -648,6 +648,7 @@ static struct pm860x_irq_desc {
 static int pm860x_charger_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
 	struct pm860x_charger_info *info;
 	int ret;
 	int count;
@@ -687,12 +688,12 @@ static int pm860x_charger_probe(struct platform_device *pdev)
 
 	info->usb.name = "usb";
 	info->usb.type = POWER_SUPPLY_TYPE_USB;
-	info->usb.supplied_to = pm860x_supplied_to;
-	info->usb.num_supplicants = ARRAY_SIZE(pm860x_supplied_to);
 	info->usb.properties = pm860x_usb_props;
 	info->usb.num_properties = ARRAY_SIZE(pm860x_usb_props);
 	info->usb.get_property = pm860x_usb_get_prop;
-	ret = power_supply_register(&pdev->dev, &info->usb);
+	psy_cfg.supplied_to = pm860x_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(pm860x_supplied_to);
+	ret = power_supply_register(&pdev->dev, &info->usb, &psy_cfg);
 	if (ret)
 		goto out;
 
diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 4ebf7b0819f7..d5683f503a4e 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -1058,6 +1058,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct abx500_bm_data *plat = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct ab8500_btemp *di;
 	int irq, i, ret = 0;
 	u8 val;
@@ -1095,11 +1096,11 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	di->btemp_psy.properties = ab8500_btemp_props;
 	di->btemp_psy.num_properties = ARRAY_SIZE(ab8500_btemp_props);
 	di->btemp_psy.get_property = ab8500_btemp_get_property;
-	di->btemp_psy.supplied_to = supply_interface;
-	di->btemp_psy.num_supplicants = ARRAY_SIZE(supply_interface);
 	di->btemp_psy.external_power_changed =
 		ab8500_btemp_external_power_changed;
 
+	psy_cfg.supplied_to = supply_interface;
+	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 
 	/* Create a work queue for the btemp */
 	di->btemp_wq =
@@ -1140,7 +1141,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	}
 
 	/* Register BTEMP power supply class */
-	ret = power_supply_register(di->dev, &di->btemp_psy);
+	ret = power_supply_register(di->dev, &di->btemp_psy, &psy_cfg);
 	if (ret) {
 		dev_err(di->dev, "failed to register BTEMP psy\n");
 		goto free_btemp_wq;
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index 8c8d170ff0f8..cee9b9e46825 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -3446,6 +3446,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct abx500_bm_data *plat = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct ab8500_charger *di;
 	int irq, i, charger_status, ret = 0, ch_stat;
 
@@ -3483,6 +3484,10 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->autopower = false;
 	di->invalid_charger_detect_state = 0;
 
+	/* AC and USB supply config */
+	psy_cfg.supplied_to = supply_interface;
+	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+
 	/* AC supply */
 	/* power_supply base class */
 	di->ac_chg.psy.name = "ab8500_ac";
@@ -3490,8 +3495,6 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->ac_chg.psy.properties = ab8500_charger_ac_props;
 	di->ac_chg.psy.num_properties = ARRAY_SIZE(ab8500_charger_ac_props);
 	di->ac_chg.psy.get_property = ab8500_charger_ac_get_property;
-	di->ac_chg.psy.supplied_to = supply_interface;
-	di->ac_chg.psy.num_supplicants = ARRAY_SIZE(supply_interface),
 	/* ux500_charger sub-class */
 	di->ac_chg.ops.enable = &ab8500_charger_ac_en;
 	di->ac_chg.ops.check_enable = &ab8500_charger_ac_check_enable;
@@ -3517,8 +3520,6 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->usb_chg.psy.properties = ab8500_charger_usb_props;
 	di->usb_chg.psy.num_properties = ARRAY_SIZE(ab8500_charger_usb_props);
 	di->usb_chg.psy.get_property = ab8500_charger_usb_get_property;
-	di->usb_chg.psy.supplied_to = supply_interface;
-	di->usb_chg.psy.num_supplicants = ARRAY_SIZE(supply_interface),
 	/* ux500_charger sub-class */
 	di->usb_chg.ops.enable = &ab8500_charger_usb_en;
 	di->usb_chg.ops.check_enable = &ab8500_charger_usb_check_enable;
@@ -3616,7 +3617,8 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	/* Register AC charger class */
 	if (di->ac_chg.enabled) {
-		ret = power_supply_register(di->dev, &di->ac_chg.psy);
+		ret = power_supply_register(di->dev, &di->ac_chg.psy,
+						&psy_cfg);
 		if (ret) {
 			dev_err(di->dev, "failed to register AC charger\n");
 			goto free_charger_wq;
@@ -3625,7 +3627,8 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	/* Register USB charger class */
 	if (di->usb_chg.enabled) {
-		ret = power_supply_register(di->dev, &di->usb_chg.psy);
+		ret = power_supply_register(di->dev, &di->usb_chg.psy,
+						&psy_cfg);
 		if (ret) {
 			dev_err(di->dev, "failed to register USB charger\n");
 			goto free_ac;
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index d30387bc4c21..73bdb4dc4142 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -3075,6 +3075,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct abx500_bm_data *plat = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct ab8500_fg *di;
 	int i, irq;
 	int ret = 0;
@@ -3111,10 +3112,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	di->fg_psy.properties = ab8500_fg_props;
 	di->fg_psy.num_properties = ARRAY_SIZE(ab8500_fg_props);
 	di->fg_psy.get_property = ab8500_fg_get_property;
-	di->fg_psy.supplied_to = supply_interface;
-	di->fg_psy.num_supplicants = ARRAY_SIZE(supply_interface),
 	di->fg_psy.external_power_changed = ab8500_fg_external_power_changed;
 
+	psy_cfg.supplied_to = supply_interface;
+	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+
 	di->bat_cap.max_mah_design = MILLI_TO_MICRO *
 		di->bm->bat_type[di->bm->batt_id].charge_full_design;
 
@@ -3174,7 +3176,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	di->flags.batt_id_received = false;
 
 	/* Register FG power supply class */
-	ret = power_supply_register(di->dev, &di->fg_psy);
+	ret = power_supply_register(di->dev, &di->fg_psy, &psy_cfg);
 	if (ret) {
 		dev_err(di->dev, "failed to register FG psy\n");
 		goto free_inst_curr_wq;
diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index ab54b8dea670..0da4415cbc10 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -2047,6 +2047,7 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct abx500_bm_data *plat = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct abx500_chargalg *di;
 	int ret = 0;
 
@@ -2080,11 +2081,12 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	di->chargalg_psy.properties = abx500_chargalg_props;
 	di->chargalg_psy.num_properties = ARRAY_SIZE(abx500_chargalg_props);
 	di->chargalg_psy.get_property = abx500_chargalg_get_property;
-	di->chargalg_psy.supplied_to = supply_interface;
-	di->chargalg_psy.num_supplicants = ARRAY_SIZE(supply_interface),
 	di->chargalg_psy.external_power_changed =
 		abx500_chargalg_external_power_changed;
 
+	psy_cfg.supplied_to = supply_interface;
+	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+
 	/* Initilialize safety timer */
 	hrtimer_init(&di->safety_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	di->safety_timer.function = abx500_chargalg_safety_timer_expired;
@@ -2115,7 +2117,7 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	di->chg_info.prev_conn_chg = -1;
 
 	/* Register chargalg power supply class */
-	ret = power_supply_register(di->dev, &di->chargalg_psy);
+	ret = power_supply_register(di->dev, &di->chargalg_psy, &psy_cfg);
 	if (ret) {
 		dev_err(di->dev, "failed to register chargalg psy\n");
 		goto free_chargalg_wq;
diff --git a/drivers/power/axp288_fuel_gauge.c b/drivers/power/axp288_fuel_gauge.c
index c86e709c1880..2bec8d241e62 100644
--- a/drivers/power/axp288_fuel_gauge.c
+++ b/drivers/power/axp288_fuel_gauge.c
@@ -1099,7 +1099,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	info->bat.set_property = fuel_gauge_set_property;
 	info->bat.property_is_writeable = fuel_gauge_property_is_writeable;
 	info->bat.external_power_changed = fuel_gauge_external_power_changed;
-	ret = power_supply_register(&pdev->dev, &info->bat);
+	ret = power_supply_register(&pdev->dev, &info->bat, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register battery: %d\n", ret);
 		return ret;
diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 2333d7f1182b..9b509025d687 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1051,7 +1051,7 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 		return -ENOMEM;
 	}
 
-	ret = power_supply_register(bq->dev, &bq->charger);
+	ret = power_supply_register(bq->dev, &bq->charger, NULL);
 	if (ret) {
 		kfree(bq->model);
 		return ret;
diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index d0e8236a6404..54eb58485d55 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -1418,7 +1418,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bq24190_charger_init(&bdi->charger);
 
-	ret = power_supply_register(dev, &bdi->charger);
+	ret = power_supply_register(dev, &bdi->charger, NULL);
 	if (ret) {
 		dev_err(dev, "Can't register charger\n");
 		goto out2;
@@ -1426,7 +1426,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bq24190_battery_init(&bdi->battery);
 
-	ret = power_supply_register(dev, &bdi->battery);
+	ret = power_supply_register(dev, &bdi->battery, NULL);
 	if (ret) {
 		dev_err(dev, "Can't register battery\n");
 		goto out3;
diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index d022b823305b..242e79bfe217 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -249,6 +249,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	int ret;
 	struct bq24735 *charger;
 	struct power_supply *supply;
+	struct power_supply_config psy_cfg = {};
 	char *name;
 
 	charger = devm_kzalloc(&client->dev, sizeof(*charger), GFP_KERNEL);
@@ -284,9 +285,10 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	supply->properties = bq24735_charger_properties;
 	supply->num_properties = ARRAY_SIZE(bq24735_charger_properties);
 	supply->get_property = bq24735_charger_get_property;
-	supply->supplied_to = charger->pdata->supplied_to;
-	supply->num_supplicants = charger->pdata->num_supplicants;
-	supply->of_node = client->dev.of_node;
+
+	psy_cfg.supplied_to = charger->pdata->supplied_to;
+	psy_cfg.num_supplicants = charger->pdata->num_supplicants;
+	psy_cfg.of_node = client->dev.of_node;
 
 	i2c_set_clientdata(client, charger);
 
@@ -341,7 +343,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = power_supply_register(&client->dev, supply);
+	ret = power_supply_register(&client->dev, supply, &psy_cfg);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register power supply: %d\n",
 			ret);
diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index ba08b5926bfd..a992e43908a2 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -791,7 +791,7 @@ static int bq27x00_powersupply_init(struct bq27x00_device_info *di)
 	INIT_DELAYED_WORK(&di->work, bq27x00_battery_poll);
 	mutex_init(&di->lock);
 
-	ret = power_supply_register_no_ws(di->dev, &di->bat);
+	ret = power_supply_register_no_ws(di->dev, &di->bat, NULL);
 	if (ret) {
 		dev_err(di->dev, "failed to register battery: %d\n", ret);
 		return ret;
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 14b0d85318eb..df27600880b9 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1740,7 +1740,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
 
-	ret = power_supply_register(NULL, &cm->charger_psy);
+	ret = power_supply_register(NULL, &cm->charger_psy, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
 			cm->charger_psy.name);
diff --git a/drivers/power/collie_battery.c b/drivers/power/collie_battery.c
index 594e4dbc2d51..e7a808d1758a 100644
--- a/drivers/power/collie_battery.c
+++ b/drivers/power/collie_battery.c
@@ -334,10 +334,10 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 
 	INIT_WORK(&bat_work, collie_bat_work);
 
-	ret = power_supply_register(&dev->ucb->dev, &collie_bat_main.psy);
+	ret = power_supply_register(&dev->ucb->dev, &collie_bat_main.psy, NULL);
 	if (ret)
 		goto err_psy_reg_main;
-	ret = power_supply_register(&dev->ucb->dev, &collie_bat_bu.psy);
+	ret = power_supply_register(&dev->ucb->dev, &collie_bat_bu.psy, NULL);
 	if (ret)
 		goto err_psy_reg_bu;
 
diff --git a/drivers/power/da9030_battery.c b/drivers/power/da9030_battery.c
index 78cd5d66144b..a87406ef18ee 100644
--- a/drivers/power/da9030_battery.c
+++ b/drivers/power/da9030_battery.c
@@ -541,7 +541,7 @@ static int da9030_battery_probe(struct platform_device *pdev)
 		goto err_notifier;
 
 	da9030_battery_setup_psy(charger);
-	ret = power_supply_register(&pdev->dev, &charger->psy);
+	ret = power_supply_register(&pdev->dev, &charger->psy, NULL);
 	if (ret)
 		goto err_ps_register;
 
diff --git a/drivers/power/da9052-battery.c b/drivers/power/da9052-battery.c
index d17250f745c2..54ba9ddb6d4f 100644
--- a/drivers/power/da9052-battery.c
+++ b/drivers/power/da9052-battery.c
@@ -625,7 +625,7 @@ static s32 da9052_bat_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = power_supply_register(&pdev->dev, &bat->psy);
+	ret = power_supply_register(&pdev->dev, &bat->psy, NULL);
 	 if (ret)
 		goto err;
 
diff --git a/drivers/power/da9150-charger.c b/drivers/power/da9150-charger.c
index 4df97ea8dcde..db8ba5d8d1e3 100644
--- a/drivers/power/da9150-charger.c
+++ b/drivers/power/da9150-charger.c
@@ -550,7 +550,7 @@ static int da9150_charger_probe(struct platform_device *pdev)
 	usb->properties = da9150_charger_props;
 	usb->num_properties = ARRAY_SIZE(da9150_charger_props);
 	usb->get_property = da9150_charger_get_prop;
-	ret = power_supply_register(dev, usb);
+	ret = power_supply_register(dev, usb, NULL);
 	if (ret)
 		goto usb_fail;
 
@@ -559,7 +559,7 @@ static int da9150_charger_probe(struct platform_device *pdev)
 	battery->properties = da9150_charger_bat_props;
 	battery->num_properties = ARRAY_SIZE(da9150_charger_bat_props);
 	battery->get_property = da9150_charger_battery_get_prop;
-	ret = power_supply_register(dev, battery);
+	ret = power_supply_register(dev, battery, NULL);
 	if (ret)
 		goto battery_fail;
 
diff --git a/drivers/power/ds2760_battery.c b/drivers/power/ds2760_battery.c
index 85b4e6eca0b1..e82dff0bbb20 100644
--- a/drivers/power/ds2760_battery.c
+++ b/drivers/power/ds2760_battery.c
@@ -555,7 +555,7 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	if (current_accum)
 		ds2760_battery_set_current_accum(di, current_accum);
 
-	retval = power_supply_register(&pdev->dev, &di->bat);
+	retval = power_supply_register(&pdev->dev, &di->bat, NULL);
 	if (retval) {
 		dev_err(di->dev, "failed to register battery\n");
 		goto batt_failed;
diff --git a/drivers/power/ds2780_battery.c b/drivers/power/ds2780_battery.c
index 9f418fa879e5..b1d3570ea730 100644
--- a/drivers/power/ds2780_battery.c
+++ b/drivers/power/ds2780_battery.c
@@ -776,7 +776,7 @@ static int ds2780_battery_probe(struct platform_device *pdev)
 	dev_info->bat.num_properties	= ARRAY_SIZE(ds2780_battery_props);
 	dev_info->bat.get_property	= ds2780_battery_get_property;
 
-	ret = power_supply_register(&pdev->dev, &dev_info->bat);
+	ret = power_supply_register(&pdev->dev, &dev_info->bat, NULL);
 	if (ret) {
 		dev_err(dev_info->dev, "failed to register battery\n");
 		goto fail;
diff --git a/drivers/power/ds2781_battery.c b/drivers/power/ds2781_battery.c
index 0a5acc6fc6f0..50686dc59711 100644
--- a/drivers/power/ds2781_battery.c
+++ b/drivers/power/ds2781_battery.c
@@ -769,7 +769,7 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 	dev_info->bat.num_properties	= ARRAY_SIZE(ds2781_battery_props);
 	dev_info->bat.get_property	= ds2781_battery_get_property;
 
-	ret = power_supply_register(&pdev->dev, &dev_info->bat);
+	ret = power_supply_register(&pdev->dev, &dev_info->bat, NULL);
 	if (ret) {
 		dev_err(dev_info->dev, "failed to register battery\n");
 		goto fail;
diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_battery.c
index 39694883d3bf..2dcb96a83cee 100644
--- a/drivers/power/ds2782_battery.c
+++ b/drivers/power/ds2782_battery.c
@@ -424,7 +424,7 @@ static int ds278x_battery_probe(struct i2c_client *client,
 
 	INIT_DELAYED_WORK(&info->bat_work, ds278x_bat_work);
 
-	ret = power_supply_register(&client->dev, &info->battery);
+	ret = power_supply_register(&client->dev, &info->battery, NULL);
 	if (ret) {
 		dev_err(&client->dev, "failed to register battery\n");
 		goto fail_register;
diff --git a/drivers/power/generic-adc-battery.c b/drivers/power/generic-adc-battery.c
index 0a566ac3eefd..4575955de7c5 100644
--- a/drivers/power/generic-adc-battery.c
+++ b/drivers/power/generic-adc-battery.c
@@ -312,7 +312,7 @@ static int gab_probe(struct platform_device *pdev)
 	 */
 	psy->num_properties = ARRAY_SIZE(gab_props) + index;
 
-	ret = power_supply_register(&pdev->dev, psy);
+	ret = power_supply_register(&pdev->dev, psy, NULL);
 	if (ret)
 		goto err_reg_fail;
 
diff --git a/drivers/power/goldfish_battery.c b/drivers/power/goldfish_battery.c
index 29eba88a2963..61d437f8cf76 100644
--- a/drivers/power/goldfish_battery.c
+++ b/drivers/power/goldfish_battery.c
@@ -195,11 +195,11 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = power_supply_register(&pdev->dev, &data->ac);
+	ret = power_supply_register(&pdev->dev, &data->ac, NULL);
 	if (ret)
 		return ret;
 
-	ret = power_supply_register(&pdev->dev, &data->battery);
+	ret = power_supply_register(&pdev->dev, &data->battery, NULL);
 	if (ret) {
 		power_supply_unregister(&data->ac);
 		return ret;
diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index b7424c8501f1..47a9e2bd94d9 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -127,6 +127,7 @@ struct gpio_charger_platform_data *gpio_charger_parse_dt(struct device *dev)
 static int gpio_charger_probe(struct platform_device *pdev)
 {
 	const struct gpio_charger_platform_data *pdata = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct gpio_charger *gpio_charger;
 	struct power_supply *charger;
 	int ret;
@@ -161,9 +162,10 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	charger->properties = gpio_charger_properties;
 	charger->num_properties = ARRAY_SIZE(gpio_charger_properties);
 	charger->get_property = gpio_charger_get_property;
-	charger->supplied_to = pdata->supplied_to;
-	charger->num_supplicants = pdata->num_supplicants;
-	charger->of_node = pdev->dev.of_node;
+
+	psy_cfg.supplied_to = pdata->supplied_to;
+	psy_cfg.num_supplicants = pdata->num_supplicants;
+	psy_cfg.of_node = pdev->dev.of_node;
 
 	ret = gpio_request(pdata->gpio, dev_name(&pdev->dev));
 	if (ret) {
@@ -178,7 +180,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	gpio_charger->pdata = pdata;
 
-	ret = power_supply_register(&pdev->dev, charger);
+	ret = power_supply_register(&pdev->dev, charger, &psy_cfg);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
 			ret);
diff --git a/drivers/power/intel_mid_battery.c b/drivers/power/intel_mid_battery.c
index de3f39e6fa8e..8a149657cd71 100644
--- a/drivers/power/intel_mid_battery.c
+++ b/drivers/power/intel_mid_battery.c
@@ -692,7 +692,7 @@ static int probe(int irq, struct device *dev)
 	pbi->batt.properties = pmic_battery_props;
 	pbi->batt.num_properties = ARRAY_SIZE(pmic_battery_props);
 	pbi->batt.get_property = pmic_battery_get_property;
-	retval = power_supply_register(dev, &pbi->batt);
+	retval = power_supply_register(dev, &pbi->batt, NULL);
 	if (retval) {
 		dev_err(dev,
 			"%s(): failed to register pmic battery device with power supply subsystem\n",
@@ -712,7 +712,7 @@ static int probe(int irq, struct device *dev)
 	pbi->usb.properties = pmic_usb_props;
 	pbi->usb.num_properties = ARRAY_SIZE(pmic_usb_props);
 	pbi->usb.get_property = pmic_usb_get_property;
-	retval = power_supply_register(dev, &pbi->usb);
+	retval = power_supply_register(dev, &pbi->usb, NULL);
 	if (retval) {
 		dev_err(dev,
 			"%s(): failed to register pmic usb device with power supply subsystem\n",
diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/ipaq_micro_battery.c
index 96b15e003f3f..842e7e2e1cb5 100644
--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -241,11 +241,11 @@ static int micro_batt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mb);
 	queue_delayed_work(mb->wq, &mb->update, 1);
 
-	ret = power_supply_register(&pdev->dev, &micro_batt_power);
+	ret = power_supply_register(&pdev->dev, &micro_batt_power, NULL);
 	if (ret < 0)
 		goto batt_err;
 
-	ret = power_supply_register(&pdev->dev, &micro_ac_power);
+	ret = power_supply_register(&pdev->dev, &micro_ac_power, NULL);
 	if (ret < 0)
 		goto ac_err;
 
diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_charger.c
index 0b4cf9d63291..5521178bdc08 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -460,7 +460,7 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 	isp->psy.num_properties	= ARRAY_SIZE(power_props);
 	isp->psy.get_property	= isp1704_charger_get_property;
 
-	ret = power_supply_register(isp->dev, &isp->psy);
+	ret = power_supply_register(isp->dev, &isp->psy, NULL);
 	if (ret)
 		goto fail1;
 
diff --git a/drivers/power/jz4740-battery.c b/drivers/power/jz4740-battery.c
index 9cd391d61819..0444434e1927 100644
--- a/drivers/power/jz4740-battery.c
+++ b/drivers/power/jz4740-battery.c
@@ -330,7 +330,7 @@ static int jz_battery_probe(struct platform_device *pdev)
 	else
 		jz4740_adc_set_config(pdev->dev.parent, JZ_ADC_CONFIG_BAT_MB, 0);
 
-	ret = power_supply_register(&pdev->dev, &jz_battery->battery);
+	ret = power_supply_register(&pdev->dev, &jz_battery->battery, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "power supply battery register failed.\n");
 		goto err_free_charge_irq;
diff --git a/drivers/power/lp8727_charger.c b/drivers/power/lp8727_charger.c
index 32de636dcd73..1f71af7a3811 100644
--- a/drivers/power/lp8727_charger.c
+++ b/drivers/power/lp8727_charger.c
@@ -420,6 +420,7 @@ static void lp8727_charger_changed(struct power_supply *psy)
 
 static int lp8727_register_psy(struct lp8727_chg *pchg)
 {
+	struct power_supply_config psy_cfg = {}; /* Only for ac and usb */
 	struct lp8727_psy *psy;
 
 	psy = devm_kzalloc(pchg->dev, sizeof(*psy), GFP_KERNEL);
@@ -428,15 +429,16 @@ static int lp8727_register_psy(struct lp8727_chg *pchg)
 
 	pchg->psy = psy;
 
+	psy_cfg.supplied_to = battery_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
+
 	psy->ac.name = "ac";
 	psy->ac.type = POWER_SUPPLY_TYPE_MAINS;
 	psy->ac.properties = lp8727_charger_prop;
 	psy->ac.num_properties = ARRAY_SIZE(lp8727_charger_prop);
 	psy->ac.get_property = lp8727_charger_get_property;
-	psy->ac.supplied_to = battery_supplied_to;
-	psy->ac.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	if (power_supply_register(pchg->dev, &psy->ac))
+	if (power_supply_register(pchg->dev, &psy->ac, &psy_cfg))
 		goto err_psy_ac;
 
 	psy->usb.name = "usb";
@@ -444,10 +446,8 @@ static int lp8727_register_psy(struct lp8727_chg *pchg)
 	psy->usb.properties = lp8727_charger_prop;
 	psy->usb.num_properties = ARRAY_SIZE(lp8727_charger_prop);
 	psy->usb.get_property = lp8727_charger_get_property;
-	psy->usb.supplied_to = battery_supplied_to;
-	psy->usb.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	if (power_supply_register(pchg->dev, &psy->usb))
+	if (power_supply_register(pchg->dev, &psy->usb, &psy_cfg))
 		goto err_psy_usb;
 
 	psy->batt.name = "main_batt";
@@ -457,7 +457,7 @@ static int lp8727_register_psy(struct lp8727_chg *pchg)
 	psy->batt.get_property = lp8727_battery_get_property;
 	psy->batt.external_power_changed = lp8727_charger_changed;
 
-	if (power_supply_register(pchg->dev, &psy->batt))
+	if (power_supply_register(pchg->dev, &psy->batt, NULL))
 		goto err_psy_batt;
 
 	return 0;
diff --git a/drivers/power/lp8788-charger.c b/drivers/power/lp8788-charger.c
index 176dab2e4c16..8e4d228519c1 100644
--- a/drivers/power/lp8788-charger.c
+++ b/drivers/power/lp8788-charger.c
@@ -400,15 +400,18 @@ static int lp8788_update_charger_params(struct platform_device *pdev,
 static int lp8788_psy_register(struct platform_device *pdev,
 				struct lp8788_charger *pchg)
 {
+	struct power_supply_config charger_cfg = {};
+
 	pchg->charger.name = LP8788_CHARGER_NAME;
 	pchg->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	pchg->charger.properties = lp8788_charger_prop;
 	pchg->charger.num_properties = ARRAY_SIZE(lp8788_charger_prop);
 	pchg->charger.get_property = lp8788_charger_get_property;
-	pchg->charger.supplied_to = battery_supplied_to;
-	pchg->charger.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	if (power_supply_register(&pdev->dev, &pchg->charger))
+	charger_cfg.supplied_to = battery_supplied_to;
+	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
+
+	if (power_supply_register(&pdev->dev, &pchg->charger, &charger_cfg))
 		return -EPERM;
 
 	pchg->battery.name = LP8788_BATTERY_NAME;
@@ -417,7 +420,7 @@ static int lp8788_psy_register(struct platform_device *pdev,
 	pchg->battery.num_properties = ARRAY_SIZE(lp8788_battery_prop);
 	pchg->battery.get_property = lp8788_battery_get_property;
 
-	if (power_supply_register(&pdev->dev, &pchg->battery)) {
+	if (power_supply_register(&pdev->dev, &pchg->battery, NULL)) {
 		power_supply_unregister(&pchg->charger);
 		return -EPERM;
 	}
diff --git a/drivers/power/ltc2941-battery-gauge.c b/drivers/power/ltc2941-battery-gauge.c
index 50c5d89dcef3..9bc545393ef8 100644
--- a/drivers/power/ltc2941-battery-gauge.c
+++ b/drivers/power/ltc2941-battery-gauge.c
@@ -473,7 +473,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		goto fail_comm;
 	}
 
-	ret = power_supply_register(&client->dev, &info->supply);
+	ret = power_supply_register(&client->dev, &info->supply, NULL);
 	if (ret) {
 		dev_err(&client->dev, "failed to register ltc2941\n");
 		goto fail_register;
diff --git a/drivers/power/max14577_charger.c b/drivers/power/max14577_charger.c
index 4736dc478578..c5f2a535c81a 100644
--- a/drivers/power/max14577_charger.c
+++ b/drivers/power/max14577_charger.c
@@ -594,7 +594,7 @@ static int max14577_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = power_supply_register(&pdev->dev, &chg->charger);
+	ret = power_supply_register(&pdev->dev, &chg->charger, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		goto err;
diff --git a/drivers/power/max17040_battery.c b/drivers/power/max17040_battery.c
index 63ff3f705154..d36b2f6c2053 100644
--- a/drivers/power/max17040_battery.c
+++ b/drivers/power/max17040_battery.c
@@ -224,7 +224,7 @@ static int max17040_probe(struct i2c_client *client,
 	chip->battery.properties	= max17040_battery_props;
 	chip->battery.num_properties	= ARRAY_SIZE(max17040_battery_props);
 
-	ret = power_supply_register(&client->dev, &chip->battery);
+	ret = power_supply_register(&client->dev, &chip->battery, NULL);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
 		return ret;
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 830435adfb64..b1ebbc3b8640 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -731,7 +731,7 @@ static int max17042_probe(struct i2c_client *client,
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
-	ret = power_supply_register(&client->dev, &chip->battery);
+	ret = power_supply_register(&client->dev, &chip->battery, NULL);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
 		return ret;
diff --git a/drivers/power/max77693_charger.c b/drivers/power/max77693_charger.c
index ca52e7d15b95..86ea0231175c 100644
--- a/drivers/power/max77693_charger.c
+++ b/drivers/power/max77693_charger.c
@@ -714,7 +714,7 @@ static int max77693_charger_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = power_supply_register(&pdev->dev, &chg->charger);
+	ret = power_supply_register(&pdev->dev, &chg->charger, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		goto err;
diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 99e3cdcd3e11..2f769faa85f6 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -288,7 +288,7 @@ static int max8903_probe(struct platform_device *pdev)
 	data->psy.properties = max8903_charger_props;
 	data->psy.num_properties = ARRAY_SIZE(max8903_charger_props);
 
-	ret = power_supply_register(dev, &data->psy);
+	ret = power_supply_register(dev, &data->psy, NULL);
 	if (ret) {
 		dev_err(dev, "failed: power supply register.\n");
 		goto err;
diff --git a/drivers/power/max8925_power.c b/drivers/power/max8925_power.c
index a6d45eef64dd..71c087e3feaf 100644
--- a/drivers/power/max8925_power.c
+++ b/drivers/power/max8925_power.c
@@ -482,6 +482,7 @@ max8925_power_dt_init(struct platform_device *pdev)
 static int max8925_power_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {}; /* Only for ac and usb */
 	struct max8925_power_pdata *pdata = NULL;
 	struct max8925_power_info *info;
 	int ret;
@@ -502,14 +503,15 @@ static int max8925_power_probe(struct platform_device *pdev)
 	info->adc = chip->adc;
 	platform_set_drvdata(pdev, info);
 
+	psy_cfg.supplied_to = pdata->supplied_to;
+	psy_cfg.num_supplicants = pdata->num_supplicants;
+
 	info->ac.name = "max8925-ac";
 	info->ac.type = POWER_SUPPLY_TYPE_MAINS;
 	info->ac.properties = max8925_ac_props;
 	info->ac.num_properties = ARRAY_SIZE(max8925_ac_props);
 	info->ac.get_property = max8925_ac_get_prop;
-	info->ac.supplied_to = pdata->supplied_to;
-	info->ac.num_supplicants = pdata->num_supplicants;
-	ret = power_supply_register(&pdev->dev, &info->ac);
+	ret = power_supply_register(&pdev->dev, &info->ac, &psy_cfg);
 	if (ret)
 		goto out;
 	info->ac.dev->parent = &pdev->dev;
@@ -519,10 +521,8 @@ static int max8925_power_probe(struct platform_device *pdev)
 	info->usb.properties = max8925_usb_props;
 	info->usb.num_properties = ARRAY_SIZE(max8925_usb_props);
 	info->usb.get_property = max8925_usb_get_prop;
-	info->usb.supplied_to = pdata->supplied_to;
-	info->usb.num_supplicants = pdata->num_supplicants;
 
-	ret = power_supply_register(&pdev->dev, &info->usb);
+	ret = power_supply_register(&pdev->dev, &info->usb, &psy_cfg);
 	if (ret)
 		goto out_usb;
 	info->usb.dev->parent = &pdev->dev;
@@ -532,7 +532,7 @@ static int max8925_power_probe(struct platform_device *pdev)
 	info->battery.properties = max8925_battery_props;
 	info->battery.num_properties = ARRAY_SIZE(max8925_battery_props);
 	info->battery.get_property = max8925_bat_get_prop;
-	ret = power_supply_register(&pdev->dev, &info->battery);
+	ret = power_supply_register(&pdev->dev, &info->battery, NULL);
 	if (ret)
 		goto out_battery;
 	info->battery.dev->parent = &pdev->dev;
diff --git a/drivers/power/max8997_charger.c b/drivers/power/max8997_charger.c
index aefa0c9a3007..a9f4d506eb44 100644
--- a/drivers/power/max8997_charger.c
+++ b/drivers/power/max8997_charger.c
@@ -156,7 +156,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
 	charger->dev = &pdev->dev;
 	charger->iodev = iodev;
 
-	ret = power_supply_register(&pdev->dev, &charger->battery);
+	ret = power_supply_register(&pdev->dev, &charger->battery, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		return ret;
diff --git a/drivers/power/max8998_charger.c b/drivers/power/max8998_charger.c
index 08694c7a9f38..9ee72314b3d0 100644
--- a/drivers/power/max8998_charger.c
+++ b/drivers/power/max8998_charger.c
@@ -167,7 +167,7 @@ static int max8998_battery_probe(struct platform_device *pdev)
 	max8998->battery.properties = max8998_battery_props;
 	max8998->battery.num_properties = ARRAY_SIZE(max8998_battery_props);
 
-	ret = power_supply_register(max8998->dev, &max8998->battery);
+	ret = power_supply_register(max8998->dev, &max8998->battery, NULL);
 	if (ret) {
 		dev_err(max8998->dev, "failed: power supply register\n");
 		goto err;
diff --git a/drivers/power/olpc_battery.c b/drivers/power/olpc_battery.c
index ad9cde705de1..1340a1a75325 100644
--- a/drivers/power/olpc_battery.c
+++ b/drivers/power/olpc_battery.c
@@ -619,7 +619,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 
 	/* Ignore the status. It doesn't actually matter */
 
-	ret = power_supply_register(&pdev->dev, &olpc_ac);
+	ret = power_supply_register(&pdev->dev, &olpc_ac, NULL);
 	if (ret)
 		return ret;
 
@@ -631,7 +631,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 		olpc_bat.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
 
-	ret = power_supply_register(&pdev->dev, &olpc_bat);
+	ret = power_supply_register(&pdev->dev, &olpc_bat, NULL);
 	if (ret)
 		goto battery_failed;
 
diff --git a/drivers/power/pcf50633-charger.c b/drivers/power/pcf50633-charger.c
index 771c4f0fb8ac..88fe7db2afcf 100644
--- a/drivers/power/pcf50633-charger.c
+++ b/drivers/power/pcf50633-charger.c
@@ -368,6 +368,7 @@ static const u8 mbc_irq_handlers[] = {
 
 static int pcf50633_mbc_probe(struct platform_device *pdev)
 {
+	struct power_supply_config psy_cfg = {};
 	struct pcf50633_mbc *mbc;
 	int ret;
 	int i;
@@ -385,45 +386,42 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 		pcf50633_register_irq(mbc->pcf, mbc_irq_handlers[i],
 					pcf50633_mbc_irq_handler, mbc);
 
+	psy_cfg.supplied_to		= mbc->pcf->pdata->batteries;
+	psy_cfg.num_supplicants		= mbc->pcf->pdata->num_batteries;
+
 	/* Create power supplies */
 	mbc->adapter.name		= "adapter";
 	mbc->adapter.type		= POWER_SUPPLY_TYPE_MAINS;
 	mbc->adapter.properties		= power_props;
 	mbc->adapter.num_properties	= ARRAY_SIZE(power_props);
 	mbc->adapter.get_property	= &adapter_get_property;
-	mbc->adapter.supplied_to	= mbc->pcf->pdata->batteries;
-	mbc->adapter.num_supplicants	= mbc->pcf->pdata->num_batteries;
 
 	mbc->usb.name			= "usb";
 	mbc->usb.type			= POWER_SUPPLY_TYPE_USB;
 	mbc->usb.properties		= power_props;
 	mbc->usb.num_properties		= ARRAY_SIZE(power_props);
 	mbc->usb.get_property		= usb_get_property;
-	mbc->usb.supplied_to		= mbc->pcf->pdata->batteries;
-	mbc->usb.num_supplicants	= mbc->pcf->pdata->num_batteries;
 
 	mbc->ac.name			= "ac";
 	mbc->ac.type			= POWER_SUPPLY_TYPE_MAINS;
 	mbc->ac.properties		= power_props;
 	mbc->ac.num_properties		= ARRAY_SIZE(power_props);
 	mbc->ac.get_property		= ac_get_property;
-	mbc->ac.supplied_to		= mbc->pcf->pdata->batteries;
-	mbc->ac.num_supplicants		= mbc->pcf->pdata->num_batteries;
 
-	ret = power_supply_register(&pdev->dev, &mbc->adapter);
+	ret = power_supply_register(&pdev->dev, &mbc->adapter, &psy_cfg);
 	if (ret) {
 		dev_err(mbc->pcf->dev, "failed to register adapter\n");
 		return ret;
 	}
 
-	ret = power_supply_register(&pdev->dev, &mbc->usb);
+	ret = power_supply_register(&pdev->dev, &mbc->usb, &psy_cfg);
 	if (ret) {
 		dev_err(mbc->pcf->dev, "failed to register usb\n");
 		power_supply_unregister(&mbc->adapter);
 		return ret;
 	}
 
-	ret = power_supply_register(&pdev->dev, &mbc->ac);
+	ret = power_supply_register(&pdev->dev, &mbc->ac, &psy_cfg);
 	if (ret) {
 		dev_err(mbc->pcf->dev, "failed to register ac\n");
 		power_supply_unregister(&mbc->adapter);
diff --git a/drivers/power/pda_power.c b/drivers/power/pda_power.c
index 0c52e2a0d90c..fd55fad1d0db 100644
--- a/drivers/power/pda_power.c
+++ b/drivers/power/pda_power.c
@@ -83,8 +83,6 @@ static char *pda_power_supplied_to[] = {
 static struct power_supply pda_psy_ac = {
 	.name = "ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
-	.supplied_to = pda_power_supplied_to,
-	.num_supplicants = ARRAY_SIZE(pda_power_supplied_to),
 	.properties = pda_power_props,
 	.num_properties = ARRAY_SIZE(pda_power_props),
 	.get_property = pda_power_get_property,
@@ -93,8 +91,6 @@ static struct power_supply pda_psy_ac = {
 static struct power_supply pda_psy_usb = {
 	.name = "usb",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.supplied_to = pda_power_supplied_to,
-	.num_supplicants = ARRAY_SIZE(pda_power_supplied_to),
 	.properties = pda_power_props,
 	.num_properties = ARRAY_SIZE(pda_power_props),
 	.get_property = pda_power_get_property,
@@ -262,6 +258,7 @@ static int otg_handle_notification(struct notifier_block *nb,
 
 static int pda_power_probe(struct platform_device *pdev)
 {
+	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 
 	dev = &pdev->dev;
@@ -309,10 +306,11 @@ static int pda_power_probe(struct platform_device *pdev)
 	usb_irq = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "usb");
 
 	if (pdata->supplied_to) {
-		pda_psy_ac.supplied_to = pdata->supplied_to;
-		pda_psy_ac.num_supplicants = pdata->num_supplicants;
-		pda_psy_usb.supplied_to = pdata->supplied_to;
-		pda_psy_usb.num_supplicants = pdata->num_supplicants;
+		psy_cfg.supplied_to = pdata->supplied_to;
+		psy_cfg.num_supplicants = pdata->num_supplicants;
+	} else {
+		psy_cfg.supplied_to = pda_power_supplied_to;
+		psy_cfg.num_supplicants = ARRAY_SIZE(pda_power_supplied_to);
 	}
 
 #if IS_ENABLED(CONFIG_USB_PHY)
@@ -326,7 +324,7 @@ static int pda_power_probe(struct platform_device *pdev)
 #endif
 
 	if (pdata->is_ac_online) {
-		ret = power_supply_register(&pdev->dev, &pda_psy_ac);
+		ret = power_supply_register(&pdev->dev, &pda_psy_ac, &psy_cfg);
 		if (ret) {
 			dev_err(dev, "failed to register %s power supply\n",
 				pda_psy_ac.name);
@@ -347,7 +345,7 @@ static int pda_power_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->is_usb_online) {
-		ret = power_supply_register(&pdev->dev, &pda_psy_usb);
+		ret = power_supply_register(&pdev->dev, &pda_psy_usb, &psy_cfg);
 		if (ret) {
 			dev_err(dev, "failed to register %s power supply\n",
 				pda_psy_usb.name);
diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index 777324992c59..d2e88e473238 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -989,6 +989,7 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 		const struct i2c_device_id *id)
 {
 	struct pm2xxx_platform_data *pl_data = i2c_client->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct pm2xxx_charger *pm2;
 	int ret = 0;
 	u8 val;
@@ -1047,8 +1048,9 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 	pm2->ac_chg.psy.properties = pm2xxx_charger_ac_props;
 	pm2->ac_chg.psy.num_properties = ARRAY_SIZE(pm2xxx_charger_ac_props);
 	pm2->ac_chg.psy.get_property = pm2xxx_charger_ac_get_property;
-	pm2->ac_chg.psy.supplied_to = pm2->pdata->supplied_to;
-	pm2->ac_chg.psy.num_supplicants = pm2->pdata->num_supplicants;
+
+	psy_cfg.supplied_to = pm2->pdata->supplied_to;
+	psy_cfg.num_supplicants = pm2->pdata->num_supplicants;
 	/* pm2xxx_charger sub-class */
 	pm2->ac_chg.ops.enable = &pm2xxx_charger_ac_en;
 	pm2->ac_chg.ops.kick_wd = &pm2xxx_charger_watchdog_kick;
@@ -1093,7 +1095,7 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 	}
 
 	/* Register AC charger class */
-	ret = power_supply_register(pm2->dev, &pm2->ac_chg.psy);
+	ret = power_supply_register(pm2->dev, &pm2->ac_chg.psy, &psy_cfg);
 	if (ret) {
 		dev_err(pm2->dev, "failed to register AC charger\n");
 		goto free_regulator;
diff --git a/drivers/power/pmu_battery.c b/drivers/power/pmu_battery.c
index 023d24993b87..fb026f19aa4a 100644
--- a/drivers/power/pmu_battery.c
+++ b/drivers/power/pmu_battery.c
@@ -152,7 +152,7 @@ static int __init pmu_bat_init(void)
 		goto pdev_register_failed;
 	}
 
-	ret = power_supply_register(&bat_pdev->dev, &pmu_ac);
+	ret = power_supply_register(&bat_pdev->dev, &pmu_ac, NULL);
 	if (ret)
 		goto ac_register_failed;
 
@@ -169,7 +169,7 @@ static int __init pmu_bat_init(void)
 		pbat->bat.get_property = pmu_bat_get_property;
 		pbat->pbi = &pmu_batteries[i];
 
-		ret = power_supply_register(&bat_pdev->dev, &pbat->bat);
+		ret = power_supply_register(&bat_pdev->dev, &pbat->bat, NULL);
 		if (ret) {
 			kfree(pbat);
 			goto battery_register_failed;
diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 1c0978f961ea..a21e36ed8d41 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -536,7 +536,9 @@ static void psy_unregister_cooler(struct power_supply *psy)
 #endif
 
 static int __power_supply_register(struct device *parent,
-				   struct power_supply *psy, bool ws)
+				   struct power_supply *psy,
+				   const struct power_supply_config *cfg,
+				   bool ws)
 {
 	struct device *dev;
 	int rc;
@@ -553,6 +555,12 @@ static int __power_supply_register(struct device *parent,
 	dev->release = power_supply_dev_release;
 	dev_set_drvdata(dev, psy);
 	psy->dev = dev;
+	if (cfg) {
+		psy->drv_data = cfg->drv_data;
+		psy->of_node = cfg->of_node;
+		psy->supplied_to = cfg->supplied_to;
+		psy->num_supplicants = cfg->num_supplicants;
+	}
 
 	rc = dev_set_name(dev, "%s", psy->name);
 	if (rc)
@@ -605,15 +613,17 @@ dev_set_name_failed:
 	return rc;
 }
 
-int power_supply_register(struct device *parent, struct power_supply *psy)
+int power_supply_register(struct device *parent, struct power_supply *psy,
+		const struct power_supply_config *cfg)
 {
-	return __power_supply_register(parent, psy, true);
+	return __power_supply_register(parent, psy, cfg, true);
 }
 EXPORT_SYMBOL_GPL(power_supply_register);
 
-int power_supply_register_no_ws(struct device *parent, struct power_supply *psy)
+int power_supply_register_no_ws(struct device *parent, struct power_supply *psy,
+		const struct power_supply_config *cfg)
 {
-	return __power_supply_register(parent, psy, false);
+	return __power_supply_register(parent, psy, cfg, false);
 }
 EXPORT_SYMBOL_GPL(power_supply_register_no_ws);
 
@@ -624,7 +634,8 @@ static void devm_power_supply_release(struct device *dev, void *res)
 	power_supply_unregister(*psy);
 }
 
-int devm_power_supply_register(struct device *parent, struct power_supply *psy)
+int devm_power_supply_register(struct device *parent, struct power_supply *psy,
+		const struct power_supply_config *cfg)
 {
 	struct power_supply **ptr = devres_alloc(devm_power_supply_release,
 						 sizeof(*ptr), GFP_KERNEL);
@@ -632,7 +643,7 @@ int devm_power_supply_register(struct device *parent, struct power_supply *psy)
 
 	if (!ptr)
 		return -ENOMEM;
-	ret = __power_supply_register(parent, psy, true);
+	ret = __power_supply_register(parent, psy, cfg, true);
 	if (ret < 0)
 		devres_free(ptr);
 	else {
@@ -643,7 +654,8 @@ int devm_power_supply_register(struct device *parent, struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(devm_power_supply_register);
 
-int devm_power_supply_register_no_ws(struct device *parent, struct power_supply *psy)
+int devm_power_supply_register_no_ws(struct device *parent, struct power_supply *psy,
+		const struct power_supply_config *cfg)
 {
 	struct power_supply **ptr = devres_alloc(devm_power_supply_release,
 						 sizeof(*ptr), GFP_KERNEL);
@@ -651,7 +663,7 @@ int devm_power_supply_register_no_ws(struct device *parent, struct power_supply
 
 	if (!ptr)
 		return -ENOMEM;
-	ret = __power_supply_register(parent, psy, false);
+	ret = __power_supply_register(parent, psy, cfg, false);
 	if (ret < 0)
 		devres_free(ptr);
 	else {
diff --git a/drivers/power/rt5033_battery.c b/drivers/power/rt5033_battery.c
index 995247af14fc..8cf000baaf36 100644
--- a/drivers/power/rt5033_battery.c
+++ b/drivers/power/rt5033_battery.c
@@ -138,7 +138,7 @@ static int rt5033_battery_probe(struct i2c_client *client,
 	battery->psy.properties		= rt5033_battery_props;
 	battery->psy.num_properties	= ARRAY_SIZE(rt5033_battery_props);
 
-	ret = power_supply_register(&client->dev, &battery->psy);
+	ret = power_supply_register(&client->dev, &battery->psy, NULL);
 	if (ret) {
 		dev_err(&client->dev, "Failed to register power supply\n");
 		return ret;
diff --git a/drivers/power/rx51_battery.c b/drivers/power/rx51_battery.c
index a01aacb32f59..804f60c7b715 100644
--- a/drivers/power/rx51_battery.c
+++ b/drivers/power/rx51_battery.c
@@ -238,7 +238,7 @@ static int rx51_battery_probe(struct platform_device *pdev)
 		goto error_channel_bsi;
 	}
 
-	ret = power_supply_register(di->dev, &di->bat);
+	ret = power_supply_register(di->dev, &di->bat, NULL);
 	if (ret)
 		goto error_channel_vbat;
 
diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/s3c_adc_battery.c
index 5948ce058bdd..b6ff213373dd 100644
--- a/drivers/power/s3c_adc_battery.c
+++ b/drivers/power/s3c_adc_battery.c
@@ -310,14 +310,14 @@ static int s3c_adc_bat_probe(struct platform_device *pdev)
 	main_bat.cable_plugged = 0;
 	main_bat.status = POWER_SUPPLY_STATUS_DISCHARGING;
 
-	ret = power_supply_register(&pdev->dev, &main_bat.psy);
+	ret = power_supply_register(&pdev->dev, &main_bat.psy, NULL);
 	if (ret)
 		goto err_reg_main;
 	if (pdata->backup_volt_mult) {
 		backup_bat.client = client;
 		backup_bat.pdata = pdev->dev.platform_data;
 		backup_bat.volt_value = -1;
-		ret = power_supply_register(&pdev->dev, &backup_bat.psy);
+		ret = power_supply_register(&pdev->dev, &backup_bat.psy, NULL);
 		if (ret)
 			goto err_reg_backup;
 	}
diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index c7b7b4018df3..879f1448fc4a 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -801,6 +801,7 @@ static int sbs_probe(struct i2c_client *client,
 {
 	struct sbs_info *chip;
 	struct sbs_platform_data *pdata = client->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	int rc;
 	int irq;
 	char *name;
@@ -825,7 +826,7 @@ static int sbs_probe(struct i2c_client *client,
 	chip->power_supply.properties = sbs_properties;
 	chip->power_supply.num_properties = ARRAY_SIZE(sbs_properties);
 	chip->power_supply.get_property = sbs_get_property;
-	chip->power_supply.of_node = client->dev.of_node;
+	psy_cfg.of_node = client->dev.of_node;
 	/* ignore first notification of external change, it is generated
 	 * from the power_supply_register call back
 	 */
@@ -892,7 +893,8 @@ skip_gpio:
 		goto exit_psupply;
 	}
 
-	rc = power_supply_register(&client->dev, &chip->power_supply);
+	rc = power_supply_register(&client->dev, &chip->power_supply,
+			&psy_cfg);
 	if (rc) {
 		dev_err(&client->dev,
 			"%s: Failed to register power supply\n", __func__);
diff --git a/drivers/power/smb347-charger.c b/drivers/power/smb347-charger.c
index e9702de262e5..4396a1ffeb1a 100644
--- a/drivers/power/smb347-charger.c
+++ b/drivers/power/smb347-charger.c
@@ -1194,6 +1194,7 @@ static int smb347_probe(struct i2c_client *client,
 {
 	static char *battery[] = { "smb347-battery" };
 	const struct smb347_charger_platform_data *pdata;
+	struct power_supply_config psy_cfg = {}; /* Only for mains and usb */
 	struct device *dev = &client->dev;
 	struct smb347_charger *smb;
 	int ret;
@@ -1223,15 +1224,15 @@ static int smb347_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	psy_cfg.supplied_to = battery;
+	psy_cfg.num_supplicants = ARRAY_SIZE(battery);
 	if (smb->pdata->use_mains) {
 		smb->mains.name = "smb347-mains";
 		smb->mains.type = POWER_SUPPLY_TYPE_MAINS;
 		smb->mains.get_property = smb347_mains_get_property;
 		smb->mains.properties = smb347_mains_properties;
 		smb->mains.num_properties = ARRAY_SIZE(smb347_mains_properties);
-		smb->mains.supplied_to = battery;
-		smb->mains.num_supplicants = ARRAY_SIZE(battery);
-		ret = power_supply_register(dev, &smb->mains);
+		ret = power_supply_register(dev, &smb->mains, &psy_cfg);
 		if (ret < 0)
 			return ret;
 	}
@@ -1242,9 +1243,7 @@ static int smb347_probe(struct i2c_client *client,
 		smb->usb.get_property = smb347_usb_get_property;
 		smb->usb.properties = smb347_usb_properties;
 		smb->usb.num_properties = ARRAY_SIZE(smb347_usb_properties);
-		smb->usb.supplied_to = battery;
-		smb->usb.num_supplicants = ARRAY_SIZE(battery);
-		ret = power_supply_register(dev, &smb->usb);
+		ret = power_supply_register(dev, &smb->usb, &psy_cfg);
 		if (ret < 0) {
 			if (smb->pdata->use_mains)
 				power_supply_unregister(&smb->mains);
@@ -1259,7 +1258,7 @@ static int smb347_probe(struct i2c_client *client,
 	smb->battery.num_properties = ARRAY_SIZE(smb347_battery_properties);
 
 
-	ret = power_supply_register(dev, &smb->battery);
+	ret = power_supply_register(dev, &smb->battery, NULL);
 	if (ret < 0) {
 		if (smb->pdata->use_usb)
 			power_supply_unregister(&smb->usb);
diff --git a/drivers/power/test_power.c b/drivers/power/test_power.c
index f26b1fa00fe1..f6c92d1d7811 100644
--- a/drivers/power/test_power.c
+++ b/drivers/power/test_power.c
@@ -157,8 +157,6 @@ static struct power_supply test_power_supplies[] = {
 	[TEST_AC] = {
 		.name = "test_ac",
 		.type = POWER_SUPPLY_TYPE_MAINS,
-		.supplied_to = test_power_ac_supplied_to,
-		.num_supplicants = ARRAY_SIZE(test_power_ac_supplied_to),
 		.properties = test_power_ac_props,
 		.num_properties = ARRAY_SIZE(test_power_ac_props),
 		.get_property = test_power_get_ac_property,
@@ -173,14 +171,25 @@ static struct power_supply test_power_supplies[] = {
 	[TEST_USB] = {
 		.name = "test_usb",
 		.type = POWER_SUPPLY_TYPE_USB,
-		.supplied_to = test_power_ac_supplied_to,
-		.num_supplicants = ARRAY_SIZE(test_power_ac_supplied_to),
 		.properties = test_power_ac_props,
 		.num_properties = ARRAY_SIZE(test_power_ac_props),
 		.get_property = test_power_get_usb_property,
 	},
 };
 
+static const struct power_supply_config test_power_configs[] = {
+	{
+		/* test_ac */
+		.supplied_to = test_power_ac_supplied_to,
+		.num_supplicants = ARRAY_SIZE(test_power_ac_supplied_to),
+	}, {
+		/* test_battery */
+	}, {
+		/* test_usb */
+		.supplied_to = test_power_ac_supplied_to,
+		.num_supplicants = ARRAY_SIZE(test_power_ac_supplied_to),
+	},
+};
 
 static int __init test_power_init(void)
 {
@@ -188,9 +197,11 @@ static int __init test_power_init(void)
 	int ret;
 
 	BUILD_BUG_ON(TEST_POWER_NUM != ARRAY_SIZE(test_power_supplies));
+	BUILD_BUG_ON(TEST_POWER_NUM != ARRAY_SIZE(test_power_configs));
 
 	for (i = 0; i < ARRAY_SIZE(test_power_supplies); i++) {
-		ret = power_supply_register(NULL, &test_power_supplies[i]);
+		ret = power_supply_register(NULL, &test_power_supplies[i],
+						&test_power_configs[i]);
 		if (ret) {
 			pr_err("%s: failed to register %s\n", __func__,
 				test_power_supplies[i].name);
diff --git a/drivers/power/tosa_battery.c b/drivers/power/tosa_battery.c
index f4d80df627c7..895e4b4dfcf6 100644
--- a/drivers/power/tosa_battery.c
+++ b/drivers/power/tosa_battery.c
@@ -358,13 +358,13 @@ static int tosa_bat_probe(struct platform_device *dev)
 
 	INIT_WORK(&bat_work, tosa_bat_work);
 
-	ret = power_supply_register(&dev->dev, &tosa_bat_main.psy);
+	ret = power_supply_register(&dev->dev, &tosa_bat_main.psy, NULL);
 	if (ret)
 		goto err_psy_reg_main;
-	ret = power_supply_register(&dev->dev, &tosa_bat_jacket.psy);
+	ret = power_supply_register(&dev->dev, &tosa_bat_jacket.psy, NULL);
 	if (ret)
 		goto err_psy_reg_jacket;
-	ret = power_supply_register(&dev->dev, &tosa_bat_bu.psy);
+	ret = power_supply_register(&dev->dev, &tosa_bat_bu.psy, NULL);
 	if (ret)
 		goto err_psy_reg_bu;
 
diff --git a/drivers/power/tps65090-charger.c b/drivers/power/tps65090-charger.c
index 0f4e5971dff5..9872c901bd70 100644
--- a/drivers/power/tps65090-charger.c
+++ b/drivers/power/tps65090-charger.c
@@ -233,6 +233,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 {
 	struct tps65090_charger *cdata;
 	struct tps65090_platform_data *pdata;
+	struct power_supply_config psy_cfg = {};
 	uint8_t status1 = 0;
 	int ret;
 	int irq;
@@ -264,11 +265,12 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	cdata->ac.get_property		= tps65090_ac_get_property;
 	cdata->ac.properties		= tps65090_ac_props;
 	cdata->ac.num_properties	= ARRAY_SIZE(tps65090_ac_props);
-	cdata->ac.supplied_to		= pdata->supplied_to;
-	cdata->ac.num_supplicants	= pdata->num_supplicants;
-	cdata->ac.of_node		= pdev->dev.of_node;
 
-	ret = power_supply_register(&pdev->dev, &cdata->ac);
+	psy_cfg.supplied_to		= pdata->supplied_to;
+	psy_cfg.num_supplicants		= pdata->num_supplicants;
+	psy_cfg.of_node			= pdev->dev.of_node;
+
+	ret = power_supply_register(&pdev->dev, &cdata->ac, &psy_cfg);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		return ret;
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index d35b83e635b5..156f30e64a75 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -590,7 +590,7 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	bci->ac.num_properties = ARRAY_SIZE(twl4030_charger_props);
 	bci->ac.get_property = twl4030_bci_get_property;
 
-	ret = power_supply_register(&pdev->dev, &bci->ac);
+	ret = power_supply_register(&pdev->dev, &bci->ac, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ac: %d\n", ret);
 		goto fail_register_ac;
@@ -604,7 +604,7 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 
 	bci->usb_reg = regulator_get(bci->dev, "bci3v1");
 
-	ret = power_supply_register(&pdev->dev, &bci->usb);
+	ret = power_supply_register(&pdev->dev, &bci->usb, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register usb: %d\n", ret);
 		goto fail_register_usb;
diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index cf907609ec49..d065460c1cb3 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -217,7 +217,7 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 
 	twl4030_madc_bat->pdata = pdata;
 	platform_set_drvdata(pdev, twl4030_madc_bat);
-	ret = power_supply_register(&pdev->dev, &twl4030_madc_bat->psy);
+	ret = power_supply_register(&pdev->dev, &twl4030_madc_bat->psy, NULL);
 	if (ret < 0)
 		kfree(twl4030_madc_bat);
 
diff --git a/drivers/power/wm831x_backup.c b/drivers/power/wm831x_backup.c
index 56fb509f4be0..60ae871148b0 100644
--- a/drivers/power/wm831x_backup.c
+++ b/drivers/power/wm831x_backup.c
@@ -197,7 +197,7 @@ static int wm831x_backup_probe(struct platform_device *pdev)
 	backup->properties = wm831x_backup_props;
 	backup->num_properties = ARRAY_SIZE(wm831x_backup_props);
 	backup->get_property = wm831x_backup_get_prop;
-	ret = power_supply_register(&pdev->dev, backup);
+	ret = power_supply_register(&pdev->dev, backup, NULL);
 
 	return ret;
 }
diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_power.c
index 3bed2f55cf7d..a132aae6225d 100644
--- a/drivers/power/wm831x_power.c
+++ b/drivers/power/wm831x_power.c
@@ -536,7 +536,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	wall->properties = wm831x_wall_props;
 	wall->num_properties = ARRAY_SIZE(wm831x_wall_props);
 	wall->get_property = wm831x_wall_get_prop;
-	ret = power_supply_register(&pdev->dev, wall);
+	ret = power_supply_register(&pdev->dev, wall, NULL);
 	if (ret)
 		goto err_kmalloc;
 
@@ -545,7 +545,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	usb->properties = wm831x_usb_props;
 	usb->num_properties = ARRAY_SIZE(wm831x_usb_props);
 	usb->get_property = wm831x_usb_get_prop;
-	ret = power_supply_register(&pdev->dev, usb);
+	ret = power_supply_register(&pdev->dev, usb, NULL);
 	if (ret)
 		goto err_wall;
 
@@ -560,7 +560,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		    battery->num_properties = ARRAY_SIZE(wm831x_bat_props);
 		    battery->get_property = wm831x_bat_get_prop;
 		    battery->use_for_apm = 1;
-		    ret = power_supply_register(&pdev->dev, battery);
+		    ret = power_supply_register(&pdev->dev, battery, NULL);
 		    if (ret)
 			    goto err_usb;
 	}
diff --git a/drivers/power/wm8350_power.c b/drivers/power/wm8350_power.c
index b3607e2906d2..261ceca561d5 100644
--- a/drivers/power/wm8350_power.c
+++ b/drivers/power/wm8350_power.c
@@ -457,7 +457,7 @@ static int wm8350_power_probe(struct platform_device *pdev)
 	ac->properties = wm8350_ac_props;
 	ac->num_properties = ARRAY_SIZE(wm8350_ac_props);
 	ac->get_property = wm8350_ac_get_prop;
-	ret = power_supply_register(&pdev->dev, ac);
+	ret = power_supply_register(&pdev->dev, ac, NULL);
 	if (ret)
 		return ret;
 
@@ -466,7 +466,7 @@ static int wm8350_power_probe(struct platform_device *pdev)
 	battery->num_properties = ARRAY_SIZE(wm8350_bat_props);
 	battery->get_property = wm8350_bat_get_property;
 	battery->use_for_apm = 1;
-	ret = power_supply_register(&pdev->dev, battery);
+	ret = power_supply_register(&pdev->dev, battery, NULL);
 	if (ret)
 		goto battery_failed;
 
@@ -475,7 +475,7 @@ static int wm8350_power_probe(struct platform_device *pdev)
 	usb->properties = wm8350_usb_props;
 	usb->num_properties = ARRAY_SIZE(wm8350_usb_props);
 	usb->get_property = wm8350_usb_get_prop;
-	ret = power_supply_register(&pdev->dev, usb);
+	ret = power_supply_register(&pdev->dev, usb, NULL);
 	if (ret)
 		goto usb_failed;
 
diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index a8e6203673ad..e81e917bd9d0 100644
--- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -244,7 +244,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	bat_ps.properties = prop;
 	bat_ps.num_properties = props;
 
-	ret = power_supply_register(&dev->dev, &bat_ps);
+	ret = power_supply_register(&dev->dev, &bat_ps, NULL);
 	if (!ret)
 		schedule_work(&bat_work);
 	else
diff --git a/drivers/power/z2_battery.c b/drivers/power/z2_battery.c
index 814d2e31f0c9..df22364212dd 100644
--- a/drivers/power/z2_battery.c
+++ b/drivers/power/z2_battery.c
@@ -230,7 +230,7 @@ static int z2_batt_probe(struct i2c_client *client,
 
 	INIT_WORK(&charger->bat_work, z2_batt_work);
 
-	ret = power_supply_register(&client->dev, &charger->batt_ps);
+	ret = power_supply_register(&client->dev, &charger->batt_ps, NULL);
 	if (ret)
 		goto err4;
 
diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index 6a1459d4f8fb..4bfa84672818 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -334,8 +334,6 @@ static struct power_supply nvec_bat_psy = {
 static struct power_supply nvec_psy = {
 	.name = "ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
-	.supplied_to = nvec_power_supplied_to,
-	.num_supplicants = ARRAY_SIZE(nvec_power_supplied_to),
 	.properties = nvec_power_props,
 	.num_properties = ARRAY_SIZE(nvec_power_props),
 	.get_property = nvec_power_get_property,
@@ -376,6 +374,7 @@ static int nvec_power_probe(struct platform_device *pdev)
 	struct power_supply *psy;
 	struct nvec_power *power;
 	struct nvec_chip *nvec = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
 
 	power = devm_kzalloc(&pdev->dev, sizeof(struct nvec_power), GFP_NOWAIT);
 	if (power == NULL)
@@ -387,6 +386,8 @@ static int nvec_power_probe(struct platform_device *pdev)
 	switch (pdev->id) {
 	case AC:
 		psy = &nvec_psy;
+		psy_cfg.supplied_to = nvec_power_supplied_to;
+		psy_cfg.num_supplicants = ARRAY_SIZE(nvec_power_supplied_to);
 
 		power->notifier.notifier_call = nvec_power_notifier;
 
@@ -407,7 +408,7 @@ static int nvec_power_probe(struct platform_device *pdev)
 	if (pdev->id == BAT)
 		get_bat_mfg_data(power);
 
-	return power_supply_register(&pdev->dev, psy);
+	return power_supply_register(&pdev->dev, psy, &psy_cfg);
 }
 
 static int nvec_power_remove(struct platform_device *pdev)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e30d85c0158d..0d7c95f634a5 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -176,6 +176,16 @@ union power_supply_propval {
 struct device;
 struct device_node;
 
+/* Power supply instance specific configuration */
+struct power_supply_config {
+	struct device_node *of_node;
+	/* Driver private data */
+	void *drv_data;
+
+	char **supplied_to;
+	size_t num_supplicants;
+};
+
 struct power_supply {
 	const char *name;
 	enum power_supply_type type;
@@ -278,13 +288,17 @@ static inline int power_supply_is_system_supplied(void) { return -ENOSYS; }
 #endif
 
 extern int power_supply_register(struct device *parent,
-				 struct power_supply *psy);
+				 struct power_supply *psy,
+				 const struct power_supply_config *cfg);
 extern int power_supply_register_no_ws(struct device *parent,
-				 struct power_supply *psy);
+				 struct power_supply *psy,
+				 const struct power_supply_config *cfg);
 extern int devm_power_supply_register(struct device *parent,
-				 struct power_supply *psy);
+				 struct power_supply *psy,
+				 const struct power_supply_config *cfg);
 extern int devm_power_supply_register_no_ws(struct device *parent,
-				 struct power_supply *psy);
+				 struct power_supply *psy,
+				 const struct power_supply_config *cfg);
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
-- 
1.9.1

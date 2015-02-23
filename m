From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v4 11/20] power_supply: Change ownership from driver to core
Date: Mon, 23 Feb 2015 12:47:32 +0100
Message-ID: <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
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

Change the ownership of power_supply structure from each driver
implementing the class to the power supply core.

The patch changes power_supply_register() function thus all drivers
implementing power supply class are adjusted.

Each driver provides the implementation of power supply. However it
should not be the owner of power supply class instance because it is
exposed by core to other subsystems with power_supply_get_by_name().
These other subsystems have no knowledge when the driver will unregister
the power supply. This leads to several issues when driver is unbound -
mostly because user of power supply accesses freed memory.

Instead let the core own the instance of struct 'power_supply'.  Other
users of this power supply will still access valid memory because it
will be freed when device reference count reaches 0. Currently this
means "it will leak" but power_supply_put() call in next patches will
solve it.

This solves invalid memory references in following race condition
scenario:

Thread 1: charger manager
Thread 2: power supply driver, used by charger manager

THREAD 1 (charger manager)         THREAD 2 (power supply driver)
==========================         ==============================
psy = power_supply_get_by_name()
                                   Driver unbind, .remove
                                     power_supply_unregister()
                                     Device fully removed
psy->get_property()

The 'get_property' call is executed in invalid context because the driver was
unbound and struct 'power_supply' memory was freed.

This could be observed easily with charger manager driver (here compiled
with max17040 fuel gauge):

$ cat /sys/devices/virtual/power_supply/cm-battery/capacity &
$ echo "1-0036" > /sys/bus/i2c/drivers/max17040/unbind
[   55.725123] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   55.732584] pgd = d98d4000
[   55.734060] [00000000] *pgd=5afa2831, *pte=00000000, *ppte=00000000
[   55.740318] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
[   55.746210] Modules linked in:
[   55.749259] CPU: 1 PID: 2936 Comm: cat Tainted: G        W       3.19.0-rc1-next-20141226-00048-gf79f475f3c44-dirty #1496
[   55.760190] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   55.766270] task: d9b76f00 ti: daf54000 task.ti: daf54000
[   55.771647] PC is at 0x0
[   55.774182] LR is at charger_get_property+0x2f4/0x36c
[   55.779201] pc : [<00000000>]    lr : [<c034b0b4>]    psr: 60000013
[   55.779201] sp : daf55e90  ip : 00000003  fp : 00000000
[   55.790657] r10: 00000000  r9 : c06e2878  r8 : d9b26c68
[   55.795865] r7 : dad81610  r6 : daec7410  r5 : daf55ebc  r4 : 00000000
[   55.802367] r3 : 00000000  r2 : daf55ebc  r1 : 0000002a  r0 : d9b26c68
[   55.808879] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   55.815994] Control: 10c5387d  Table: 598d406a  DAC: 00000015
[   55.821723] Process cat (pid: 2936, stack limit = 0xdaf54210)
[   55.827451] Stack: (0xdaf55e90 to 0xdaf56000)
[   55.831795] 5e80:                                     60000013 c01459c4 0000002a c06f8ef8
[   55.839956] 5ea0: db651000 c06f8ef8 daebac00 c04cb668 daebac08 c0346864 00000000 c01459c4
[   55.848115] 5ec0: d99eaa80 c06f8ef8 00000fff 00001000 db651000 c027f25c c027f240 d99eaa80
[   55.856274] 5ee0: d9a06c00 c0146218 daf55f18 00001000 d99eaa80 db4c18c0 00000001 00000001
[   55.864468] 5f00: daf55f80 c0144c78 c0144c54 c0107f90 00015000 d99eaab0 00000000 00000000
[   55.872603] 5f20: 000051c7 00000000 db4c18c0 c04a9370 00015000 00001000 daf55f80 00001000
[   55.880763] 5f40: daf54000 00015000 00000000 c00e53dc db4c18c0 c00e548c 0000000d 00008124
[   55.888937] 5f60: 00000001 00000000 00000000 db4c18c0 db4c18c0 00001000 00015000 c00e5550
[   55.897099] 5f80: 00000000 00000000 00001000 00001000 00015000 00000003 00000003 c000f364
[   55.905239] 5fa0: 00000000 c000f1a0 00001000 00015000 00000003 00015000 00001000 0001333c
[   55.913399] 5fc0: 00001000 00015000 00000003 00000003 00000002 00000000 00000000 00000000
[   55.921560] 5fe0: 7fffe000 be999850 0000a225 b6f3c19c 60000010 00000003 00000000 00000000
[   55.929744] [<c034b0b4>] (charger_get_property) from [<c0346864>] (power_supply_show_property+0x48/0x20c)
[   55.939286] [<c0346864>] (power_supply_show_property) from [<c027f25c>] (dev_attr_show+0x1c/0x48)
[   55.948130] [<c027f25c>] (dev_attr_show) from [<c0146218>] (sysfs_kf_seq_show+0x84/0x104)
[   55.956298] [<c0146218>] (sysfs_kf_seq_show) from [<c0144c78>] (kernfs_seq_show+0x24/0x28)
[   55.964536] [<c0144c78>] (kernfs_seq_show) from [<c0107f90>] (seq_read+0x1b0/0x484)
[   55.972172] [<c0107f90>] (seq_read) from [<c00e53dc>] (__vfs_read+0x18/0x4c)
[   55.979188] [<c00e53dc>] (__vfs_read) from [<c00e548c>] (vfs_read+0x7c/0x100)
[   55.986304] [<c00e548c>] (vfs_read) from [<c00e5550>] (SyS_read+0x40/0x8c)
[   55.993164] [<c00e5550>] (SyS_read) from [<c000f1a0>] (ret_fast_syscall+0x0/0x48)
[   56.000626] Code: bad PC value
[   56.011652] ---[ end trace 7b64343fbdae8ef1 ]---

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

[for the nvec part]
Reviewed-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/x86/platform/olpc/olpc-xo1-sci.c     |   4 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c    |   4 +-
 drivers/acpi/ac.c                         |  32 +++---
 drivers/acpi/battery.c                    |  55 +++++-----
 drivers/acpi/sbs.c                        |  68 +++++++-----
 drivers/hid/hid-input.c                   |  51 +++++----
 drivers/hid/hid-sony.c                    |  43 ++++----
 drivers/hid/hid-wiimote-modules.c         |  41 +++----
 drivers/hid/hid-wiimote.h                 |   3 +-
 drivers/hid/wacom.h                       |   8 +-
 drivers/hid/wacom_sys.c                   |  71 ++++++------
 drivers/platform/x86/compal-laptop.c      |  29 +++--
 drivers/power/88pm860x_battery.c          |  40 +++----
 drivers/power/88pm860x_charger.c          |  32 +++---
 drivers/power/ab8500_btemp.c              |  68 ++++++------
 drivers/power/ab8500_charger.c            | 136 ++++++++++++-----------
 drivers/power/ab8500_fg.c                 | 124 ++++++++-------------
 drivers/power/abx500_chargalg.c           |  90 +++++++--------
 drivers/power/apm_power.c                 |   2 +-
 drivers/power/bq2415x_charger.c           |  73 ++++++-------
 drivers/power/bq24190_charger.c           | 103 +++++++++--------
 drivers/power/bq24735-charger.c           |  45 ++++----
 drivers/power/bq27x00_battery.c           |  70 ++++++------
 drivers/power/charger-manager.c           |  54 ++++-----
 drivers/power/collie_battery.c            |  75 ++++++++-----
 drivers/power/da9030_battery.c            |  33 +++---
 drivers/power/da9052-battery.c            |  25 +++--
 drivers/power/ds2760_battery.c            |  56 +++++-----
 drivers/power/ds2780_battery.c            |  45 +++++---
 drivers/power/ds2781_battery.c            |  47 ++++----
 drivers/power/ds2782_battery.c            |  30 +++--
 drivers/power/generic-adc-battery.c       |  54 +++++----
 drivers/power/goldfish_battery.c          |  63 ++++++-----
 drivers/power/gpio-charger.c              |  34 +++---
 drivers/power/intel_mid_battery.c         |  57 ++++++----
 drivers/power/ipaq_micro_battery.c        |  34 +++---
 drivers/power/isp1704_charger.c           |  49 +++++----
 drivers/power/jz4740-battery.c            |  37 ++++---
 drivers/power/lp8727_charger.c            |  88 ++++++++-------
 drivers/power/lp8788-charger.c            |  55 ++++++----
 drivers/power/ltc2941-battery-gauge.c     |  51 +++++----
 drivers/power/max14577_charger.c          |  34 +++---
 drivers/power/max17040_battery.c          |  31 +++---
 drivers/power/max17042_battery.c          |  45 +++++---
 drivers/power/max77693_charger.c          |  32 +++---
 drivers/power/max8903_charger.c           |  52 +++++----
 drivers/power/max8925_power.c             |  88 ++++++++-------
 drivers/power/max8997_charger.c           |  31 ++++--
 drivers/power/max8998_charger.c           |  32 ++++--
 drivers/power/olpc_battery.c              |  54 +++++----
 drivers/power/pcf50633-charger.c          |  95 +++++++++-------
 drivers/power/pda_power.c                 |  52 +++++----
 drivers/power/pm2301_charger.c            |  42 +++----
 drivers/power/pm2301_charger.h            |   1 +
 drivers/power/pmu_battery.c               |  42 ++++---
 drivers/power/power_supply_core.c         | 176 +++++++++++++++++++-----------
 drivers/power/power_supply_leds.c         |  25 +++--
 drivers/power/power_supply_sysfs.c        |  20 ++--
 drivers/power/rt5033_battery.c            |  27 +++--
 drivers/power/rx51_battery.c              |  27 +++--
 drivers/power/s3c_adc_battery.c           |  77 +++++++------
 drivers/power/sbs-battery.c               |  69 ++++++------
 drivers/power/smb347-charger.c            | 107 +++++++++---------
 drivers/power/test_power.c                |  34 +++---
 drivers/power/tosa_battery.c              | 112 +++++++++++--------
 drivers/power/tps65090-charger.c          |  35 +++---
 drivers/power/twl4030_charger.c           |  65 ++++++-----
 drivers/power/twl4030_madc_battery.c      |  41 +++----
 drivers/power/wm831x_backup.c             |  26 ++---
 drivers/power/wm831x_power.c              |  95 ++++++++--------
 drivers/power/wm8350_power.c              |  89 ++++++++-------
 drivers/power/wm97xx_battery.c            |  37 ++++---
 drivers/power/z2_battery.c                |  60 +++++-----
 drivers/staging/nvec/nvec_power.c         |  29 +++--
 include/linux/hid.h                       |   6 +-
 include/linux/mfd/abx500/ux500_chargalg.h |  11 +-
 include/linux/mfd/rt5033.h                |   2 +-
 include/linux/mfd/wm8350/supply.h         |   6 +-
 include/linux/power/charger-manager.h     |   3 +-
 include/linux/power_supply.h              |  39 ++++---
 80 files changed, 2172 insertions(+), 1756 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 9a2e590dd202..e4ed28bbf79d 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -61,7 +61,7 @@ static void battery_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(psy->dev);
+		put_device(&psy->dev);
 	}
 }
 
@@ -71,7 +71,7 @@ static void ac_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(psy->dev);
+		put_device(&psy->dev);
 	}
 }
 
diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 08e350e757dc..186634e9021d 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -83,7 +83,7 @@ static void battery_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(psy->dev);
+		put_device(&psy->dev);
 	}
 }
 
@@ -93,7 +93,7 @@ static void ac_status_changed(void)
 
 	if (psy) {
 		power_supply_changed(psy);
-		put_device(psy->dev);
+		put_device(&psy->dev);
 	}
 }
 
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 8bf516885ede..bbcc2b5a70d4 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -95,13 +95,14 @@ static struct acpi_driver acpi_ac_driver = {
 };
 
 struct acpi_ac {
-	struct power_supply charger;
+	struct power_supply *charger;
+	struct power_supply_desc charger_desc;
 	struct acpi_device * device;
 	unsigned long long state;
 	struct notifier_block battery_nb;
 };
 
-#define to_acpi_ac(x) container_of(x, struct acpi_ac, charger)
+#define to_acpi_ac(x) power_supply_get_drvdata(x)
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 static const struct file_operations acpi_ac_fops = {
@@ -275,7 +276,7 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 						  dev_name(&device->dev), event,
 						  (u32) ac->state);
 		acpi_notifier_call_chain(device, event, (u32) ac->state);
-		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
+		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
 	}
 
 	return;
@@ -321,6 +322,7 @@ static struct dmi_system_id ac_dmi_table[] = {
 
 static int acpi_ac_add(struct acpi_device *device)
 {
+	struct power_supply_config psy_cfg = {};
 	int result = 0;
 	struct acpi_ac *ac = NULL;
 
@@ -341,19 +343,24 @@ static int acpi_ac_add(struct acpi_device *device)
 	if (result)
 		goto end;
 
-	ac->charger.name = acpi_device_bid(device);
+	psy_cfg.drv_data = ac;
+
+	ac->charger_desc.name = acpi_device_bid(device);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_ac_add_fs(ac);
 	if (result)
 		goto end;
 #endif
-	ac->charger.type = POWER_SUPPLY_TYPE_MAINS;
-	ac->charger.properties = ac_props;
-	ac->charger.num_properties = ARRAY_SIZE(ac_props);
-	ac->charger.get_property = get_ac_property;
-	result = power_supply_register(&ac->device->dev, &ac->charger, NULL);
-	if (result)
+	ac->charger_desc.type = POWER_SUPPLY_TYPE_MAINS;
+	ac->charger_desc.properties = ac_props;
+	ac->charger_desc.num_properties = ARRAY_SIZE(ac_props);
+	ac->charger_desc.get_property = get_ac_property;
+	ac->charger = power_supply_register(&ac->device->dev,
+					    &ac->charger_desc, &psy_cfg);
+	if (IS_ERR(ac->charger)) {
+		result = PTR_ERR(ac->charger);
 		goto end;
+	}
 
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
@@ -390,7 +397,7 @@ static int acpi_ac_resume(struct device *dev)
 	if (acpi_ac_get_state(ac))
 		return 0;
 	if (old_state != ac->state)
-		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
+		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
 	return 0;
 }
 #else
@@ -407,8 +414,7 @@ static int acpi_ac_remove(struct acpi_device *device)
 
 	ac = acpi_driver_data(device);
 
-	if (ac->charger.dev)
-		power_supply_unregister(&ac->charger);
+	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fd8c06f492a1..fdc16ce9d272 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -117,7 +117,8 @@ enum {
 struct acpi_battery {
 	struct mutex lock;
 	struct mutex sysfs_lock;
-	struct power_supply bat;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
 	struct notifier_block pm_nb;
 	unsigned long update_time;
@@ -149,7 +150,7 @@ struct acpi_battery {
 	unsigned long flags;
 };
 
-#define to_acpi_battery(x) container_of(x, struct acpi_battery, bat)
+#define to_acpi_battery(x) power_supply_get_drvdata(x)
 
 static inline int acpi_battery_present(struct acpi_battery *battery)
 {
@@ -608,41 +609,45 @@ static struct device_attribute alarm_attr = {
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	int result;
+	struct power_supply_config psy_cfg = { .drv_data = battery, };
 
 	if (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
-		battery->bat.properties = charge_battery_props;
-		battery->bat.num_properties =
+		battery->bat_desc.properties = charge_battery_props;
+		battery->bat_desc.num_properties =
 			ARRAY_SIZE(charge_battery_props);
 	} else {
-		battery->bat.properties = energy_battery_props;
-		battery->bat.num_properties =
+		battery->bat_desc.properties = energy_battery_props;
+		battery->bat_desc.num_properties =
 			ARRAY_SIZE(energy_battery_props);
 	}
 
-	battery->bat.name = acpi_device_bid(battery->device);
-	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
-	battery->bat.get_property = acpi_battery_get_property;
+	battery->bat_desc.name = acpi_device_bid(battery->device);
+	battery->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	battery->bat_desc.get_property = acpi_battery_get_property;
 
-	result = power_supply_register_no_ws(&battery->device->dev,
-			&battery->bat, NULL);
+	battery->bat = power_supply_register_no_ws(&battery->device->dev,
+				&battery->bat_desc, &psy_cfg);
 
-	if (result)
+	if (IS_ERR(battery->bat)) {
+		int result = PTR_ERR(battery->bat);
+
+		battery->bat = NULL;
 		return result;
-	return device_create_file(battery->bat.dev, &alarm_attr);
+	}
+	return device_create_file(&battery->bat->dev, &alarm_attr);
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
 	mutex_lock(&battery->sysfs_lock);
-	if (!battery->bat.dev) {
+	if (!battery->bat) {
 		mutex_unlock(&battery->sysfs_lock);
 		return;
 	}
 
-	device_remove_file(battery->bat.dev, &alarm_attr);
-	power_supply_unregister(&battery->bat);
-	battery->bat.dev = NULL;
+	device_remove_file(&battery->bat->dev, &alarm_attr);
+	power_supply_unregister(battery->bat);
+	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
 }
 
@@ -739,7 +744,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 			return result;
 		acpi_battery_init_alarm(battery);
 	}
-	if (!battery->bat.dev) {
+	if (!battery->bat) {
 		result = sysfs_add_battery(battery);
 		if (result)
 			return result;
@@ -765,7 +770,7 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 {
 	int power_unit;
 
-	if (!battery->bat.dev)
+	if (!battery->bat)
 		return;
 
 	power_unit = battery->power_unit;
@@ -1063,11 +1068,11 @@ static void acpi_battery_remove_fs(struct acpi_device *device)
 static void acpi_battery_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_battery *battery = acpi_driver_data(device);
-	struct device *old;
+	struct power_supply *old;
 
 	if (!battery)
 		return;
-	old = battery->bat.dev;
+	old = battery->bat;
 	/*
 	* On Acer Aspire V5-573G notifications are sometimes triggered too
 	* early. For example, when AC is unplugged and notification is
@@ -1084,8 +1089,8 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 					acpi_battery_present(battery));
 	acpi_notifier_call_chain(device, event, acpi_battery_present(battery));
 	/* acpi_battery_update could remove power_supply object */
-	if (old && battery->bat.dev)
-		power_supply_changed(&battery->bat);
+	if (old && battery->bat)
+		power_supply_changed(battery->bat);
 }
 
 static int battery_notify(struct notifier_block *nb,
@@ -1101,7 +1106,7 @@ static int battery_notify(struct notifier_block *nb,
 		if (!acpi_battery_present(battery))
 			return 0;
 
-		if (!battery->bat.dev) {
+		if (battery->bat) {
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 2038ec1d021d..cd827625cf07 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -74,7 +74,8 @@ static const struct acpi_device_id sbs_device_ids[] = {
 MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
 
 struct acpi_battery {
-	struct power_supply bat;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
 	struct acpi_sbs *sbs;
 	unsigned long update_time;
 	char name[8];
@@ -101,10 +102,10 @@ struct acpi_battery {
 	u8 have_sysfs_alarm:1;
 };
 
-#define to_acpi_battery(x) container_of(x, struct acpi_battery, bat)
+#define to_acpi_battery(x) power_supply_get_drvdata(x)
 
 struct acpi_sbs {
-	struct power_supply charger;
+	struct power_supply *charger;
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
@@ -115,7 +116,7 @@ struct acpi_sbs {
 	u8 charger_exists:1;
 };
 
-#define to_acpi_sbs(x) container_of(x, struct acpi_sbs, charger)
+#define to_acpi_sbs(x) power_supply_get_drvdata(x)
 
 static int acpi_sbs_remove(struct acpi_device *device);
 static int acpi_battery_get_state(struct acpi_battery *battery);
@@ -303,6 +304,13 @@ static enum power_supply_property sbs_energy_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static const struct power_supply_desc acpi_sbs_charger_desc = {
+	.name		= "sbs-charger",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= sbs_ac_props,
+	.num_properties	= ARRAY_SIZE(sbs_ac_props),
+	.get_property	= sbs_get_ac_property,
+};
 
 /* --------------------------------------------------------------------------
                             Smart Battery System Management
@@ -519,6 +527,7 @@ static int acpi_battery_read(struct acpi_battery *battery)
 static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
+	struct power_supply_config psy_cfg = { .drv_data = battery, };
 	int result;
 
 	battery->id = id;
@@ -528,23 +537,27 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		return result;
 
 	sprintf(battery->name, ACPI_BATTERY_DIR_NAME, id);
-	battery->bat.name = battery->name;
-	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
+	battery->bat_desc.name = battery->name;
+	battery->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	if (!acpi_battery_mode(battery)) {
-		battery->bat.properties = sbs_charge_battery_props;
-		battery->bat.num_properties =
+		battery->bat_desc.properties = sbs_charge_battery_props;
+		battery->bat_desc.num_properties =
 		    ARRAY_SIZE(sbs_charge_battery_props);
 	} else {
-		battery->bat.properties = sbs_energy_battery_props;
-		battery->bat.num_properties =
+		battery->bat_desc.properties = sbs_energy_battery_props;
+		battery->bat_desc.num_properties =
 		    ARRAY_SIZE(sbs_energy_battery_props);
 	}
-	battery->bat.get_property = acpi_sbs_battery_get_property;
-	result = power_supply_register(&sbs->device->dev, &battery->bat, NULL);
-	if (result)
+	battery->bat_desc.get_property = acpi_sbs_battery_get_property;
+	battery->bat = power_supply_register(&sbs->device->dev,
+					&battery->bat_desc, &psy_cfg);
+	if (IS_ERR(battery->bat)) {
+		result = PTR_ERR(battery->bat);
+		battery->bat = NULL;
 		goto end;
+	}
 
-	result = device_create_file(battery->bat.dev, &alarm_attr);
+	result = device_create_file(&battery->bat->dev, &alarm_attr);
 	if (result)
 		goto end;
 	battery->have_sysfs_alarm = 1;
@@ -559,28 +572,29 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
 
-	if (battery->bat.dev) {
+	if (battery->bat) {
 		if (battery->have_sysfs_alarm)
-			device_remove_file(battery->bat.dev, &alarm_attr);
-		power_supply_unregister(&battery->bat);
+			device_remove_file(&battery->bat->dev, &alarm_attr);
+		power_supply_unregister(battery->bat);
 	}
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)
 {
 	int result;
+	struct power_supply_config psy_cfg = { .drv_data = sbs, };
 
 	result = acpi_ac_get_present(sbs);
 	if (result)
 		goto end;
 
 	sbs->charger_exists = 1;
-	sbs->charger.name = "sbs-charger";
-	sbs->charger.type = POWER_SUPPLY_TYPE_MAINS;
-	sbs->charger.properties = sbs_ac_props;
-	sbs->charger.num_properties = ARRAY_SIZE(sbs_ac_props);
-	sbs->charger.get_property = sbs_get_ac_property;
-	power_supply_register(&sbs->device->dev, &sbs->charger, NULL);
+	sbs->charger = power_supply_register(&sbs->device->dev,
+					&acpi_sbs_charger_desc, &psy_cfg);
+	if (IS_ERR(sbs->charger)) {
+		result = PTR_ERR(sbs->charger);
+		sbs->charger = NULL;
+	}
 	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
 	       ACPI_AC_DIR_NAME, sbs->charger_present ? "on-line" : "off-line");
@@ -590,8 +604,8 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 
 static void acpi_charger_remove(struct acpi_sbs *sbs)
 {
-	if (sbs->charger.dev)
-		power_supply_unregister(&sbs->charger);
+	if (sbs->charger)
+		power_supply_unregister(sbs->charger);
 }
 
 static void acpi_sbs_callback(void *context)
@@ -605,7 +619,7 @@ static void acpi_sbs_callback(void *context)
 	if (sbs->charger_exists) {
 		acpi_ac_get_present(sbs);
 		if (sbs->charger_present != saved_charger_state)
-			kobject_uevent(&sbs->charger.dev->kobj, KOBJ_CHANGE);
+			kobject_uevent(&sbs->charger->dev.kobj, KOBJ_CHANGE);
 	}
 
 	if (sbs->manager_present) {
@@ -617,7 +631,7 @@ static void acpi_sbs_callback(void *context)
 			acpi_battery_read(bat);
 			if (saved_battery_state == bat->present)
 				continue;
-			kobject_uevent(&bat->bat.dev->kobj, KOBJ_CHANGE);
+			kobject_uevent(&bat->bat->dev.kobj, KOBJ_CHANGE);
 		}
 	}
 }
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 6182265a6571..5d5a8c42645f 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -339,7 +339,7 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 					 enum power_supply_property prop,
 					 union power_supply_propval *val)
 {
-	struct hid_device *dev = container_of(psy, struct hid_device, battery);
+	struct hid_device *dev = power_supply_get_drvdata(psy);
 	int ret = 0;
 	__u8 *buf;
 
@@ -397,26 +397,32 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 
 static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type, struct hid_field *field)
 {
-	struct power_supply *battery = &dev->battery;
-	int ret;
+	struct power_supply_desc *psy_desc = NULL;
+	struct power_supply_config psy_cfg = { .drv_data = dev, };
 	unsigned quirks;
 	s32 min, max;
 
 	if (field->usage->hid != HID_DC_BATTERYSTRENGTH)
 		return false;	/* no match */
 
-	if (battery->name != NULL)
+	if (dev->battery != NULL)
 		goto out;	/* already initialized? */
 
-	battery->name = kasprintf(GFP_KERNEL, "hid-%s-battery", dev->uniq);
-	if (battery->name == NULL)
+	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
+	if (psy_desc == NULL)
 		goto out;
 
-	battery->type = POWER_SUPPLY_TYPE_BATTERY;
-	battery->properties = hidinput_battery_props;
-	battery->num_properties = ARRAY_SIZE(hidinput_battery_props);
-	battery->use_for_apm = 0;
-	battery->get_property = hidinput_get_battery_property;
+	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery", dev->uniq);
+	if (psy_desc->name == NULL) {
+		kfree(psy_desc);
+		goto out;
+	}
+
+	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	psy_desc->properties = hidinput_battery_props;
+	psy_desc->num_properties = ARRAY_SIZE(hidinput_battery_props);
+	psy_desc->use_for_apm = 0;
+	psy_desc->get_property = hidinput_get_battery_property;
 
 	quirks = find_battery_quirk(dev);
 
@@ -439,14 +445,16 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
 
-	ret = power_supply_register(&dev->dev, battery, NULL);
-	if (ret != 0) {
-		hid_warn(dev, "can't register power supply: %d\n", ret);
-		kfree(battery->name);
-		battery->name = NULL;
+	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(dev->battery)) {
+		hid_warn(dev, "can't register power supply: %ld\n",
+				PTR_ERR(dev->battery));
+		kfree(psy_desc->name);
+		kfree(psy_desc);
+		dev->battery = NULL;
 	}
 
-	power_supply_powers(battery, &dev->dev);
+	power_supply_powers(dev->battery, &dev->dev);
 
 out:
 	return true;
@@ -454,12 +462,13 @@ out:
 
 static void hidinput_cleanup_battery(struct hid_device *dev)
 {
-	if (!dev->battery.name)
+	if (!dev->battery)
 		return;
 
-	power_supply_unregister(&dev->battery);
-	kfree(dev->battery.name);
-	dev->battery.name = NULL;
+	power_supply_unregister(dev->battery);
+	kfree(dev->battery->desc->name);
+	kfree(dev->battery->desc);
+	dev->battery = NULL;
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
 static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 16fc6a17ac63..65007ec2d96e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -815,7 +815,8 @@ struct sony_sc {
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
 	struct work_struct state_worker;
-	struct power_supply battery;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	int device_id;
 	__u8 *output_report_dmabuf;
 
@@ -1660,7 +1661,7 @@ static int sony_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
 {
-	struct sony_sc *sc = container_of(psy, struct sony_sc, battery);
+	struct sony_sc *sc = power_supply_get_drvdata(psy);
 	unsigned long flags;
 	int ret = 0;
 	u8 battery_charging, battery_capacity, cable_state;
@@ -1699,6 +1700,7 @@ static int sony_battery_get_property(struct power_supply *psy,
 
 static int sony_battery_probe(struct sony_sc *sc)
 {
+	struct power_supply_config psy_cfg = { .drv_data = sc, };
 	struct hid_device *hdev = sc->hdev;
 	int ret;
 
@@ -1708,39 +1710,42 @@ static int sony_battery_probe(struct sony_sc *sc)
 	 */
 	sc->battery_capacity = 100;
 
-	sc->battery.properties = sony_battery_props;
-	sc->battery.num_properties = ARRAY_SIZE(sony_battery_props);
-	sc->battery.get_property = sony_battery_get_property;
-	sc->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	sc->battery.use_for_apm = 0;
-	sc->battery.name = kasprintf(GFP_KERNEL, "sony_controller_battery_%pMR",
-				     sc->mac_address);
-	if (!sc->battery.name)
+	sc->battery_desc.properties = sony_battery_props;
+	sc->battery_desc.num_properties = ARRAY_SIZE(sony_battery_props);
+	sc->battery_desc.get_property = sony_battery_get_property;
+	sc->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	sc->battery_desc.use_for_apm = 0;
+	sc->battery_desc.name = kasprintf(GFP_KERNEL,
+					  "sony_controller_battery_%pMR",
+					  sc->mac_address);
+	if (!sc->battery_desc.name)
 		return -ENOMEM;
 
-	ret = power_supply_register(&hdev->dev, &sc->battery, NULL);
-	if (ret) {
+	sc->battery = power_supply_register(&hdev->dev, &sc->battery_desc,
+					    &psy_cfg);
+	if (IS_ERR(sc->battery)) {
+		ret = PTR_ERR(sc->battery);
 		hid_err(hdev, "Unable to register battery device\n");
 		goto err_free;
 	}
 
-	power_supply_powers(&sc->battery, &hdev->dev);
+	power_supply_powers(sc->battery, &hdev->dev);
 	return 0;
 
 err_free:
-	kfree(sc->battery.name);
-	sc->battery.name = NULL;
+	kfree(sc->battery_desc.name);
+	sc->battery_desc.name = NULL;
 	return ret;
 }
 
 static void sony_battery_remove(struct sony_sc *sc)
 {
-	if (!sc->battery.name)
+	if (!sc->battery_desc.name)
 		return;
 
-	power_supply_unregister(&sc->battery);
-	kfree(sc->battery.name);
-	sc->battery.name = NULL;
+	power_supply_unregister(sc->battery);
+	kfree(sc->battery_desc.name);
+	sc->battery_desc.name = NULL;
 }
 
 /*
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 91cb00abcb8e..05e23c417d50 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -203,8 +203,7 @@ static int wiimod_battery_get_property(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       union power_supply_propval *val)
 {
-	struct wiimote_data *wdata = container_of(psy, struct wiimote_data,
-						  battery);
+	struct wiimote_data *wdata = power_supply_get_drvdata(psy);
 	int ret = 0, state;
 	unsigned long flags;
 
@@ -238,42 +237,46 @@ static int wiimod_battery_get_property(struct power_supply *psy,
 static int wiimod_battery_probe(const struct wiimod_ops *ops,
 				struct wiimote_data *wdata)
 {
+	struct power_supply_config psy_cfg = { .drv_data = wdata, };
 	int ret;
 
-	wdata->battery.properties = wiimod_battery_props;
-	wdata->battery.num_properties = ARRAY_SIZE(wiimod_battery_props);
-	wdata->battery.get_property = wiimod_battery_get_property;
-	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	wdata->battery.use_for_apm = 0;
-	wdata->battery.name = kasprintf(GFP_KERNEL, "wiimote_battery_%s",
-					wdata->hdev->uniq);
-	if (!wdata->battery.name)
+	wdata->battery_desc.properties = wiimod_battery_props;
+	wdata->battery_desc.num_properties = ARRAY_SIZE(wiimod_battery_props);
+	wdata->battery_desc.get_property = wiimod_battery_get_property;
+	wdata->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	wdata->battery_desc.use_for_apm = 0;
+	wdata->battery_desc.name = kasprintf(GFP_KERNEL, "wiimote_battery_%s",
+					     wdata->hdev->uniq);
+	if (!wdata->battery_desc.name)
 		return -ENOMEM;
 
-	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery, NULL);
-	if (ret) {
+	wdata->battery = power_supply_register(&wdata->hdev->dev,
+					       &wdata->battery_desc,
+					       &psy_cfg);
+	if (IS_ERR(wdata->battery)) {
 		hid_err(wdata->hdev, "cannot register battery device\n");
+		ret = PTR_ERR(wdata->battery);
 		goto err_free;
 	}
 
-	power_supply_powers(&wdata->battery, &wdata->hdev->dev);
+	power_supply_powers(wdata->battery, &wdata->hdev->dev);
 	return 0;
 
 err_free:
-	kfree(wdata->battery.name);
-	wdata->battery.name = NULL;
+	kfree(wdata->battery_desc.name);
+	wdata->battery_desc.name = NULL;
 	return ret;
 }
 
 static void wiimod_battery_remove(const struct wiimod_ops *ops,
 				  struct wiimote_data *wdata)
 {
-	if (!wdata->battery.name)
+	if (!wdata->battery_desc.name)
 		return;
 
-	power_supply_unregister(&wdata->battery);
-	kfree(wdata->battery.name);
-	wdata->battery.name = NULL;
+	power_supply_unregister(wdata->battery);
+	kfree(wdata->battery_desc.name);
+	wdata->battery_desc.name = NULL;
 }
 
 static const struct wiimod_ops wiimod_battery = {
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 10934aa129fb..875694d43e4d 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -147,7 +147,8 @@ struct wiimote_data {
 	struct led_classdev *leds[4];
 	struct input_dev *accel;
 	struct input_dev *ir;
-	struct power_supply battery;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	struct input_dev *mp;
 	struct timer_list timer;
 	struct wiimote_debug *debug;
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 7db432809e9e..0d0d0dd89d17 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -119,8 +119,10 @@ struct wacom {
 		u8 img_lum;   /* OLED matrix display brightness */
 	} led;
 	bool led_initialized;
-	struct power_supply battery;
-	struct power_supply ac;
+	struct power_supply *battery;
+	struct power_supply *ac;
+	struct power_supply_desc battery_desc;
+	struct power_supply_desc ac_desc;
 };
 
 static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
@@ -133,7 +135,7 @@ static inline void wacom_notify_battery(struct wacom_wac *wacom_wac)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 
-	power_supply_changed(&wacom->battery);
+	power_supply_changed(wacom->battery);
 }
 
 extern const struct hid_device_id wacom_ids[];
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 148949c0e039..ba9af470bea0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -944,7 +944,7 @@ static int wacom_battery_get_property(struct power_supply *psy,
 				      enum power_supply_property psp,
 				      union power_supply_propval *val)
 {
-	struct wacom *wacom = container_of(psy, struct wacom, battery);
+	struct wacom *wacom = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
@@ -976,7 +976,7 @@ static int wacom_ac_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct wacom *wacom = container_of(psy, struct wacom, ac);
+	struct wacom *wacom = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
@@ -998,43 +998,46 @@ static int wacom_ac_get_property(struct power_supply *psy,
 static int wacom_initialize_battery(struct wacom *wacom)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
-	int error;
+	struct power_supply_config psy_cfg = { .drv_data = wacom, };
 	unsigned long n;
 
 	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) {
+		struct power_supply_desc *bat_desc = &wacom->battery_desc;
+		struct power_supply_desc *ac_desc = &wacom->ac_desc;
 		n = atomic_inc_return(&battery_no) - 1;
 
-		wacom->battery.properties = wacom_battery_props;
-		wacom->battery.num_properties = ARRAY_SIZE(wacom_battery_props);
-		wacom->battery.get_property = wacom_battery_get_property;
+		bat_desc->properties = wacom_battery_props;
+		bat_desc->num_properties = ARRAY_SIZE(wacom_battery_props);
+		bat_desc->get_property = wacom_battery_get_property;
 		sprintf(wacom->wacom_wac.bat_name, "wacom_battery_%ld", n);
-		wacom->battery.name = wacom->wacom_wac.bat_name;
-		wacom->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-		wacom->battery.use_for_apm = 0;
+		bat_desc->name = wacom->wacom_wac.bat_name;
+		bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+		bat_desc->use_for_apm = 0;
 
-		wacom->ac.properties = wacom_ac_props;
-		wacom->ac.num_properties = ARRAY_SIZE(wacom_ac_props);
-		wacom->ac.get_property = wacom_ac_get_property;
+		ac_desc->properties = wacom_ac_props;
+		ac_desc->num_properties = ARRAY_SIZE(wacom_ac_props);
+		ac_desc->get_property = wacom_ac_get_property;
 		sprintf(wacom->wacom_wac.ac_name, "wacom_ac_%ld", n);
-		wacom->ac.name = wacom->wacom_wac.ac_name;
-		wacom->ac.type = POWER_SUPPLY_TYPE_MAINS;
-		wacom->ac.use_for_apm = 0;
-
-		error = power_supply_register(&wacom->hdev->dev,
-					      &wacom->battery, NULL);
-		if (error)
-			return error;
-
-		power_supply_powers(&wacom->battery, &wacom->hdev->dev);
-
-		error = power_supply_register(&wacom->hdev->dev, &wacom->ac,
-					      NULL);
-		if (error) {
-			power_supply_unregister(&wacom->battery);
-			return error;
+		ac_desc->name = wacom->wacom_wac.ac_name;
+		ac_desc->type = POWER_SUPPLY_TYPE_MAINS;
+		ac_desc->use_for_apm = 0;
+
+		wacom->battery = power_supply_register(&wacom->hdev->dev,
+					      &wacom->battery_desc, &psy_cfg);
+		if (IS_ERR(wacom->battery))
+			return PTR_ERR(wacom->battery);
+
+		power_supply_powers(wacom->battery, &wacom->hdev->dev);
+
+		wacom->ac = power_supply_register(&wacom->hdev->dev,
+						  &wacom->ac_desc,
+						  &psy_cfg);
+		if (IS_ERR(wacom->ac)) {
+			power_supply_unregister(wacom->battery);
+			return PTR_ERR(wacom->ac);
 		}
 
-		power_supply_powers(&wacom->ac, &wacom->hdev->dev);
+		power_supply_powers(wacom->ac, &wacom->hdev->dev);
 	}
 
 	return 0;
@@ -1043,11 +1046,11 @@ static int wacom_initialize_battery(struct wacom *wacom)
 static void wacom_destroy_battery(struct wacom *wacom)
 {
 	if ((wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) &&
-	     wacom->battery.dev) {
-		power_supply_unregister(&wacom->battery);
-		wacom->battery.dev = NULL;
-		power_supply_unregister(&wacom->ac);
-		wacom->ac.dev = NULL;
+	     wacom->battery) {
+		power_supply_unregister(wacom->battery);
+		wacom->battery = NULL;
+		power_supply_unregister(wacom->ac);
+		wacom->ac = NULL;
 	}
 }
 
diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index 041a592fe753..b4e94471f3d5 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -177,7 +177,7 @@ struct compal_data{
 	unsigned char curr_pwm;
 
 	/* Power supply */
-	struct power_supply psy;
+	struct power_supply *psy;
 	struct power_supply_info psy_info;
 	char bat_model_name[BAT_MODEL_NAME_LEN + 1];
 	char bat_manufacturer_name[BAT_MANUFACTURER_NAME_LEN + 1];
@@ -565,8 +565,7 @@ static int bat_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct compal_data *data;
-	data = container_of(psy, struct compal_data, psy);
+	struct compal_data *data = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -875,13 +874,16 @@ static struct dmi_system_id __initdata compal_dmi_table[] = {
 };
 MODULE_DEVICE_TABLE(dmi, compal_dmi_table);
 
+static const struct power_supply_desc psy_bat_desc = {
+	.name		= DRIVER_NAME,
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= compal_bat_properties,
+	.num_properties	= ARRAY_SIZE(compal_bat_properties),
+	.get_property	= bat_get_property,
+};
+
 static void initialize_power_supply_data(struct compal_data *data)
 {
-	data->psy.name = DRIVER_NAME;
-	data->psy.type = POWER_SUPPLY_TYPE_BATTERY;
-	data->psy.properties = compal_bat_properties;
-	data->psy.num_properties = ARRAY_SIZE(compal_bat_properties);
-	data->psy.get_property = bat_get_property;
 
 	ec_read_sequence(BAT_MANUFACTURER_NAME_ADDR,
 					data->bat_manufacturer_name,
@@ -1011,6 +1013,7 @@ static int compal_probe(struct platform_device *pdev)
 	int err;
 	struct compal_data *data;
 	struct device *hwmon_dev;
+	struct power_supply_config psy_cfg = {};
 
 	if (!extra_features)
 		return 0;
@@ -1036,9 +1039,13 @@ static int compal_probe(struct platform_device *pdev)
 
 	/* Power supply */
 	initialize_power_supply_data(data);
-	err = power_supply_register(&compal_device->dev, &data->psy, NULL);
-	if (err < 0)
+	psy_cfg.drv_data = data;
+	data->psy = power_supply_register(&compal_device->dev, &psy_bat_desc,
+					  &psy_cfg);
+	if (IS_ERR(data->psy)) {
+		err = PTR_ERR(data->psy);
 		goto remove;
+	}
 
 	platform_set_drvdata(pdev, data);
 
@@ -1073,7 +1080,7 @@ static int compal_remove(struct platform_device *pdev)
 	pwm_disable_control();
 
 	data = platform_get_drvdata(pdev);
-	power_supply_unregister(&data->psy);
+	power_supply_unregister(data->psy);
 
 	sysfs_remove_group(&pdev->dev.kobj, &compal_platform_attr_group);
 
diff --git a/drivers/power/88pm860x_battery.c b/drivers/power/88pm860x_battery.c
index a99d7f2829a7..d49579b227ec 100644
--- a/drivers/power/88pm860x_battery.c
+++ b/drivers/power/88pm860x_battery.c
@@ -98,7 +98,7 @@ struct pm860x_battery_info {
 	struct i2c_client *i2c;
 	struct device *dev;
 
-	struct power_supply battery;
+	struct power_supply *battery;
 	struct mutex lock;
 	int status;
 	int irq_cc;
@@ -798,9 +798,8 @@ out:
 
 static void pm860x_external_power_changed(struct power_supply *psy)
 {
-	struct pm860x_battery_info *info;
+	struct pm860x_battery_info *info = dev_get_drvdata(psy->dev.parent);
 
-	info = container_of(psy, struct pm860x_battery_info, battery);
 	calc_resistor(info);
 }
 
@@ -808,7 +807,7 @@ static int pm860x_batt_get_prop(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct pm860x_battery_info *info = dev_get_drvdata(psy->dev->parent);
+	struct pm860x_battery_info *info = dev_get_drvdata(psy->dev.parent);
 	int data;
 	int ret;
 
@@ -874,7 +873,7 @@ static int pm860x_batt_set_prop(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       const union power_supply_propval *val)
 {
-	struct pm860x_battery_info *info = dev_get_drvdata(psy->dev->parent);
+	struct pm860x_battery_info *info = dev_get_drvdata(psy->dev.parent);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
@@ -901,6 +900,16 @@ static enum power_supply_property pm860x_batt_props[] = {
 	POWER_SUPPLY_PROP_TEMP,
 };
 
+static const struct power_supply_desc pm860x_battery_desc = {
+	.name			= "battery-monitor",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= pm860x_batt_props,
+	.num_properties		= ARRAY_SIZE(pm860x_batt_props),
+	.get_property		= pm860x_batt_get_prop,
+	.set_property		= pm860x_batt_set_prop,
+	.external_power_changed	= pm860x_external_power_changed,
+};
+
 static int pm860x_battery_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -936,14 +945,6 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 
 	pm860x_init_battery(info);
 
-	info->battery.name = "battery-monitor";
-	info->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	info->battery.properties = pm860x_batt_props;
-	info->battery.num_properties = ARRAY_SIZE(pm860x_batt_props);
-	info->battery.get_property = pm860x_batt_get_prop;
-	info->battery.set_property = pm860x_batt_set_prop;
-	info->battery.external_power_changed = pm860x_external_power_changed;
-
 	if (pdata && pdata->max_capacity)
 		info->max_capacity = pdata->max_capacity;
 	else
@@ -953,10 +954,11 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 	else
 		info->resistor = 300;	/* set default internal resistor */
 
-	ret = power_supply_register(&pdev->dev, &info->battery, NULL);
-	if (ret)
-		return ret;
-	info->battery.dev->parent = &pdev->dev;
+	info->battery = power_supply_register(&pdev->dev, &pm860x_battery_desc,
+					      NULL);
+	if (IS_ERR(info->battery))
+		return PTR_ERR(info->battery);
+	info->battery->dev.parent = &pdev->dev;
 
 	ret = request_threaded_irq(info->irq_cc, NULL,
 				pm860x_coulomb_handler, IRQF_ONESHOT,
@@ -981,7 +983,7 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 out_coulomb:
 	free_irq(info->irq_cc, info);
 out_reg:
-	power_supply_unregister(&info->battery);
+	power_supply_unregister(info->battery);
 	return ret;
 }
 
@@ -991,7 +993,7 @@ static int pm860x_battery_remove(struct platform_device *pdev)
 
 	free_irq(info->irq_batt, info);
 	free_irq(info->irq_cc, info);
-	power_supply_unregister(&info->battery);
+	power_supply_unregister(info->battery);
 	return 0;
 }
 
diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 98e31419d9cf..a7f32a5b2299 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -102,7 +102,7 @@ struct pm860x_charger_info {
 	struct i2c_client *i2c_8606;
 	struct device *dev;
 
-	struct power_supply usb;
+	struct power_supply *usb;
 	struct mutex lock;
 	int irq_nums;
 	int irq[7];
@@ -415,7 +415,7 @@ static irqreturn_t pm860x_charger_handler(int irq, void *data)
 
 	set_charging_fsm(info);
 
-	power_supply_changed(&info->usb);
+	power_supply_changed(info->usb);
 out:
 	return IRQ_HANDLED;
 }
@@ -587,8 +587,7 @@ static int pm860x_usb_get_prop(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
 {
-	struct pm860x_charger_info *info =
-	    dev_get_drvdata(psy->dev->parent);
+	struct pm860x_charger_info *info = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -648,6 +647,14 @@ static struct pm860x_irq_desc {
 	{ "vchg", pm860x_vchg_handler },
 };
 
+static const struct power_supply_desc pm860x_charger_desc = {
+	.name		= "usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= pm860x_usb_props,
+	.num_properties	= ARRAY_SIZE(pm860x_usb_props),
+	.get_property	= pm860x_usb_get_prop,
+};
+
 static int pm860x_charger_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -689,16 +696,15 @@ static int pm860x_charger_probe(struct platform_device *pdev)
 	mutex_init(&info->lock);
 	platform_set_drvdata(pdev, info);
 
-	info->usb.name = "usb";
-	info->usb.type = POWER_SUPPLY_TYPE_USB;
-	info->usb.properties = pm860x_usb_props;
-	info->usb.num_properties = ARRAY_SIZE(pm860x_usb_props);
-	info->usb.get_property = pm860x_usb_get_prop;
+	psy_cfg.drv_data = info;
 	psy_cfg.supplied_to = pm860x_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(pm860x_supplied_to);
-	ret = power_supply_register(&pdev->dev, &info->usb, &psy_cfg);
-	if (ret)
+	info->usb = power_supply_register(&pdev->dev, &pm860x_charger_desc,
+					  &psy_cfg);
+	if (IS_ERR(info->usb)) {
+		ret = PTR_ERR(info->usb);
 		goto out;
+	}
 
 	pm860x_init_charger(info);
 
@@ -715,7 +721,7 @@ static int pm860x_charger_probe(struct platform_device *pdev)
 	return 0;
 
 out_irq:
-	power_supply_unregister(&info->usb);
+	power_supply_unregister(info->usb);
 	while (--i >= 0)
 		free_irq(info->irq[i], info);
 out:
@@ -727,7 +733,7 @@ static int pm860x_charger_remove(struct platform_device *pdev)
 	struct pm860x_charger_info *info = platform_get_drvdata(pdev);
 	int i;
 
-	power_supply_unregister(&info->usb);
+	power_supply_unregister(info->usb);
 	free_irq(info->irq[0], info);
 	for (i = 0; i < info->irq_nums; i++)
 		free_irq(info->irq[i], info);
diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 4d18464d6400..8f8044e1acf3 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -45,9 +45,6 @@
 #define BTEMP_BATCTRL_CURR_SRC_60UA	60
 #define BTEMP_BATCTRL_CURR_SRC_120UA	120
 
-#define to_ab8500_btemp_device_info(x) container_of((x), \
-	struct ab8500_btemp, btemp_psy);
-
 /**
  * struct ab8500_btemp_interrupts - ab8500 interrupts
  * @name:	name of the interrupt
@@ -102,7 +99,7 @@ struct ab8500_btemp {
 	struct ab8500_gpadc *gpadc;
 	struct ab8500_fg *fg;
 	struct abx500_bm_data *bm;
-	struct power_supply btemp_psy;
+	struct power_supply *btemp_psy;
 	struct ab8500_btemp_events events;
 	struct ab8500_btemp_ranges btemp_ranges;
 	struct workqueue_struct *btemp_wq;
@@ -654,14 +651,14 @@ static void ab8500_btemp_periodic_work(struct work_struct *work)
 		if ((di->bat_temp != di->prev_bat_temp) || !di->initialized) {
 			di->initialized = true;
 			di->bat_temp = bat_temp;
-			power_supply_changed(&di->btemp_psy);
+			power_supply_changed(di->btemp_psy);
 		}
 	} else if (bat_temp < di->prev_bat_temp) {
 		di->bat_temp--;
-		power_supply_changed(&di->btemp_psy);
+		power_supply_changed(di->btemp_psy);
 	} else if (bat_temp > di->prev_bat_temp) {
 		di->bat_temp++;
-		power_supply_changed(&di->btemp_psy);
+		power_supply_changed(di->btemp_psy);
 	}
 	di->prev_bat_temp = bat_temp;
 
@@ -689,7 +686,7 @@ static irqreturn_t ab8500_btemp_batctrlindb_handler(int irq, void *_di)
 	dev_err(di->dev, "Battery removal detected!\n");
 
 	di->events.batt_rem = true;
-	power_supply_changed(&di->btemp_psy);
+	power_supply_changed(di->btemp_psy);
 
 	return IRQ_HANDLED;
 }
@@ -715,7 +712,7 @@ static irqreturn_t ab8500_btemp_templow_handler(int irq, void *_di)
 		di->events.btemp_high = false;
 		di->events.btemp_medhigh = false;
 		di->events.btemp_lowmed = false;
-		power_supply_changed(&di->btemp_psy);
+		power_supply_changed(di->btemp_psy);
 	}
 
 	return IRQ_HANDLED;
@@ -738,7 +735,7 @@ static irqreturn_t ab8500_btemp_temphigh_handler(int irq, void *_di)
 	di->events.btemp_medhigh = false;
 	di->events.btemp_lowmed = false;
 	di->events.btemp_low = false;
-	power_supply_changed(&di->btemp_psy);
+	power_supply_changed(di->btemp_psy);
 
 	return IRQ_HANDLED;
 }
@@ -760,7 +757,7 @@ static irqreturn_t ab8500_btemp_lowmed_handler(int irq, void *_di)
 	di->events.btemp_medhigh = false;
 	di->events.btemp_high = false;
 	di->events.btemp_low = false;
-	power_supply_changed(&di->btemp_psy);
+	power_supply_changed(di->btemp_psy);
 
 	return IRQ_HANDLED;
 }
@@ -782,7 +779,7 @@ static irqreturn_t ab8500_btemp_medhigh_handler(int irq, void *_di)
 	di->events.btemp_lowmed = false;
 	di->events.btemp_high = false;
 	di->events.btemp_low = false;
-	power_supply_changed(&di->btemp_psy);
+	power_supply_changed(di->btemp_psy);
 
 	return IRQ_HANDLED;
 }
@@ -884,9 +881,7 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	union power_supply_propval *val)
 {
-	struct ab8500_btemp *di;
-
-	di = to_ab8500_btemp_device_info(psy);
+	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -919,14 +914,14 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
 
 	psy = (struct power_supply *)data;
 	ext = dev_get_drvdata(dev);
-	di = to_ab8500_btemp_device_info(psy);
+	di = power_supply_get_drvdata(psy);
 
 	/*
 	 * For all psy where the name of your driver
 	 * appears in any supplied_to
 	 */
 	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->name))
+		if (!strcmp(ext->supplied_to[i], psy->desc->name))
 			psy_found = true;
 	}
 
@@ -934,16 +929,16 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
 		return 0;
 
 	/* Go through all properties for the psy */
-	for (j = 0; j < ext->num_properties; j++) {
+	for (j = 0; j < ext->desc->num_properties; j++) {
 		enum power_supply_property prop;
-		prop = ext->properties[j];
+		prop = ext->desc->properties[j];
 
 		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 
 		switch (prop) {
 		case POWER_SUPPLY_PROP_PRESENT:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_MAINS:
 				/* AC disconnected */
 				if (!ret.intval && di->events.ac_conn) {
@@ -990,10 +985,10 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_btemp *di = to_ab8500_btemp_device_info(psy);
+	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
 
 	class_for_each_device(power_supply_class, NULL,
-		&di->btemp_psy, ab8500_btemp_get_ext_psy_data);
+		di->btemp_psy, ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
@@ -1044,7 +1039,7 @@ static int ab8500_btemp_remove(struct platform_device *pdev)
 	destroy_workqueue(di->btemp_wq);
 
 	flush_scheduled_work();
-	power_supply_unregister(&di->btemp_psy);
+	power_supply_unregister(di->btemp_psy);
 
 	return 0;
 }
@@ -1054,6 +1049,15 @@ static char *supply_interface[] = {
 	"ab8500_fg",
 };
 
+static const struct power_supply_desc ab8500_btemp_desc = {
+	.name			= "ab8500_btemp",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= ab8500_btemp_props,
+	.num_properties		= ARRAY_SIZE(ab8500_btemp_props),
+	.get_property		= ab8500_btemp_get_property,
+	.external_power_changed	= ab8500_btemp_external_power_changed,
+};
+
 static int ab8500_btemp_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1090,17 +1094,9 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 
 	di->initialized = false;
 
-	/* BTEMP supply */
-	di->btemp_psy.name = "ab8500_btemp";
-	di->btemp_psy.type = POWER_SUPPLY_TYPE_BATTERY;
-	di->btemp_psy.properties = ab8500_btemp_props;
-	di->btemp_psy.num_properties = ARRAY_SIZE(ab8500_btemp_props);
-	di->btemp_psy.get_property = ab8500_btemp_get_property;
-	di->btemp_psy.external_power_changed =
-		ab8500_btemp_external_power_changed;
-
 	psy_cfg.supplied_to = supply_interface;
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+	psy_cfg.drv_data = di;
 
 	/* Create a work queue for the btemp */
 	di->btemp_wq =
@@ -1141,9 +1137,11 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	}
 
 	/* Register BTEMP power supply class */
-	ret = power_supply_register(di->dev, &di->btemp_psy, &psy_cfg);
-	if (ret) {
+	di->btemp_psy = power_supply_register(di->dev, &ab8500_btemp_desc,
+					      &psy_cfg);
+	if (IS_ERR(di->btemp_psy)) {
 		dev_err(di->dev, "failed to register BTEMP psy\n");
+		ret = PTR_ERR(di->btemp_psy);
 		goto free_btemp_wq;
 	}
 
@@ -1172,7 +1170,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	return ret;
 
 free_irq:
-	power_supply_unregister(&di->btemp_psy);
+	power_supply_unregister(di->btemp_psy);
 
 	/* We also have to free all successfully registered irqs */
 	for (i = i - 1; i >= 0; i--) {
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index f9eb7fff1d65..e388171f4e58 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -435,7 +435,7 @@ static void ab8500_charger_set_usb_connected(struct ab8500_charger *di,
 		if (!connected)
 			di->flags.vbus_drop_end = false;
 
-		sysfs_notify(&di->usb_chg.psy.dev->kobj, NULL, "present");
+		sysfs_notify(&di->usb_chg.psy->dev.kobj, NULL, "present");
 
 		if (connected) {
 			mutex_lock(&di->charger_attached_mutex);
@@ -1516,7 +1516,7 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 
 		dev_dbg(di->dev, "%s Disabled AC charging\n", __func__);
 	}
-	ab8500_power_supply_changed(di, &di->ac_chg.psy);
+	ab8500_power_supply_changed(di, di->ac_chg.psy);
 
 	return ret;
 }
@@ -1672,7 +1672,7 @@ static int ab8500_charger_usb_en(struct ux500_charger *charger,
 		cancel_delayed_work(&di->check_vbat_work);
 
 	}
-	ab8500_power_supply_changed(di, &di->usb_chg.psy);
+	ab8500_power_supply_changed(di, di->usb_chg.psy);
 
 	return ret;
 }
@@ -1811,9 +1811,9 @@ static int ab8500_charger_watchdog_kick(struct ux500_charger *charger)
 	int ret;
 	struct ab8500_charger *di;
 
-	if (charger->psy.type == POWER_SUPPLY_TYPE_MAINS)
+	if (charger->psy->desc->type == POWER_SUPPLY_TYPE_MAINS)
 		di = to_ab8500_charger_ac_device_info(charger);
-	else if (charger->psy.type == POWER_SUPPLY_TYPE_USB)
+	else if (charger->psy->desc->type == POWER_SUPPLY_TYPE_USB)
 		di = to_ab8500_charger_usb_device_info(charger);
 	else
 		return -ENXIO;
@@ -1839,9 +1839,9 @@ static int ab8500_charger_update_charger_current(struct ux500_charger *charger,
 	int ret;
 	struct ab8500_charger *di;
 
-	if (charger->psy.type == POWER_SUPPLY_TYPE_MAINS)
+	if (charger->psy->desc->type == POWER_SUPPLY_TYPE_MAINS)
 		di = to_ab8500_charger_ac_device_info(charger);
-	else if (charger->psy.type == POWER_SUPPLY_TYPE_USB)
+	else if (charger->psy->desc->type == POWER_SUPPLY_TYPE_USB)
 		di = to_ab8500_charger_usb_device_info(charger);
 	else
 		return -ENXIO;
@@ -1879,7 +1879,7 @@ static int ab8540_charger_power_path_enable(struct ux500_charger *charger,
 	int ret;
 	struct ab8500_charger *di;
 
-	if (charger->psy.type == POWER_SUPPLY_TYPE_USB)
+	if (charger->psy->desc->type == POWER_SUPPLY_TYPE_USB)
 		di = to_ab8500_charger_usb_device_info(charger);
 	else
 		return -ENXIO;
@@ -1910,7 +1910,7 @@ static int ab8540_charger_usb_pre_chg_enable(struct ux500_charger *charger,
 	int ret;
 	struct ab8500_charger *di;
 
-	if (charger->psy.type == POWER_SUPPLY_TYPE_USB)
+	if (charger->psy->desc->type == POWER_SUPPLY_TYPE_USB)
 		di = to_ab8500_charger_usb_device_info(charger);
 	else
 		return -ENXIO;
@@ -1937,7 +1937,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 	struct ux500_charger *usb_chg;
 
 	usb_chg = (struct ux500_charger *)data;
-	psy = &usb_chg->psy;
+	psy = usb_chg->psy;
 
 	di = to_ab8500_charger_usb_device_info(usb_chg);
 
@@ -1945,7 +1945,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 
 	/* For all psy where the driver name appears in any supplied_to */
 	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->name))
+		if (!strcmp(ext->supplied_to[i], psy->desc->name))
 			psy_found = true;
 	}
 
@@ -1953,16 +1953,16 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 		return 0;
 
 	/* Go through all properties for the psy */
-	for (j = 0; j < ext->num_properties; j++) {
+	for (j = 0; j < ext->desc->num_properties; j++) {
 		enum power_supply_property prop;
-		prop = ext->properties[j];
+		prop = ext->desc->properties[j];
 
 		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 
 		switch (prop) {
 		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				di->vbat = ret.intval / 1000;
 				break;
@@ -1993,7 +1993,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 		struct ab8500_charger, check_vbat_work.work);
 
 	class_for_each_device(power_supply_class, NULL,
-		&di->usb_chg.psy, ab8500_charger_get_ext_psy_data);
+		di->usb_chg.psy, ab8500_charger_get_ext_psy_data);
 
 	/* First run old_vbat is 0. */
 	if (di->old_vbat == 0)
@@ -2009,7 +2009,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 			di->vbat, di->old_vbat);
 		ab8500_charger_set_vbus_in_curr(di,
 					di->max_usb_in_curr.usb_type_max);
-		power_supply_changed(&di->usb_chg.psy);
+		power_supply_changed(di->usb_chg.psy);
 	}
 
 	di->old_vbat = di->vbat;
@@ -2049,7 +2049,7 @@ static void ab8500_charger_check_hw_failure_work(struct work_struct *work)
 		}
 		if (!(reg_value & MAIN_CH_NOK)) {
 			di->flags.mainextchnotok = false;
-			ab8500_power_supply_changed(di, &di->ac_chg.psy);
+			ab8500_power_supply_changed(di, di->ac_chg.psy);
 		}
 	}
 	if (di->flags.vbus_ovv) {
@@ -2062,7 +2062,7 @@ static void ab8500_charger_check_hw_failure_work(struct work_struct *work)
 		}
 		if (!(reg_value & VBUS_OVV_TH)) {
 			di->flags.vbus_ovv = false;
-			ab8500_power_supply_changed(di, &di->usb_chg.psy);
+			ab8500_power_supply_changed(di, di->usb_chg.psy);
 		}
 	}
 	/* If we still have a failure, schedule a new check */
@@ -2132,8 +2132,8 @@ static void ab8500_charger_ac_work(struct work_struct *work)
 		di->ac.charger_connected = 0;
 	}
 
-	ab8500_power_supply_changed(di, &di->ac_chg.psy);
-	sysfs_notify(&di->ac_chg.psy.dev->kobj, NULL, "present");
+	ab8500_power_supply_changed(di, di->ac_chg.psy);
+	sysfs_notify(&di->ac_chg.psy->dev.kobj, NULL, "present");
 }
 
 static void ab8500_charger_usb_attached_work(struct work_struct *work)
@@ -2240,7 +2240,7 @@ static void ab8500_charger_detect_usb_type_work(struct work_struct *work)
 		dev_dbg(di->dev, "%s di->vbus_detected = false\n", __func__);
 		di->vbus_detected = false;
 		ab8500_charger_set_usb_connected(di, false);
-		ab8500_power_supply_changed(di, &di->usb_chg.psy);
+		ab8500_power_supply_changed(di, di->usb_chg.psy);
 	} else {
 		dev_dbg(di->dev, "%s di->vbus_detected = true\n", __func__);
 		di->vbus_detected = true;
@@ -2250,7 +2250,7 @@ static void ab8500_charger_detect_usb_type_work(struct work_struct *work)
 			if (!ret) {
 				ab8500_charger_set_usb_connected(di, true);
 				ab8500_power_supply_changed(di,
-							    &di->usb_chg.psy);
+							    di->usb_chg.psy);
 			}
 		} else {
 			/*
@@ -2267,7 +2267,7 @@ static void ab8500_charger_detect_usb_type_work(struct work_struct *work)
 					ab8500_charger_set_usb_connected(di,
 						true);
 					ab8500_power_supply_changed(di,
-						&di->usb_chg.psy);
+						di->usb_chg.psy);
 				}
 			}
 		}
@@ -2295,7 +2295,7 @@ static void ab8500_charger_usb_link_attach_work(struct work_struct *work)
 	}
 
 	ab8500_charger_set_usb_connected(di, true);
-	ab8500_power_supply_changed(di, &di->usb_chg.psy);
+	ab8500_power_supply_changed(di, di->usb_chg.psy);
 }
 
 /**
@@ -2393,7 +2393,7 @@ static void ab8500_charger_usb_link_status_work(struct work_struct *work)
 	if (!(detected_chargers & USB_PW_CONN)) {
 		di->vbus_detected = false;
 		ab8500_charger_set_usb_connected(di, false);
-		ab8500_power_supply_changed(di, &di->usb_chg.psy);
+		ab8500_power_supply_changed(di, di->usb_chg.psy);
 		return;
 	}
 
@@ -2404,7 +2404,7 @@ static void ab8500_charger_usb_link_status_work(struct work_struct *work)
 		if (ret == -ENXIO) {
 			/* No valid charger type detected */
 			ab8500_charger_set_usb_connected(di, false);
-			ab8500_power_supply_changed(di, &di->usb_chg.psy);
+			ab8500_power_supply_changed(di, di->usb_chg.psy);
 		}
 		return;
 	}
@@ -2463,7 +2463,7 @@ static void ab8500_charger_usb_state_changed_work(struct work_struct *work)
 	case AB8500_BM_USB_STATE_SUSPEND:
 	case AB8500_BM_USB_STATE_MAX:
 		ab8500_charger_set_usb_connected(di, false);
-		ab8500_power_supply_changed(di, &di->usb_chg.psy);
+		ab8500_power_supply_changed(di, di->usb_chg.psy);
 		break;
 
 	case AB8500_BM_USB_STATE_RESUME:
@@ -2486,7 +2486,7 @@ static void ab8500_charger_usb_state_changed_work(struct work_struct *work)
 				return;
 
 			ab8500_charger_set_usb_connected(di, true);
-			ab8500_power_supply_changed(di, &di->usb_chg.psy);
+			ab8500_power_supply_changed(di, di->usb_chg.psy);
 		}
 		break;
 
@@ -2530,7 +2530,7 @@ static void ab8500_charger_check_usbchargernotok_work(struct work_struct *work)
 	}
 
 	if (prev_status != di->flags.usbchargernotok)
-		ab8500_power_supply_changed(di, &di->usb_chg.psy);
+		ab8500_power_supply_changed(di, di->usb_chg.psy);
 }
 
 /**
@@ -2560,7 +2560,7 @@ static void ab8500_charger_check_main_thermal_prot_work(
 	else
 		di->flags.main_thermal_prot = false;
 
-	ab8500_power_supply_changed(di, &di->ac_chg.psy);
+	ab8500_power_supply_changed(di, di->ac_chg.psy);
 }
 
 /**
@@ -2590,7 +2590,7 @@ static void ab8500_charger_check_usb_thermal_prot_work(
 	else
 		di->flags.usb_thermal_prot = false;
 
-	ab8500_power_supply_changed(di, &di->usb_chg.psy);
+	ab8500_power_supply_changed(di, di->usb_chg.psy);
 }
 
 /**
@@ -2651,7 +2651,7 @@ static irqreturn_t ab8500_charger_mainextchnotok_handler(int irq, void *_di)
 
 	dev_dbg(di->dev, "Main charger not ok\n");
 	di->flags.mainextchnotok = true;
-	ab8500_power_supply_changed(di, &di->ac_chg.psy);
+	ab8500_power_supply_changed(di, di->ac_chg.psy);
 
 	/* Schedule a new HW failure check */
 	queue_delayed_work(di->charger_wq, &di->check_hw_failure_work, 0);
@@ -2880,11 +2880,11 @@ static irqreturn_t ab8500_charger_chwdexp_handler(int irq, void *_di)
 	 */
 	if (di->ac.charger_online) {
 		di->ac.wd_expired = true;
-		ab8500_power_supply_changed(di, &di->ac_chg.psy);
+		ab8500_power_supply_changed(di, di->ac_chg.psy);
 	}
 	if (di->usb.charger_online) {
 		di->usb.wd_expired = true;
-		ab8500_power_supply_changed(di, &di->usb_chg.psy);
+		ab8500_power_supply_changed(di, di->usb_chg.psy);
 	}
 
 	return IRQ_HANDLED;
@@ -2927,7 +2927,7 @@ static irqreturn_t ab8500_charger_vbusovv_handler(int irq, void *_di)
 
 	dev_dbg(di->dev, "VBUS overvoltage detected\n");
 	di->flags.vbus_ovv = true;
-	ab8500_power_supply_changed(di, &di->usb_chg.psy);
+	ab8500_power_supply_changed(di, di->usb_chg.psy);
 
 	/* Schedule a new HW failure check */
 	queue_delayed_work(di->charger_wq, &di->check_hw_failure_work, 0);
@@ -3428,10 +3428,10 @@ static int ab8500_charger_remove(struct platform_device *pdev)
 
 	flush_scheduled_work();
 	if (di->usb_chg.enabled)
-		power_supply_unregister(&di->usb_chg.psy);
+		power_supply_unregister(di->usb_chg.psy);
 
 	if (di->ac_chg.enabled && !di->ac_chg.external)
-		power_supply_unregister(&di->ac_chg.psy);
+		power_supply_unregister(di->ac_chg.psy);
 
 	return 0;
 }
@@ -3442,11 +3442,27 @@ static char *supply_interface[] = {
 	"ab8500_btemp",
 };
 
+static const struct power_supply_desc ab8500_ac_chg_desc = {
+	.name		= "ab8500_ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= ab8500_charger_ac_props,
+	.num_properties	= ARRAY_SIZE(ab8500_charger_ac_props),
+	.get_property	= ab8500_charger_ac_get_property,
+};
+
+static const struct power_supply_desc ab8500_usb_chg_desc = {
+	.name		= "ab8500_usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= ab8500_charger_usb_props,
+	.num_properties	= ARRAY_SIZE(ab8500_charger_usb_props),
+	.get_property	= ab8500_charger_usb_get_property,
+};
+
 static int ab8500_charger_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct abx500_bm_data *plat = pdev->dev.platform_data;
-	struct power_supply_config psy_cfg = {};
+	struct power_supply_config ac_psy_cfg = {}, usb_psy_cfg = {};
 	struct ab8500_charger *di;
 	int irq, i, charger_status, ret = 0, ch_stat;
 
@@ -3485,16 +3501,14 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->invalid_charger_detect_state = 0;
 
 	/* AC and USB supply config */
-	psy_cfg.supplied_to = supply_interface;
-	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+	ac_psy_cfg.supplied_to = supply_interface;
+	ac_psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+	ac_psy_cfg.drv_data = &di->ac_chg;
+	usb_psy_cfg.supplied_to = supply_interface;
+	usb_psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+	usb_psy_cfg.drv_data = &di->usb_chg;
 
 	/* AC supply */
-	/* power_supply base class */
-	di->ac_chg.psy.name = "ab8500_ac";
-	di->ac_chg.psy.type = POWER_SUPPLY_TYPE_MAINS;
-	di->ac_chg.psy.properties = ab8500_charger_ac_props;
-	di->ac_chg.psy.num_properties = ARRAY_SIZE(ab8500_charger_ac_props);
-	di->ac_chg.psy.get_property = ab8500_charger_ac_get_property;
 	/* ux500_charger sub-class */
 	di->ac_chg.ops.enable = &ab8500_charger_ac_en;
 	di->ac_chg.ops.check_enable = &ab8500_charger_ac_check_enable;
@@ -3514,12 +3528,6 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 			&charger_notifier_list, &charger_nb);
 
 	/* USB supply */
-	/* power_supply base class */
-	di->usb_chg.psy.name = "ab8500_usb";
-	di->usb_chg.psy.type = POWER_SUPPLY_TYPE_USB;
-	di->usb_chg.psy.properties = ab8500_charger_usb_props;
-	di->usb_chg.psy.num_properties = ARRAY_SIZE(ab8500_charger_usb_props);
-	di->usb_chg.psy.get_property = ab8500_charger_usb_get_property;
 	/* ux500_charger sub-class */
 	di->usb_chg.ops.enable = &ab8500_charger_usb_en;
 	di->usb_chg.ops.check_enable = &ab8500_charger_usb_check_enable;
@@ -3617,20 +3625,24 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	/* Register AC charger class */
 	if (di->ac_chg.enabled) {
-		ret = power_supply_register(di->dev, &di->ac_chg.psy,
-						&psy_cfg);
-		if (ret) {
+		di->ac_chg.psy = power_supply_register(di->dev,
+						       &ab8500_ac_chg_desc,
+						       &ac_psy_cfg);
+		if (IS_ERR(di->ac_chg.psy)) {
 			dev_err(di->dev, "failed to register AC charger\n");
+			ret = PTR_ERR(di->ac_chg.psy);
 			goto free_charger_wq;
 		}
 	}
 
 	/* Register USB charger class */
 	if (di->usb_chg.enabled) {
-		ret = power_supply_register(di->dev, &di->usb_chg.psy,
-						&psy_cfg);
-		if (ret) {
+		di->usb_chg.psy = power_supply_register(di->dev,
+							&ab8500_usb_chg_desc,
+							&usb_psy_cfg);
+		if (IS_ERR(di->usb_chg.psy)) {
 			dev_err(di->dev, "failed to register USB charger\n");
+			ret = PTR_ERR(di->usb_chg.psy);
 			goto free_ac;
 		}
 	}
@@ -3653,8 +3665,8 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	if (charger_status & AC_PW_CONN) {
 		di->ac.charger_connected = 1;
 		di->ac_conn = true;
-		ab8500_power_supply_changed(di, &di->ac_chg.psy);
-		sysfs_notify(&di->ac_chg.psy.dev->kobj, NULL, "present");
+		ab8500_power_supply_changed(di, di->ac_chg.psy);
+		sysfs_notify(&di->ac_chg.psy->dev.kobj, NULL, "present");
 	}
 
 	if (charger_status & USB_PW_CONN) {
@@ -3715,10 +3727,10 @@ put_usb_phy:
 	usb_put_phy(di->usb_phy);
 free_usb:
 	if (di->usb_chg.enabled)
-		power_supply_unregister(&di->usb_chg.psy);
+		power_supply_unregister(di->usb_chg.psy);
 free_ac:
 	if (di->ac_chg.enabled)
-		power_supply_unregister(&di->ac_chg.psy);
+		power_supply_unregister(di->ac_chg.psy);
 free_charger_wq:
 	destroy_workqueue(di->charger_wq);
 	return ret;
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index c957e8a41847..09ffae6e5db1 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -57,9 +57,6 @@
 #define interpolate(x, x1, y1, x2, y2) \
 	((y1) + ((((y2) - (y1)) * ((x) - (x1))) / ((x2) - (x1))));
 
-#define to_ab8500_fg_device_info(x) container_of((x), \
-	struct ab8500_fg, fg_psy);
-
 /**
  * struct ab8500_fg_interrupts - ab8500 fg interupts
  * @name:	name of the interrupt
@@ -229,7 +226,7 @@ struct ab8500_fg {
 	struct ab8500 *parent;
 	struct ab8500_gpadc *gpadc;
 	struct abx500_bm_data *bm;
-	struct power_supply fg_psy;
+	struct power_supply *fg_psy;
 	struct workqueue_struct *fg_wq;
 	struct delayed_work fg_periodic_work;
 	struct delayed_work fg_low_bat_work;
@@ -1391,7 +1388,7 @@ static void ab8500_fg_check_capacity_limits(struct ab8500_fg *di, bool init)
 				di->bat_cap.prev_percent,
 				di->bat_cap.cap_scale.scaled_cap);
 		}
-		power_supply_changed(&di->fg_psy);
+		power_supply_changed(di->fg_psy);
 		if (di->flags.fully_charged && di->flags.force_full) {
 			dev_dbg(di->dev, "Battery full, notifying.\n");
 			di->flags.force_full = false;
@@ -1850,7 +1847,7 @@ static void ab8500_fg_check_hw_failure_work(struct work_struct *work)
 		if (!di->flags.bat_ovv) {
 			dev_dbg(di->dev, "Battery OVV\n");
 			di->flags.bat_ovv = true;
-			power_supply_changed(&di->fg_psy);
+			power_supply_changed(di->fg_psy);
 		}
 		/* Not yet recovered from ovv, reschedule this test */
 		queue_delayed_work(di->fg_wq, &di->fg_check_hw_failure_work,
@@ -1858,7 +1855,7 @@ static void ab8500_fg_check_hw_failure_work(struct work_struct *work)
 		} else {
 			dev_dbg(di->dev, "Battery recovered from OVV\n");
 			di->flags.bat_ovv = false;
-			power_supply_changed(&di->fg_psy);
+			power_supply_changed(di->fg_psy);
 	}
 }
 
@@ -2096,9 +2093,7 @@ static int ab8500_fg_get_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	union power_supply_propval *val)
 {
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	/*
 	 * If battery is identified as unknown and charging of unknown
@@ -2181,14 +2176,14 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 
 	psy = (struct power_supply *)data;
 	ext = dev_get_drvdata(dev);
-	di = to_ab8500_fg_device_info(psy);
+	di = power_supply_get_drvdata(psy);
 
 	/*
 	 * For all psy where the name of your driver
 	 * appears in any supplied_to
 	 */
 	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->name))
+		if (!strcmp(ext->supplied_to[i], psy->desc->name))
 			psy_found = true;
 	}
 
@@ -2196,16 +2191,16 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 		return 0;
 
 	/* Go through all properties for the psy */
-	for (j = 0; j < ext->num_properties; j++) {
+	for (j = 0; j < ext->desc->num_properties; j++) {
 		enum power_supply_property prop;
-		prop = ext->properties[j];
+		prop = ext->desc->properties[j];
 
 		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 
 		switch (prop) {
 		case POWER_SUPPLY_PROP_STATUS:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				switch (ret.intval) {
 				case POWER_SUPPLY_STATUS_UNKNOWN:
@@ -2244,7 +2239,7 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 			};
 			break;
 		case POWER_SUPPLY_PROP_TECHNOLOGY:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				if (!di->flags.batt_id_received &&
 				    di->bm->batt_id != BATTERY_UNKNOWN) {
@@ -2274,7 +2269,7 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 			}
 			break;
 		case POWER_SUPPLY_PROP_TEMP:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				if (di->flags.batt_id_received)
 					di->bat_temp = ret.intval;
@@ -2399,10 +2394,10 @@ out:
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_fg *di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	class_for_each_device(power_supply_class, NULL,
-		&di->fg_psy, ab8500_fg_get_ext_psy_data);
+		di->fg_psy, ab8500_fg_get_ext_psy_data);
 }
 
 /**
@@ -2580,9 +2575,7 @@ static ssize_t ab8505_powercut_flagtime_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 		AB8505_RTC_PCUT_FLAG_TIME_REG, &reg_value);
@@ -2605,9 +2598,7 @@ static ssize_t ab8505_powercut_flagtime_write(struct device *dev,
 	int ret;
 	long unsigned reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	reg_value = simple_strtoul(buf, NULL, 10);
 
@@ -2633,9 +2624,7 @@ static ssize_t ab8505_powercut_maxtime_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 		AB8505_RTC_PCUT_MAX_TIME_REG, &reg_value);
@@ -2659,9 +2648,7 @@ static ssize_t ab8505_powercut_maxtime_write(struct device *dev,
 	int ret;
 	int reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	reg_value = simple_strtoul(buf, NULL, 10);
 	if (reg_value > 0x7F) {
@@ -2686,9 +2673,7 @@ static ssize_t ab8505_powercut_restart_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 		AB8505_RTC_PCUT_RESTART_REG, &reg_value);
@@ -2711,9 +2696,7 @@ static ssize_t ab8505_powercut_restart_write(struct device *dev,
 	int ret;
 	int reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	reg_value = simple_strtoul(buf, NULL, 10);
 	if (reg_value > 0xF) {
@@ -2739,9 +2722,7 @@ static ssize_t ab8505_powercut_timer_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 						AB8505_RTC_PCUT_TIME_REG, &reg_value);
@@ -2764,9 +2745,7 @@ static ssize_t ab8505_powercut_restart_counter_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 						AB8505_RTC_PCUT_RESTART_REG, &reg_value);
@@ -2789,9 +2768,7 @@ static ssize_t ab8505_powercut_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 						AB8505_RTC_PCUT_CTL_STATUS_REG, &reg_value);
@@ -2812,9 +2789,7 @@ static ssize_t ab8505_powercut_write(struct device *dev,
 	int ret;
 	int reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	reg_value = simple_strtoul(buf, NULL, 10);
 	if (reg_value > 0x1) {
@@ -2840,9 +2815,7 @@ static ssize_t ab8505_powercut_flag_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 						AB8505_RTC_PCUT_CTL_STATUS_REG,  &reg_value);
@@ -2865,9 +2838,7 @@ static ssize_t ab8505_powercut_debounce_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 						AB8505_RTC_PCUT_DEBOUNCE_REG,  &reg_value);
@@ -2890,9 +2861,7 @@ static ssize_t ab8505_powercut_debounce_write(struct device *dev,
 	int ret;
 	int reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	reg_value = simple_strtoul(buf, NULL, 10);
 	if (reg_value > 0x7) {
@@ -2917,9 +2886,7 @@ static ssize_t ab8505_powercut_enable_status_read(struct device *dev,
 	int ret;
 	u8 reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct ab8500_fg *di;
-
-	di = to_ab8500_fg_device_info(psy);
+	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
 						AB8505_RTC_PCUT_CTL_STATUS_REG, &reg_value);
@@ -2962,15 +2929,16 @@ static int ab8500_fg_sysfs_psy_create_attrs(struct ab8500_fg *di)
 	     abx500_get_chip_id(di->dev) >= AB8500_CUT2P0)
 	    || is_ab8540(di->parent)) {
 		for (i = 0; i < ARRAY_SIZE(ab8505_fg_sysfs_psy_attrs); i++)
-			if (device_create_file(di->fg_psy.dev,
+			if (device_create_file(&di->fg_psy->dev,
 					       &ab8505_fg_sysfs_psy_attrs[i]))
 				goto sysfs_psy_create_attrs_failed_ab8505;
 	}
 	return 0;
 sysfs_psy_create_attrs_failed_ab8505:
-	dev_err(di->fg_psy.dev, "Failed creating sysfs psy attrs for ab8505.\n");
+	dev_err(&di->fg_psy->dev, "Failed creating sysfs psy attrs for ab8505.\n");
 	while (i--)
-		device_remove_file(di->fg_psy.dev, &ab8505_fg_sysfs_psy_attrs[i]);
+		device_remove_file(&di->fg_psy->dev,
+				   &ab8505_fg_sysfs_psy_attrs[i]);
 
 	return -EIO;
 }
@@ -2983,7 +2951,7 @@ static void ab8500_fg_sysfs_psy_remove_attrs(struct ab8500_fg *di)
 	     abx500_get_chip_id(di->dev) >= AB8500_CUT2P0)
 	    || is_ab8540(di->parent)) {
 		for (i = 0; i < ARRAY_SIZE(ab8505_fg_sysfs_psy_attrs); i++)
-			(void)device_remove_file(di->fg_psy.dev,
+			(void)device_remove_file(&di->fg_psy->dev,
 						 &ab8505_fg_sysfs_psy_attrs[i]);
 	}
 }
@@ -3050,7 +3018,7 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 
 	flush_scheduled_work();
 	ab8500_fg_sysfs_psy_remove_attrs(di);
-	power_supply_unregister(&di->fg_psy);
+	power_supply_unregister(di->fg_psy);
 	return ret;
 }
 
@@ -3068,6 +3036,15 @@ static char *supply_interface[] = {
 	"ab8500_usb",
 };
 
+static const struct power_supply_desc ab8500_fg_desc = {
+	.name			= "ab8500_fg",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= ab8500_fg_props,
+	.num_properties		= ARRAY_SIZE(ab8500_fg_props),
+	.get_property		= ab8500_fg_get_property,
+	.external_power_changed	= ab8500_fg_external_power_changed,
+};
+
 static int ab8500_fg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -3104,15 +3081,9 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
 
-	di->fg_psy.name = "ab8500_fg";
-	di->fg_psy.type = POWER_SUPPLY_TYPE_BATTERY;
-	di->fg_psy.properties = ab8500_fg_props;
-	di->fg_psy.num_properties = ARRAY_SIZE(ab8500_fg_props);
-	di->fg_psy.get_property = ab8500_fg_get_property;
-	di->fg_psy.external_power_changed = ab8500_fg_external_power_changed;
-
 	psy_cfg.supplied_to = supply_interface;
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+	psy_cfg.drv_data = di;
 
 	di->bat_cap.max_mah_design = MILLI_TO_MICRO *
 		di->bm->bat_type[di->bm->batt_id].charge_full_design;
@@ -3173,9 +3144,10 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	di->flags.batt_id_received = false;
 
 	/* Register FG power supply class */
-	ret = power_supply_register(di->dev, &di->fg_psy, &psy_cfg);
-	if (ret) {
+	di->fg_psy = power_supply_register(di->dev, &ab8500_fg_desc, &psy_cfg);
+	if (IS_ERR(di->fg_psy)) {
 		dev_err(di->dev, "failed to register FG psy\n");
+		ret = PTR_ERR(di->fg_psy);
 		goto free_inst_curr_wq;
 	}
 
@@ -3238,7 +3210,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	return ret;
 
 free_irq:
-	power_supply_unregister(&di->fg_psy);
+	power_supply_unregister(di->fg_psy);
 
 	/* We also have to free all successfully registered irqs */
 	for (i = i - 1; i >= 0; i--) {
diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index ac6f4a22f846..541f702e0451 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -50,9 +50,6 @@
 #define CHARGALG_CURR_STEP_LOW		0
 #define CHARGALG_CURR_STEP_HIGH	100
 
-#define to_abx500_chargalg_device_info(x) container_of((x), \
-	struct abx500_chargalg, chargalg_psy);
-
 enum abx500_chargers {
 	NO_CHG,
 	AC_CHG,
@@ -256,7 +253,7 @@ struct abx500_chargalg {
 	struct ab8500 *parent;
 	struct abx500_chargalg_current_step_status curr_status;
 	struct abx500_bm_data *bm;
-	struct power_supply chargalg_psy;
+	struct power_supply *chargalg_psy;
 	struct ux500_charger *ac_chg;
 	struct ux500_charger *usb_chg;
 	struct abx500_chargalg_events events;
@@ -695,7 +692,7 @@ static void abx500_chargalg_stop_charging(struct abx500_chargalg *di)
 	di->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 	di->maintenance_chg = false;
 	cancel_delayed_work(&di->chargalg_wd_work);
-	power_supply_changed(&di->chargalg_psy);
+	power_supply_changed(di->chargalg_psy);
 }
 
 /**
@@ -715,7 +712,7 @@ static void abx500_chargalg_hold_charging(struct abx500_chargalg *di)
 	di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 	di->maintenance_chg = false;
 	cancel_delayed_work(&di->chargalg_wd_work);
-	power_supply_changed(&di->chargalg_psy);
+	power_supply_changed(di->chargalg_psy);
 }
 
 /**
@@ -842,7 +839,7 @@ static void abx500_chargalg_end_of_charge(struct abx500_chargalg *di)
 			di->charge_status = POWER_SUPPLY_STATUS_FULL;
 			di->maintenance_chg = true;
 			dev_dbg(di->dev, "EOC reached!\n");
-			power_supply_changed(&di->chargalg_psy);
+			power_supply_changed(di->chargalg_psy);
 		} else {
 			dev_dbg(di->dev,
 				" EOC limit reached for the %d"
@@ -987,10 +984,10 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 
 	psy = (struct power_supply *)data;
 	ext = dev_get_drvdata(dev);
-	di = to_abx500_chargalg_device_info(psy);
+	di = power_supply_get_drvdata(psy);
 	/* For all psy where the driver name appears in any supplied_to */
 	for (i = 0; i < ext->num_supplicants; i++) {
-		if (!strcmp(ext->supplied_to[i], psy->name))
+		if (!strcmp(ext->supplied_to[i], psy->desc->name))
 			psy_found = true;
 	}
 	if (!psy_found)
@@ -1007,23 +1004,25 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 	}
 
 	/* Go through all properties for the psy */
-	for (j = 0; j < ext->num_properties; j++) {
+	for (j = 0; j < ext->desc->num_properties; j++) {
 		enum power_supply_property prop;
-		prop = ext->properties[j];
+		prop = ext->desc->properties[j];
 
-		/* Initialize chargers if not already done */
+		/*
+		 * Initialize chargers if not already done.
+		 * The ab8500_charger*/
 		if (!di->ac_chg &&
-			ext->type == POWER_SUPPLY_TYPE_MAINS)
+			ext->desc->type == POWER_SUPPLY_TYPE_MAINS)
 			di->ac_chg = psy_to_ux500_charger(ext);
 		else if (!di->usb_chg &&
-			ext->type == POWER_SUPPLY_TYPE_USB)
+			ext->desc->type == POWER_SUPPLY_TYPE_USB)
 			di->usb_chg = psy_to_ux500_charger(ext);
 
 		if (power_supply_get_property(ext, prop, &ret))
 			continue;
 		switch (prop) {
 		case POWER_SUPPLY_PROP_PRESENT:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				/* Battery present */
 				if (ret.intval)
@@ -1070,7 +1069,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			break;
 
 		case POWER_SUPPLY_PROP_ONLINE:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				break;
 			case POWER_SUPPLY_TYPE_MAINS:
@@ -1115,7 +1114,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			break;
 
 		case POWER_SUPPLY_PROP_HEALTH:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				break;
 			case POWER_SUPPLY_TYPE_MAINS:
@@ -1198,7 +1197,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			break;
 
 		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				di->batt_data.volt = ret.intval / 1000;
 				break;
@@ -1214,7 +1213,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			break;
 
 		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_MAINS:
 				/* AVG is used to indicate when we are
 				 * in CV mode */
@@ -1239,7 +1238,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			break;
 
 		case POWER_SUPPLY_PROP_TECHNOLOGY:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				if (ret.intval)
 					di->events.batt_unknown = false;
@@ -1257,7 +1256,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			break;
 
 		case POWER_SUPPLY_PROP_CURRENT_NOW:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_MAINS:
 					di->chg_info.ac_curr =
 						ret.intval / 1000;
@@ -1275,7 +1274,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			break;
 
 		case POWER_SUPPLY_PROP_CURRENT_AVG:
-			switch (ext->type) {
+			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				di->batt_data.avg_curr = ret.intval / 1000;
 				break;
@@ -1311,7 +1310,7 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
  */
 static void abx500_chargalg_external_power_changed(struct power_supply *psy)
 {
-	struct abx500_chargalg *di = to_abx500_chargalg_device_info(psy);
+	struct abx500_chargalg *di = power_supply_get_drvdata(psy);
 
 	/*
 	 * Trigger execution of the algorithm instantly and read
@@ -1336,7 +1335,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 
 	/* Collect data from all power_supply class devices */
 	class_for_each_device(power_supply_class, NULL,
-		&di->chargalg_psy, abx500_chargalg_get_ext_psy_data);
+		di->chargalg_psy, abx500_chargalg_get_ext_psy_data);
 
 	abx500_chargalg_end_of_charge(di);
 	abx500_chargalg_check_temp(di);
@@ -1478,7 +1477,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 		di->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		di->maintenance_chg = false;
 		abx500_chargalg_state_to(di, STATE_SUSPENDED);
-		power_supply_changed(&di->chargalg_psy);
+		power_supply_changed(di->chargalg_psy);
 		/* Intentional fallthrough */
 
 	case STATE_SUSPENDED:
@@ -1576,7 +1575,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 		di->eoc_cnt = 0;
 		di->maintenance_chg = false;
-		power_supply_changed(&di->chargalg_psy);
+		power_supply_changed(di->chargalg_psy);
 
 		break;
 
@@ -1624,7 +1623,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 			di->bm->bat_type[
 				di->bm->batt_id].maint_a_cur_lvl);
 		abx500_chargalg_state_to(di, STATE_MAINTENANCE_A);
-		power_supply_changed(&di->chargalg_psy);
+		power_supply_changed(di->chargalg_psy);
 		/* Intentional fallthrough*/
 
 	case STATE_MAINTENANCE_A:
@@ -1644,7 +1643,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 			di->bm->bat_type[
 				di->bm->batt_id].maint_b_cur_lvl);
 		abx500_chargalg_state_to(di, STATE_MAINTENANCE_B);
-		power_supply_changed(&di->chargalg_psy);
+		power_supply_changed(di->chargalg_psy);
 		/* Intentional fallthrough*/
 
 	case STATE_MAINTENANCE_B:
@@ -1663,7 +1662,7 @@ static void abx500_chargalg_algorithm(struct abx500_chargalg *di)
 		abx500_chargalg_stop_maintenance_timer(di);
 		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 		abx500_chargalg_state_to(di, STATE_TEMP_LOWHIGH);
-		power_supply_changed(&di->chargalg_psy);
+		power_supply_changed(di->chargalg_psy);
 		/* Intentional fallthrough */
 
 	case STATE_TEMP_LOWHIGH:
@@ -1779,9 +1778,7 @@ static int abx500_chargalg_get_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	union power_supply_propval *val)
 {
-	struct abx500_chargalg *di;
-
-	di = to_abx500_chargalg_device_info(psy);
+	struct abx500_chargalg *di = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -2034,7 +2031,7 @@ static int abx500_chargalg_remove(struct platform_device *pdev)
 	/* Delete the work queue */
 	destroy_workqueue(di->chargalg_wq);
 
-	power_supply_unregister(&di->chargalg_psy);
+	power_supply_unregister(di->chargalg_psy);
 
 	return 0;
 }
@@ -2043,6 +2040,15 @@ static char *supply_interface[] = {
 	"ab8500_fg",
 };
 
+static const struct power_supply_desc abx500_chargalg_desc = {
+	.name			= "abx500_chargalg",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= abx500_chargalg_props,
+	.num_properties		= ARRAY_SIZE(abx500_chargalg_props),
+	.get_property		= abx500_chargalg_get_property,
+	.external_power_changed	= abx500_chargalg_external_power_changed,
+};
+
 static int abx500_chargalg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -2075,17 +2081,9 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	di->dev = &pdev->dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 
-	/* chargalg supply */
-	di->chargalg_psy.name = "abx500_chargalg";
-	di->chargalg_psy.type = POWER_SUPPLY_TYPE_BATTERY;
-	di->chargalg_psy.properties = abx500_chargalg_props;
-	di->chargalg_psy.num_properties = ARRAY_SIZE(abx500_chargalg_props);
-	di->chargalg_psy.get_property = abx500_chargalg_get_property;
-	di->chargalg_psy.external_power_changed =
-		abx500_chargalg_external_power_changed;
-
 	psy_cfg.supplied_to = supply_interface;
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
+	psy_cfg.drv_data = di;
 
 	/* Initilialize safety timer */
 	hrtimer_init(&di->safety_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
@@ -2117,9 +2115,11 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	di->chg_info.prev_conn_chg = -1;
 
 	/* Register chargalg power supply class */
-	ret = power_supply_register(di->dev, &di->chargalg_psy, &psy_cfg);
-	if (ret) {
+	di->chargalg_psy = power_supply_register(di->dev, &abx500_chargalg_desc,
+						 &psy_cfg);
+	if (IS_ERR(di->chargalg_psy)) {
 		dev_err(di->dev, "failed to register chargalg psy\n");
+		ret = PTR_ERR(di->chargalg_psy);
 		goto free_chargalg_wq;
 	}
 
@@ -2140,7 +2140,7 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	return ret;
 
 free_psy:
-	power_supply_unregister(&di->chargalg_psy);
+	power_supply_unregister(di->chargalg_psy);
 free_chargalg_wq:
 	destroy_workqueue(di->chargalg_wq);
 	return ret;
diff --git a/drivers/power/apm_power.c b/drivers/power/apm_power.c
index 2206f9ff6488..9d1a7fbcaed4 100644
--- a/drivers/power/apm_power.c
+++ b/drivers/power/apm_power.c
@@ -48,7 +48,7 @@ static int __find_main_battery(struct device *dev, void *data)
 
 	bp->bat = dev_get_drvdata(dev);
 
-	if (bp->bat->use_for_apm) {
+	if (bp->bat->desc->use_for_apm) {
 		/* nice, we explicitly asked to report this battery. */
 		bp->main = bp->bat;
 		return 1;
diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index bc47a265b304..cb92022df8eb 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -168,7 +168,8 @@ static char *bq2415x_chip_name[] = {
 struct bq2415x_device {
 	struct device *dev;
 	struct bq2415x_platform_data init_data;
-	struct power_supply charger;
+	struct power_supply *charger;
+	struct power_supply_desc charger_desc;
 	struct delayed_work work;
 	struct power_supply *notify_psy;
 	struct notifier_block nb;
@@ -791,7 +792,7 @@ static int bq2415x_set_mode(struct bq2415x_device *bq, enum bq2415x_mode mode)
 	bq2415x_set_default_value(bq, battery_regulation_voltage);
 
 	bq->mode = mode;
-	sysfs_notify(&bq->charger.dev->kobj, NULL, "mode");
+	sysfs_notify(&bq->charger->dev.kobj, NULL, "mode");
 
 	return 0;
 
@@ -875,7 +876,7 @@ static void bq2415x_set_autotimer(struct bq2415x_device *bq, int state)
 static void bq2415x_timer_error(struct bq2415x_device *bq, const char *msg)
 {
 	bq->timer_error = msg;
-	sysfs_notify(&bq->charger.dev->kobj, NULL, "timer");
+	sysfs_notify(&bq->charger->dev.kobj, NULL, "timer");
 	dev_err(bq->dev, "%s\n", msg);
 	if (bq->automode > 0)
 		bq->automode = 0;
@@ -893,7 +894,7 @@ static void bq2415x_timer_work(struct work_struct *work)
 	int boost;
 
 	if (bq->automode > 0 && (bq->reported_mode != bq->mode)) {
-		sysfs_notify(&bq->charger.dev->kobj, NULL, "reported_mode");
+		sysfs_notify(&bq->charger->dev.kobj, NULL, "reported_mode");
 		bq2415x_set_mode(bq, bq->reported_mode);
 	}
 
@@ -999,8 +1000,7 @@ static int bq2415x_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
 {
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	int ret;
 
 	switch (psp) {
@@ -1031,12 +1031,14 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 	int ret;
 	int chip;
 	char revstr[8];
+	struct power_supply_config psy_cfg = { .drv_data = bq, };
 
-	bq->charger.name = bq->name;
-	bq->charger.type = POWER_SUPPLY_TYPE_USB;
-	bq->charger.properties = bq2415x_power_supply_props;
-	bq->charger.num_properties = ARRAY_SIZE(bq2415x_power_supply_props);
-	bq->charger.get_property = bq2415x_power_supply_get_property;
+	bq->charger_desc.name = bq->name;
+	bq->charger_desc.type = POWER_SUPPLY_TYPE_USB;
+	bq->charger_desc.properties = bq2415x_power_supply_props;
+	bq->charger_desc.num_properties =
+			ARRAY_SIZE(bq2415x_power_supply_props);
+	bq->charger_desc.get_property = bq2415x_power_supply_get_property;
 
 	ret = bq2415x_detect_chip(bq);
 	if (ret < 0)
@@ -1059,10 +1061,11 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 		return -ENOMEM;
 	}
 
-	ret = power_supply_register(bq->dev, &bq->charger, NULL);
-	if (ret) {
+	bq->charger = power_supply_register(bq->dev, &bq->charger_desc,
+					    &psy_cfg);
+	if (IS_ERR(bq->charger)) {
 		kfree(bq->model);
-		return ret;
+		return PTR_ERR(bq->charger);
 	}
 
 	return 0;
@@ -1074,7 +1077,7 @@ static void bq2415x_power_supply_exit(struct bq2415x_device *bq)
 	if (bq->automode > 0)
 		bq->automode = 0;
 	cancel_delayed_work_sync(&bq->work);
-	power_supply_unregister(&bq->charger);
+	power_supply_unregister(bq->charger);
 	kfree(bq->model);
 }
 
@@ -1086,8 +1089,7 @@ static ssize_t bq2415x_sysfs_show_status(struct device *dev,
 					 char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_command command;
 	int ret;
 
@@ -1120,8 +1122,7 @@ static ssize_t bq2415x_sysfs_set_timer(struct device *dev,
 				       size_t count)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	if (strncmp(buf, "auto", 4) == 0)
@@ -1142,8 +1143,7 @@ static ssize_t bq2415x_sysfs_show_timer(struct device *dev,
 					char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 
 	if (bq->timer_error)
 		return sprintf(buf, "%s\n", bq->timer_error);
@@ -1167,8 +1167,7 @@ static ssize_t bq2415x_sysfs_set_mode(struct device *dev,
 				      size_t count)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_mode mode;
 	int ret = 0;
 
@@ -1220,8 +1219,7 @@ static ssize_t bq2415x_sysfs_show_mode(struct device *dev,
 				       char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	ssize_t ret = 0;
 
 	if (bq->automode > 0)
@@ -1258,8 +1256,7 @@ static ssize_t bq2415x_sysfs_show_reported_mode(struct device *dev,
 						char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 
 	if (bq->automode < 0)
 		return -EINVAL;
@@ -1287,8 +1284,7 @@ static ssize_t bq2415x_sysfs_set_registers(struct device *dev,
 					   size_t count)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	ssize_t ret = 0;
 	unsigned int reg;
 	unsigned int val;
@@ -1323,8 +1319,7 @@ static ssize_t bq2415x_sysfs_show_registers(struct device *dev,
 					    char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	ssize_t ret = 0;
 
 	ret += bq2415x_sysfs_print_reg(bq, BQ2415X_REG_STATUS, buf+ret);
@@ -1342,8 +1337,7 @@ static ssize_t bq2415x_sysfs_set_limit(struct device *dev,
 				       size_t count)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	long val;
 	int ret;
 
@@ -1374,8 +1368,7 @@ static ssize_t bq2415x_sysfs_show_limit(struct device *dev,
 					char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	int ret;
 
 	if (strcmp(attr->attr.name, "current_limit") == 0)
@@ -1403,8 +1396,7 @@ static ssize_t bq2415x_sysfs_set_enable(struct device *dev,
 					size_t count)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_command command;
 	long val;
 	int ret;
@@ -1439,8 +1431,7 @@ static ssize_t bq2415x_sysfs_show_enable(struct device *dev,
 					 char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq2415x_device *bq = container_of(psy, struct bq2415x_device,
-						 charger);
+	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_command command;
 	int ret;
 
@@ -1531,13 +1522,13 @@ static const struct attribute_group bq2415x_sysfs_attr_group = {
 
 static int bq2415x_sysfs_init(struct bq2415x_device *bq)
 {
-	return sysfs_create_group(&bq->charger.dev->kobj,
+	return sysfs_create_group(&bq->charger->dev.kobj,
 			&bq2415x_sysfs_attr_group);
 }
 
 static void bq2415x_sysfs_exit(struct bq2415x_device *bq)
 {
-	sysfs_remove_group(&bq->charger.dev->kobj, &bq2415x_sysfs_attr_group);
+	sysfs_remove_group(&bq->charger->dev.kobj, &bq2415x_sysfs_attr_group);
 }
 
 /* main bq2415x probe function */
diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index 54eb58485d55..407c4af83891 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -152,8 +152,8 @@
 struct bq24190_dev_info {
 	struct i2c_client		*client;
 	struct device			*dev;
-	struct power_supply		charger;
-	struct power_supply		battery;
+	struct power_supply		*charger;
+	struct power_supply		*battery;
 	char				model_name[I2C_NAME_SIZE];
 	kernel_ulong_t			model;
 	unsigned int			gpio_int;
@@ -423,8 +423,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq24190_dev_info *bdi =
-			container_of(psy, struct bq24190_dev_info, charger);
+	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	struct bq24190_sysfs_field_info *info;
 	int ret;
 	u8 v;
@@ -444,8 +443,7 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq24190_dev_info *bdi =
-			container_of(psy, struct bq24190_dev_info, charger);
+	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	struct bq24190_sysfs_field_info *info;
 	int ret;
 	u8 v;
@@ -469,13 +467,13 @@ static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
 {
 	bq24190_sysfs_init_attrs();
 
-	return sysfs_create_group(&bdi->charger.dev->kobj,
+	return sysfs_create_group(&bdi->charger->dev.kobj,
 			&bq24190_sysfs_attr_group);
 }
 
 static void bq24190_sysfs_remove_group(struct bq24190_dev_info *bdi)
 {
-	sysfs_remove_group(&bdi->charger.dev->kobj, &bq24190_sysfs_attr_group);
+	sysfs_remove_group(&bdi->charger->dev.kobj, &bq24190_sysfs_attr_group);
 }
 #else
 static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
@@ -807,8 +805,7 @@ static int bq24190_charger_set_voltage(struct bq24190_dev_info *bdi,
 static int bq24190_charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
-	struct bq24190_dev_info *bdi =
-			container_of(psy, struct bq24190_dev_info, charger);
+	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	int ret;
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
@@ -861,8 +858,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		const union power_supply_propval *val)
 {
-	struct bq24190_dev_info *bdi =
-			container_of(psy, struct bq24190_dev_info, charger);
+	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	int ret;
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
@@ -922,18 +918,15 @@ static char *bq24190_charger_supplied_to[] = {
 	"main-battery",
 };
 
-static void bq24190_charger_init(struct power_supply *charger)
-{
-	charger->name = "bq24190-charger";
-	charger->type = POWER_SUPPLY_TYPE_USB;
-	charger->properties = bq24190_charger_properties;
-	charger->num_properties = ARRAY_SIZE(bq24190_charger_properties);
-	charger->supplied_to = bq24190_charger_supplied_to;
-	charger->num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to);
-	charger->get_property = bq24190_charger_get_property;
-	charger->set_property = bq24190_charger_set_property;
-	charger->property_is_writeable = bq24190_charger_property_is_writeable;
-}
+static const struct power_supply_desc bq24190_charger_desc = {
+	.name			= "bq24190-charger",
+	.type			= POWER_SUPPLY_TYPE_USB,
+	.properties		= bq24190_charger_properties,
+	.num_properties		= ARRAY_SIZE(bq24190_charger_properties),
+	.get_property		= bq24190_charger_get_property,
+	.set_property		= bq24190_charger_set_property,
+	.property_is_writeable	= bq24190_charger_property_is_writeable,
+};
 
 /* Battery power supply property routines */
 
@@ -1102,8 +1095,7 @@ static int bq24190_battery_set_temp_alert_max(struct bq24190_dev_info *bdi,
 static int bq24190_battery_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
-	struct bq24190_dev_info *bdi =
-			container_of(psy, struct bq24190_dev_info, battery);
+	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	int ret;
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
@@ -1144,8 +1136,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		const union power_supply_propval *val)
 {
-	struct bq24190_dev_info *bdi =
-			container_of(psy, struct bq24190_dev_info, battery);
+	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	int ret;
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
@@ -1193,16 +1184,15 @@ static enum power_supply_property bq24190_battery_properties[] = {
 	POWER_SUPPLY_PROP_SCOPE,
 };
 
-static void bq24190_battery_init(struct power_supply *battery)
-{
-	battery->name = "bq24190-battery";
-	battery->type = POWER_SUPPLY_TYPE_BATTERY;
-	battery->properties = bq24190_battery_properties;
-	battery->num_properties = ARRAY_SIZE(bq24190_battery_properties);
-	battery->get_property = bq24190_battery_get_property;
-	battery->set_property = bq24190_battery_set_property;
-	battery->property_is_writeable = bq24190_battery_property_is_writeable;
-}
+static const struct power_supply_desc bq24190_battery_desc = {
+	.name			= "bq24190-battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= bq24190_battery_properties,
+	.num_properties		= ARRAY_SIZE(bq24190_battery_properties),
+	.get_property		= bq24190_battery_get_property,
+	.set_property		= bq24190_battery_set_property,
+	.property_is_writeable	= bq24190_battery_property_is_writeable,
+};
 
 static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 {
@@ -1269,8 +1259,8 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	 * interrupt received).
 	 */
 	if (alert_userspace && !bdi->first_time) {
-		power_supply_changed(&bdi->charger);
-		power_supply_changed(&bdi->battery);
+		power_supply_changed(bdi->charger);
+		power_supply_changed(bdi->battery);
 		bdi->first_time = false;
 	}
 
@@ -1362,6 +1352,7 @@ static int bq24190_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct device *dev = &client->dev;
 	struct bq24190_platform_data *pdata = client->dev.platform_data;
+	struct power_supply_config charger_cfg = {}, battery_cfg = {};
 	struct bq24190_dev_info *bdi;
 	int ret;
 
@@ -1416,19 +1407,23 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out2;
 	}
 
-	bq24190_charger_init(&bdi->charger);
-
-	ret = power_supply_register(dev, &bdi->charger, NULL);
-	if (ret) {
+	charger_cfg.drv_data = bdi;
+	charger_cfg.supplied_to = bq24190_charger_supplied_to;
+	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to),
+	bdi->charger = power_supply_register(dev, &bq24190_charger_desc,
+						&charger_cfg);
+	if (IS_ERR(bdi->charger)) {
 		dev_err(dev, "Can't register charger\n");
+		ret = PTR_ERR(bdi->charger);
 		goto out2;
 	}
 
-	bq24190_battery_init(&bdi->battery);
-
-	ret = power_supply_register(dev, &bdi->battery, NULL);
-	if (ret) {
+	battery_cfg.drv_data = bdi;
+	bdi->battery = power_supply_register(dev, &bq24190_battery_desc,
+						&battery_cfg);
+	if (IS_ERR(bdi->battery)) {
 		dev_err(dev, "Can't register battery\n");
+		ret = PTR_ERR(bdi->battery);
 		goto out3;
 	}
 
@@ -1441,9 +1436,9 @@ static int bq24190_probe(struct i2c_client *client,
 	return 0;
 
 out4:
-	power_supply_unregister(&bdi->battery);
+	power_supply_unregister(bdi->battery);
 out3:
-	power_supply_unregister(&bdi->charger);
+	power_supply_unregister(bdi->charger);
 out2:
 	pm_runtime_disable(dev);
 out1:
@@ -1462,8 +1457,8 @@ static int bq24190_remove(struct i2c_client *client)
 	pm_runtime_put_sync(bdi->dev);
 
 	bq24190_sysfs_remove_group(bdi);
-	power_supply_unregister(&bdi->battery);
-	power_supply_unregister(&bdi->charger);
+	power_supply_unregister(bdi->battery);
+	power_supply_unregister(bdi->charger);
 	pm_runtime_disable(bdi->dev);
 
 	if (bdi->gpio_int)
@@ -1499,8 +1494,8 @@ static int bq24190_pm_resume(struct device *dev)
 	pm_runtime_put_sync(bdi->dev);
 
 	/* Things may have changed while suspended so alert upper layer */
-	power_supply_changed(&bdi->charger);
-	power_supply_changed(&bdi->battery);
+	power_supply_changed(bdi->charger);
+	power_supply_changed(bdi->battery);
 
 	return 0;
 }
diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index 242e79bfe217..961a18930027 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -44,14 +44,15 @@
 #define BQ24735_DEVICE_ID		0xff
 
 struct bq24735 {
-	struct power_supply	charger;
-	struct i2c_client	*client;
-	struct bq24735_platform	*pdata;
+	struct power_supply		*charger;
+	struct power_supply_desc	charger_desc;
+	struct i2c_client		*client;
+	struct bq24735_platform		*pdata;
 };
 
 static inline struct bq24735 *to_bq24735(struct power_supply *psy)
 {
-	return container_of(psy, struct bq24735, charger);
+	return power_supply_get_drvdata(psy);
 }
 
 static enum power_supply_property bq24735_charger_properties[] = {
@@ -192,9 +193,7 @@ static int bq24735_charger_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct bq24735 *charger;
-
-	charger = container_of(psy, struct bq24735, charger);
+	struct bq24735 *charger = to_bq24735(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -248,7 +247,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 {
 	int ret;
 	struct bq24735 *charger;
-	struct power_supply *supply;
+	struct power_supply_desc *supply_desc;
 	struct power_supply_config psy_cfg = {};
 	char *name;
 
@@ -278,17 +277,18 @@ static int bq24735_charger_probe(struct i2c_client *client,
 
 	charger->client = client;
 
-	supply = &charger->charger;
+	supply_desc = &charger->charger_desc;
 
-	supply->name = name;
-	supply->type = POWER_SUPPLY_TYPE_MAINS;
-	supply->properties = bq24735_charger_properties;
-	supply->num_properties = ARRAY_SIZE(bq24735_charger_properties);
-	supply->get_property = bq24735_charger_get_property;
+	supply_desc->name = name;
+	supply_desc->type = POWER_SUPPLY_TYPE_MAINS;
+	supply_desc->properties = bq24735_charger_properties;
+	supply_desc->num_properties = ARRAY_SIZE(bq24735_charger_properties);
+	supply_desc->get_property = bq24735_charger_get_property;
 
 	psy_cfg.supplied_to = charger->pdata->supplied_to;
 	psy_cfg.num_supplicants = charger->pdata->num_supplicants;
 	psy_cfg.of_node = client->dev.of_node;
+	psy_cfg.drv_data = charger;
 
 	i2c_set_clientdata(client, charger);
 
@@ -343,8 +343,10 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = power_supply_register(&client->dev, supply, &psy_cfg);
-	if (ret < 0) {
+	charger->charger = power_supply_register(&client->dev, supply_desc,
+						 &psy_cfg);
+	if (IS_ERR(charger->charger)) {
+		ret = PTR_ERR(charger->charger);
 		dev_err(&client->dev, "Failed to register power supply: %d\n",
 			ret);
 		goto err_free_name;
@@ -356,7 +358,8 @@ static int bq24735_charger_probe(struct i2c_client *client,
 						IRQF_TRIGGER_RISING |
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
-						supply->name, supply);
+						supply_desc->name,
+						charger->charger);
 		if (ret) {
 			dev_err(&client->dev,
 				"Unable to register IRQ %d err %d\n",
@@ -367,7 +370,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 
 	return 0;
 err_unregister_supply:
-	power_supply_unregister(supply);
+	power_supply_unregister(charger->charger);
 err_free_name:
 	if (name != charger->pdata->name)
 		kfree(name);
@@ -383,10 +386,10 @@ static int bq24735_charger_remove(struct i2c_client *client)
 		devm_free_irq(&charger->client->dev, charger->client->irq,
 			      &charger->charger);
 
-	power_supply_unregister(&charger->charger);
+	power_supply_unregister(charger->charger);
 
-	if (charger->charger.name != charger->pdata->name)
-		kfree(charger->charger.name);
+	if (charger->charger_desc.name != charger->pdata->name)
+		kfree(charger->charger_desc.name);
 
 	return 0;
 }
diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 5b8bdd0d3cb0..6a44142bcfd0 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -114,7 +114,7 @@ struct bq27x00_device_info {
 	unsigned long last_update;
 	struct delayed_work work;
 
-	struct power_supply	bat;
+	struct power_supply	*bat;
 
 	struct bq27x00_access_methods bus;
 
@@ -498,7 +498,7 @@ static void bq27x00_update(struct bq27x00_device_info *di)
 	}
 
 	if (di->cache.capacity != cache.capacity)
-		power_supply_changed(&di->bat);
+		power_supply_changed(di->bat);
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
 		di->cache = cache;
@@ -570,7 +570,7 @@ static int bq27x00_battery_status(struct bq27x00_device_info *di,
 			status = POWER_SUPPLY_STATUS_FULL;
 		else if (di->cache.flags & BQ27000_FLAG_CHGS)
 			status = POWER_SUPPLY_STATUS_CHARGING;
-		else if (power_supply_am_i_supplied(&di->bat))
+		else if (power_supply_am_i_supplied(di->bat))
 			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
 			status = POWER_SUPPLY_STATUS_DISCHARGING;
@@ -642,15 +642,12 @@ static int bq27x00_simple_value(int value,
 	return 0;
 }
 
-#define to_bq27x00_device_info(x) container_of((x), \
-				struct bq27x00_device_info, bat);
-
 static int bq27x00_battery_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
 	int ret = 0;
-	struct bq27x00_device_info *di = to_bq27x00_device_info(psy);
+	struct bq27x00_device_info *di = power_supply_get_drvdata(psy);
 
 	mutex_lock(&di->lock);
 	if (time_is_before_jiffies(di->last_update + 5 * HZ)) {
@@ -728,35 +725,44 @@ static int bq27x00_battery_get_property(struct power_supply *psy,
 
 static void bq27x00_external_power_changed(struct power_supply *psy)
 {
-	struct bq27x00_device_info *di = to_bq27x00_device_info(psy);
+	struct bq27x00_device_info *di = power_supply_get_drvdata(psy);
 
 	cancel_delayed_work_sync(&di->work);
 	schedule_delayed_work(&di->work, 0);
 }
 
-static int bq27x00_powersupply_init(struct bq27x00_device_info *di)
+static int bq27x00_powersupply_init(struct bq27x00_device_info *di,
+				    const char *name)
 {
 	int ret;
+	struct power_supply_desc *psy_desc;
+	struct power_supply_config psy_cfg = { .drv_data = di, };
+
+	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
+	if (!psy_desc)
+		return -ENOMEM;
 
-	di->bat.type = POWER_SUPPLY_TYPE_BATTERY;
+	psy_desc->name = name;
+	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	if (di->chip == BQ27425) {
-		di->bat.properties = bq27425_battery_props;
-		di->bat.num_properties = ARRAY_SIZE(bq27425_battery_props);
+		psy_desc->properties = bq27425_battery_props;
+		psy_desc->num_properties = ARRAY_SIZE(bq27425_battery_props);
 	} else if (di->chip == BQ27742) {
-		di->bat.properties = bq27742_battery_props;
-		di->bat.num_properties = ARRAY_SIZE(bq27742_battery_props);
+		psy_desc->properties = bq27742_battery_props;
+		psy_desc->num_properties = ARRAY_SIZE(bq27742_battery_props);
 	} else {
-		di->bat.properties = bq27x00_battery_props;
-		di->bat.num_properties = ARRAY_SIZE(bq27x00_battery_props);
+		psy_desc->properties = bq27x00_battery_props;
+		psy_desc->num_properties = ARRAY_SIZE(bq27x00_battery_props);
 	}
-	di->bat.get_property = bq27x00_battery_get_property;
-	di->bat.external_power_changed = bq27x00_external_power_changed;
+	psy_desc->get_property = bq27x00_battery_get_property;
+	psy_desc->external_power_changed = bq27x00_external_power_changed;
 
 	INIT_DELAYED_WORK(&di->work, bq27x00_battery_poll);
 	mutex_init(&di->lock);
 
-	ret = power_supply_register(di->dev, &di->bat, NULL);
-	if (ret) {
+	di->bat = power_supply_register(di->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(di->bat)) {
+		ret = PTR_ERR(di->bat);
 		dev_err(di->dev, "failed to register battery: %d\n", ret);
 		return ret;
 	}
@@ -780,7 +786,7 @@ static void bq27x00_powersupply_unregister(struct bq27x00_device_info *di)
 
 	cancel_delayed_work_sync(&di->work);
 
-	power_supply_unregister(&di->bat);
+	power_supply_unregister(di->bat);
 
 	mutex_destroy(&di->lock);
 }
@@ -844,37 +850,34 @@ static int bq27x00_battery_probe(struct i2c_client *client,
 	if (num < 0)
 		return num;
 
-	name = kasprintf(GFP_KERNEL, "%s-%d", id->name, num);
+	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%d", id->name, num);
 	if (!name) {
 		dev_err(&client->dev, "failed to allocate device name\n");
 		retval = -ENOMEM;
-		goto batt_failed_1;
+		goto batt_failed;
 	}
 
 	di = devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
 	if (!di) {
 		dev_err(&client->dev, "failed to allocate device info data\n");
 		retval = -ENOMEM;
-		goto batt_failed_2;
+		goto batt_failed;
 	}
 
 	di->id = num;
 	di->dev = &client->dev;
 	di->chip = id->driver_data;
-	di->bat.name = name;
 	di->bus.read = &bq27x00_read_i2c;
 
-	retval = bq27x00_powersupply_init(di);
+	retval = bq27x00_powersupply_init(di, name);
 	if (retval)
-		goto batt_failed_2;
+		goto batt_failed;
 
 	i2c_set_clientdata(client, di);
 
 	return 0;
 
-batt_failed_2:
-	kfree(name);
-batt_failed_1:
+batt_failed:
 	mutex_lock(&battery_mutex);
 	idr_remove(&battery_id, num);
 	mutex_unlock(&battery_mutex);
@@ -888,8 +891,6 @@ static int bq27x00_battery_remove(struct i2c_client *client)
 
 	bq27x00_powersupply_unregister(di);
 
-	kfree(di->bat.name);
-
 	mutex_lock(&battery_mutex);
 	idr_remove(&battery_id, di->id);
 	mutex_unlock(&battery_mutex);
@@ -977,6 +978,7 @@ static int bq27000_battery_probe(struct platform_device *pdev)
 {
 	struct bq27x00_device_info *di;
 	struct bq27000_platform_data *pdata = pdev->dev.platform_data;
+	const char *name;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform_data supplied\n");
@@ -999,10 +1001,10 @@ static int bq27000_battery_probe(struct platform_device *pdev)
 	di->dev = &pdev->dev;
 	di->chip = BQ27000;
 
-	di->bat.name = pdata->name ?: dev_name(&pdev->dev);
+	name = pdata->name ?: dev_name(&pdev->dev);
 	di->bus.read = &bq27000_read_platform;
 
-	return bq27x00_powersupply_init(di);
+	return bq27x00_powersupply_init(di, name);
 }
 
 static int bq27000_battery_remove(struct platform_device *pdev)
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index a5b86b60d244..5c47409c6889 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -864,8 +864,7 @@ static int charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		union power_supply_propval *val)
 {
-	struct charger_manager *cm = container_of(psy,
-			struct charger_manager, charger_psy);
+	struct charger_manager *cm = power_supply_get_drvdata(psy);
 	struct charger_desc *desc = cm->desc;
 	struct power_supply *fuel_gauge;
 	int ret = 0;
@@ -1018,7 +1017,7 @@ static enum power_supply_property default_charger_props[] = {
 	 */
 };
 
-static struct power_supply psy_default = {
+static const struct power_supply_desc psy_default = {
 	.name = "battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
 	.properties = default_charger_props,
@@ -1399,7 +1398,7 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 		dev_info(cm->dev, "'%s' regulator's externally_control is %d\n",
 			 charger->regulator_name, charger->externally_control);
 
-		ret = sysfs_create_group(&cm->charger_psy.dev->kobj,
+		ret = sysfs_create_group(&cm->charger_psy->dev.kobj,
 					&charger->attr_g);
 		if (ret < 0) {
 			dev_err(cm->dev, "Cannot create sysfs entry of %s regulator\n",
@@ -1431,9 +1430,9 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 					POWER_SUPPLY_PROP_TEMP, &val);
 
 	if (!ret) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
+		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_TEMP;
-		cm->charger_psy.num_properties++;
+		cm->charger_psy_desc.num_properties++;
 		cm->desc->measure_battery_temp = true;
 	}
 #ifdef CONFIG_THERMAL
@@ -1444,9 +1443,9 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 			return PTR_ERR(cm->tzd_batt);
 
 		/* Use external thermometer */
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
+		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_TEMP_AMBIENT;
-		cm->charger_psy.num_properties++;
+		cm->charger_psy_desc.num_properties++;
 		cm->desc->measure_battery_temp = true;
 		ret = 0;
 	}
@@ -1606,6 +1605,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	int j = 0;
 	union power_supply_propval val;
 	struct power_supply *fuel_gauge;
+	struct power_supply_config psy_cfg = {};
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
@@ -1620,6 +1620,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	/* Basic Values. Unspecified are Null or 0 */
 	cm->dev = &pdev->dev;
 	cm->desc = desc;
+	psy_cfg.drv_data = cm;
 
 	/* Initialize alarm timer */
 	if (alarmtimer_get_rtcdev()) {
@@ -1699,40 +1700,40 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cm);
 
-	memcpy(&cm->charger_psy, &psy_default, sizeof(psy_default));
+	memcpy(&cm->charger_psy_desc, &psy_default, sizeof(psy_default));
 
 	if (!desc->psy_name)
 		strncpy(cm->psy_name_buf, psy_default.name, PSY_NAME_MAX);
 	else
 		strncpy(cm->psy_name_buf, desc->psy_name, PSY_NAME_MAX);
-	cm->charger_psy.name = cm->psy_name_buf;
+	cm->charger_psy_desc.name = cm->psy_name_buf;
 
 	/* Allocate for psy properties because they may vary */
-	cm->charger_psy.properties = devm_kzalloc(&pdev->dev,
+	cm->charger_psy_desc.properties = devm_kzalloc(&pdev->dev,
 				sizeof(enum power_supply_property)
 				* (ARRAY_SIZE(default_charger_props) +
 				NUM_CHARGER_PSY_OPTIONAL), GFP_KERNEL);
-	if (!cm->charger_psy.properties)
+	if (!cm->charger_psy_desc.properties)
 		return -ENOMEM;
 
-	memcpy(cm->charger_psy.properties, default_charger_props,
+	memcpy(cm->charger_psy_desc.properties, default_charger_props,
 		sizeof(enum power_supply_property) *
 		ARRAY_SIZE(default_charger_props));
-	cm->charger_psy.num_properties = psy_default.num_properties;
+	cm->charger_psy_desc.num_properties = psy_default.num_properties;
 
 	/* Find which optional psy-properties are available */
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
+		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_CHARGE_NOW;
-		cm->charger_psy.num_properties++;
+		cm->charger_psy_desc.num_properties++;
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CURRENT_NOW,
 					  &val)) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
+		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
 				POWER_SUPPLY_PROP_CURRENT_NOW;
-		cm->charger_psy.num_properties++;
+		cm->charger_psy_desc.num_properties++;
 	}
 
 	ret = cm_init_thermal_data(cm, fuel_gauge);
@@ -1743,11 +1744,12 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
 
-	ret = power_supply_register(NULL, &cm->charger_psy, NULL);
-	if (ret) {
+	cm->charger_psy = power_supply_register(NULL, &cm->charger_psy_desc,
+						&psy_cfg);
+	if (IS_ERR(cm->charger_psy)) {
 		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
-			cm->charger_psy.name);
-		return ret;
+			cm->charger_psy->desc->name);
+		return PTR_ERR(cm->charger_psy);
 	}
 
 	/* Register extcon device for charger cable */
@@ -1793,7 +1795,7 @@ err_reg_sysfs:
 		struct charger_regulator *charger;
 
 		charger = &desc->charger_regulators[i];
-		sysfs_remove_group(&cm->charger_psy.dev->kobj,
+		sysfs_remove_group(&cm->charger_psy->dev.kobj,
 				&charger->attr_g);
 	}
 err_reg_extcon:
@@ -1811,7 +1813,7 @@ err_reg_extcon:
 		regulator_put(desc->charger_regulators[i].consumer);
 	}
 
-	power_supply_unregister(&cm->charger_psy);
+	power_supply_unregister(cm->charger_psy);
 
 	return ret;
 }
@@ -1843,7 +1845,7 @@ static int charger_manager_remove(struct platform_device *pdev)
 	for (i = 0 ; i < desc->num_charger_regulators ; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
 
-	power_supply_unregister(&cm->charger_psy);
+	power_supply_unregister(cm->charger_psy);
 
 	try_charger_enable(cm, false);
 
@@ -2002,7 +2004,7 @@ static bool find_power_supply(struct charger_manager *cm,
 	bool found = false;
 
 	for (i = 0; cm->desc->psy_charger_stat[i]; i++) {
-		if (!strcmp(psy->name, cm->desc->psy_charger_stat[i])) {
+		if (!strcmp(psy->desc->name, cm->desc->psy_charger_stat[i])) {
 			found = true;
 			break;
 		}
diff --git a/drivers/power/collie_battery.c b/drivers/power/collie_battery.c
index e7a808d1758a..2da9ed8ccbb5 100644
--- a/drivers/power/collie_battery.c
+++ b/drivers/power/collie_battery.c
@@ -30,7 +30,7 @@ static int wakeup_enabled;
 
 struct collie_bat {
 	int status;
-	struct power_supply psy;
+	struct power_supply *psy;
 	int full_chrg;
 
 	struct mutex work_lock; /* protects data */
@@ -98,7 +98,7 @@ static int collie_bat_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	int ret = 0;
-	struct collie_bat *bat = container_of(psy, struct collie_bat, psy);
+	struct collie_bat *bat = power_supply_get_drvdata(psy);
 
 	if (bat->is_present && !bat->is_present(bat)
 			&& psp != POWER_SUPPLY_PROP_PRESENT) {
@@ -155,14 +155,14 @@ static irqreturn_t collie_bat_gpio_isr(int irq, void *data)
 static void collie_bat_update(struct collie_bat *bat)
 {
 	int old;
-	struct power_supply *psy = &bat->psy;
+	struct power_supply *psy = bat->psy;
 
 	mutex_lock(&bat->work_lock);
 
 	old = bat->status;
 
 	if (bat->is_present && !bat->is_present(bat)) {
-		printk(KERN_NOTICE "%s not present\n", psy->name);
+		printk(KERN_NOTICE "%s not present\n", psy->desc->name);
 		bat->status = POWER_SUPPLY_STATUS_UNKNOWN;
 		bat->full_chrg = -1;
 	} else if (power_supply_am_i_supplied(psy)) {
@@ -220,18 +220,20 @@ static enum power_supply_property collie_bat_bu_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 };
 
+static const struct power_supply_desc collie_bat_main_desc = {
+	.name		= "main-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= collie_bat_main_props,
+	.num_properties	= ARRAY_SIZE(collie_bat_main_props),
+	.get_property	= collie_bat_get_property,
+	.external_power_changed = collie_bat_external_power_changed,
+	.use_for_apm	= 1,
+};
+
 static struct collie_bat collie_bat_main = {
 	.status = POWER_SUPPLY_STATUS_DISCHARGING,
 	.full_chrg = -1,
-	.psy = {
-		.name		= "main-battery",
-		.type		= POWER_SUPPLY_TYPE_BATTERY,
-		.properties	= collie_bat_main_props,
-		.num_properties	= ARRAY_SIZE(collie_bat_main_props),
-		.get_property	= collie_bat_get_property,
-		.external_power_changed = collie_bat_external_power_changed,
-		.use_for_apm	= 1,
-	},
+	.psy = NULL,
 
 	.gpio_full = COLLIE_GPIO_CO,
 	.gpio_charge_on = COLLIE_GPIO_CHARGE_ON,
@@ -249,18 +251,19 @@ static struct collie_bat collie_bat_main = {
 	.adc_temp_divider = 10000,
 };
 
+static const struct power_supply_desc collie_bat_bu_desc = {
+	.name		= "backup-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= collie_bat_bu_props,
+	.num_properties	= ARRAY_SIZE(collie_bat_bu_props),
+	.get_property	= collie_bat_get_property,
+	.external_power_changed = collie_bat_external_power_changed,
+};
+
 static struct collie_bat collie_bat_bu = {
 	.status = POWER_SUPPLY_STATUS_UNKNOWN,
 	.full_chrg = -1,
-
-	.psy = {
-		.name		= "backup-battery",
-		.type		= POWER_SUPPLY_TYPE_BATTERY,
-		.properties	= collie_bat_bu_props,
-		.num_properties	= ARRAY_SIZE(collie_bat_bu_props),
-		.get_property	= collie_bat_get_property,
-		.external_power_changed = collie_bat_external_power_changed,
-	},
+	.psy = NULL,
 
 	.gpio_full = -1,
 	.gpio_charge_on = -1,
@@ -319,6 +322,7 @@ static int collie_bat_resume(struct ucb1x00_dev *dev)
 static int collie_bat_probe(struct ucb1x00_dev *dev)
 {
 	int ret;
+	struct power_supply_config psy_main_cfg = {}, psy_bu_cfg = {};
 
 	if (!machine_is_collie())
 		return -ENODEV;
@@ -334,12 +338,23 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 
 	INIT_WORK(&bat_work, collie_bat_work);
 
-	ret = power_supply_register(&dev->ucb->dev, &collie_bat_main.psy, NULL);
-	if (ret)
+	psy_main_cfg.drv_data = &collie_bat_main;
+	collie_bat_main.psy = power_supply_register(&dev->ucb->dev,
+						    &collie_bat_main_desc,
+						    &psy_main_cfg);
+	if (IS_ERR(collie_bat_main.psy)) {
+		ret = PTR_ERR(collie_bat_main.psy);
 		goto err_psy_reg_main;
-	ret = power_supply_register(&dev->ucb->dev, &collie_bat_bu.psy, NULL);
-	if (ret)
+	}
+
+	psy_main_cfg.drv_data = &collie_bat_bu;
+	collie_bat_bu.psy = power_supply_register(&dev->ucb->dev,
+						  &collie_bat_bu_desc,
+						  &psy_bu_cfg);
+	if (IS_ERR(collie_bat_bu.psy)) {
+		ret = PTR_ERR(collie_bat_bu.psy);
 		goto err_psy_reg_bu;
+	}
 
 	ret = request_irq(gpio_to_irq(COLLIE_GPIO_CO),
 				collie_bat_gpio_isr,
@@ -354,9 +369,9 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 	return 0;
 
 err_irq:
-	power_supply_unregister(&collie_bat_bu.psy);
+	power_supply_unregister(collie_bat_bu.psy);
 err_psy_reg_bu:
-	power_supply_unregister(&collie_bat_main.psy);
+	power_supply_unregister(collie_bat_main.psy);
 err_psy_reg_main:
 
 	/* see comment in collie_bat_remove */
@@ -369,8 +384,8 @@ static void collie_bat_remove(struct ucb1x00_dev *dev)
 {
 	free_irq(gpio_to_irq(COLLIE_GPIO_CO), &collie_bat_main);
 
-	power_supply_unregister(&collie_bat_bu.psy);
-	power_supply_unregister(&collie_bat_main.psy);
+	power_supply_unregister(collie_bat_bu.psy);
+	power_supply_unregister(collie_bat_main.psy);
 
 	/*
 	 * Now cancel the bat_work.  We won't get any more schedules,
diff --git a/drivers/power/da9030_battery.c b/drivers/power/da9030_battery.c
index a87406ef18ee..5ca0f4d90792 100644
--- a/drivers/power/da9030_battery.c
+++ b/drivers/power/da9030_battery.c
@@ -89,7 +89,8 @@ struct da9030_battery_thresholds {
 };
 
 struct da9030_charger {
-	struct power_supply psy;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
 
 	struct device *master;
 
@@ -245,7 +246,7 @@ static void da9030_set_charge(struct da9030_charger *charger, int on)
 
 	da903x_write(charger->master, DA9030_CHARGE_CONTROL, val);
 
-	power_supply_changed(&charger->psy);
+	power_supply_changed(charger->psy);
 }
 
 static void da9030_charger_check_state(struct da9030_charger *charger)
@@ -341,8 +342,7 @@ static int da9030_battery_get_property(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   union power_supply_propval *val)
 {
-	struct da9030_charger *charger;
-	charger = container_of(psy, struct da9030_charger, psy);
+	struct da9030_charger *charger = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -447,16 +447,16 @@ static void da9030_battery_convert_thresholds(struct da9030_charger *charger,
 
 static void da9030_battery_setup_psy(struct da9030_charger *charger)
 {
-	struct power_supply *psy = &charger->psy;
+	struct power_supply_desc *psy_desc = &charger->psy_desc;
 	struct power_supply_info *info = charger->battery_info;
 
-	psy->name = info->name;
-	psy->use_for_apm = info->use_for_apm;
-	psy->type = POWER_SUPPLY_TYPE_BATTERY;
-	psy->get_property = da9030_battery_get_property;
+	psy_desc->name = info->name;
+	psy_desc->use_for_apm = info->use_for_apm;
+	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	psy_desc->get_property = da9030_battery_get_property;
 
-	psy->properties = da9030_battery_props;
-	psy->num_properties = ARRAY_SIZE(da9030_battery_props);
+	psy_desc->properties = da9030_battery_props;
+	psy_desc->num_properties = ARRAY_SIZE(da9030_battery_props);
 };
 
 static int da9030_battery_charger_init(struct da9030_charger *charger)
@@ -494,6 +494,7 @@ static int da9030_battery_charger_init(struct da9030_charger *charger)
 static int da9030_battery_probe(struct platform_device *pdev)
 {
 	struct da9030_charger *charger;
+	struct power_supply_config psy_cfg = {};
 	struct da9030_battery_info *pdata = pdev->dev.platform_data;
 	int ret;
 
@@ -541,9 +542,13 @@ static int da9030_battery_probe(struct platform_device *pdev)
 		goto err_notifier;
 
 	da9030_battery_setup_psy(charger);
-	ret = power_supply_register(&pdev->dev, &charger->psy, NULL);
-	if (ret)
+	psy_cfg.drv_data = charger;
+	charger->psy = power_supply_register(&pdev->dev, &charger->psy_desc,
+					     &psy_cfg);
+	if (IS_ERR(charger->psy)) {
+		ret = PTR_ERR(charger->psy);
 		goto err_ps_register;
+	}
 
 	charger->debug_file = da9030_bat_create_debugfs(charger);
 	platform_set_drvdata(pdev, charger);
@@ -571,7 +576,7 @@ static int da9030_battery_remove(struct platform_device *dev)
 				   DA9030_EVENT_CHIOVER | DA9030_EVENT_TBAT);
 	cancel_delayed_work_sync(&charger->work);
 	da9030_set_charge(charger, 0);
-	power_supply_unregister(&charger->psy);
+	power_supply_unregister(charger->psy);
 
 	return 0;
 }
diff --git a/drivers/power/da9052-battery.c b/drivers/power/da9052-battery.c
index 54ba9ddb6d4f..830ec46fe7d0 100644
--- a/drivers/power/da9052-battery.c
+++ b/drivers/power/da9052-battery.c
@@ -169,7 +169,7 @@ static u32 const vc_tbl[3][68][2] = {
 
 struct da9052_battery {
 	struct da9052 *da9052;
-	struct power_supply psy;
+	struct power_supply *psy;
 	struct notifier_block nb;
 	int charger_type;
 	int status;
@@ -452,7 +452,7 @@ static irqreturn_t da9052_bat_irq(int irq, void *data)
 
 	if (irq == DA9052_IRQ_CHGEND || irq == DA9052_IRQ_DCIN ||
 	    irq == DA9052_IRQ_VBUS || irq == DA9052_IRQ_TBAT) {
-		power_supply_changed(&bat->psy);
+		power_supply_changed(bat->psy);
 	}
 
 	return IRQ_HANDLED;
@@ -499,8 +499,7 @@ static int da9052_bat_get_property(struct power_supply *psy,
 {
 	int ret;
 	int illegal;
-	struct da9052_battery *bat = container_of(psy, struct da9052_battery,
-						  psy);
+	struct da9052_battery *bat = power_supply_get_drvdata(psy);
 
 	ret = da9052_bat_check_presence(bat, &illegal);
 	if (ret < 0)
@@ -561,7 +560,7 @@ static enum power_supply_property da9052_bat_props[] = {
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 };
 
-static struct power_supply template_battery = {
+static struct power_supply_desc psy_desc = {
 	.name		= "da9052-bat",
 	.type		= POWER_SUPPLY_TYPE_BATTERY,
 	.properties	= da9052_bat_props,
@@ -591,6 +590,7 @@ static s32 da9052_bat_probe(struct platform_device *pdev)
 {
 	struct da9052_pdata *pdata;
 	struct da9052_battery *bat;
+	struct power_supply_config psy_cfg = {};
 	int ret;
 	int i;
 
@@ -599,8 +599,9 @@ static s32 da9052_bat_probe(struct platform_device *pdev)
 	if (!bat)
 		return -ENOMEM;
 
+	psy_cfg.drv_data = bat;
+
 	bat->da9052 = dev_get_drvdata(pdev->dev.parent);
-	bat->psy = template_battery;
 	bat->charger_type = DA9052_NOCHARGER;
 	bat->status = POWER_SUPPLY_STATUS_UNKNOWN;
 	bat->health = POWER_SUPPLY_HEALTH_UNKNOWN;
@@ -608,9 +609,9 @@ static s32 da9052_bat_probe(struct platform_device *pdev)
 
 	pdata = bat->da9052->dev->platform_data;
 	if (pdata != NULL && pdata->use_for_apm)
-		bat->psy.use_for_apm = pdata->use_for_apm;
+		psy_desc.use_for_apm = pdata->use_for_apm;
 	else
-		bat->psy.use_for_apm = 1;
+		psy_desc.use_for_apm = 1;
 
 	for (i = 0; i < ARRAY_SIZE(da9052_bat_irqs); i++) {
 		ret = da9052_request_irq(bat->da9052,
@@ -625,9 +626,11 @@ static s32 da9052_bat_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = power_supply_register(&pdev->dev, &bat->psy, NULL);
-	 if (ret)
+	bat->psy = power_supply_register(&pdev->dev, &psy_desc, &psy_cfg);
+	if (IS_ERR(bat->psy)) {
+		ret = PTR_ERR(bat->psy);
 		goto err;
+	}
 
 	platform_set_drvdata(pdev, bat);
 	return 0;
@@ -646,7 +649,7 @@ static int da9052_bat_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(da9052_bat_irqs); i++)
 		da9052_free_irq(bat->da9052, da9052_bat_irq_bits[i], bat);
 
-	power_supply_unregister(&bat->psy);
+	power_supply_unregister(bat->psy);
 
 	return 0;
 }
diff --git a/drivers/power/ds2760_battery.c b/drivers/power/ds2760_battery.c
index e82dff0bbb20..80f73ccb77ab 100644
--- a/drivers/power/ds2760_battery.c
+++ b/drivers/power/ds2760_battery.c
@@ -53,7 +53,8 @@ struct ds2760_device_info {
 	int charge_status;		/* POWER_SUPPLY_STATUS_* */
 
 	int full_counter;
-	struct power_supply bat;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
 	struct device *w1_dev;
 	struct workqueue_struct *monitor_wqueue;
 	struct delayed_work monitor_work;
@@ -254,7 +255,7 @@ static void ds2760_battery_update_status(struct ds2760_device_info *di)
 	if (di->charge_status == POWER_SUPPLY_STATUS_UNKNOWN)
 		di->full_counter = 0;
 
-	if (power_supply_am_i_supplied(&di->bat)) {
+	if (power_supply_am_i_supplied(di->bat)) {
 		if (di->current_uA > 10000) {
 			di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 			di->full_counter = 0;
@@ -287,7 +288,7 @@ static void ds2760_battery_update_status(struct ds2760_device_info *di)
 	}
 
 	if (di->charge_status != old_charge_status)
-		power_supply_changed(&di->bat);
+		power_supply_changed(di->bat);
 }
 
 static void ds2760_battery_write_status(struct ds2760_device_info *di,
@@ -346,12 +347,9 @@ static void ds2760_battery_work(struct work_struct *work)
 	queue_delayed_work(di->monitor_wqueue, &di->monitor_work, interval);
 }
 
-#define to_ds2760_device_info(x) container_of((x), struct ds2760_device_info, \
-					      bat);
-
 static void ds2760_battery_external_power_changed(struct power_supply *psy)
 {
-	struct ds2760_device_info *di = to_ds2760_device_info(psy);
+	struct ds2760_device_info *di = power_supply_get_drvdata(psy);
 
 	dev_dbg(di->dev, "%s\n", __func__);
 
@@ -377,7 +375,7 @@ static void ds2760_battery_set_charged_work(struct work_struct *work)
 	 * that error.
 	 */
 
-	if (!power_supply_am_i_supplied(&di->bat))
+	if (!power_supply_am_i_supplied(di->bat))
 		return;
 
 	bias = (signed char) di->current_raw +
@@ -396,7 +394,7 @@ static void ds2760_battery_set_charged_work(struct work_struct *work)
 
 static void ds2760_battery_set_charged(struct power_supply *psy)
 {
-	struct ds2760_device_info *di = to_ds2760_device_info(psy);
+	struct ds2760_device_info *di = power_supply_get_drvdata(psy);
 
 	/* postpone the actual work by 20 secs. This is for debouncing GPIO
 	 * signals and to let the current value settle. See AN4188. */
@@ -407,7 +405,7 @@ static int ds2760_battery_get_property(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       union power_supply_propval *val)
 {
-	struct ds2760_device_info *di = to_ds2760_device_info(psy);
+	struct ds2760_device_info *di = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -458,7 +456,7 @@ static int ds2760_battery_set_property(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       const union power_supply_propval *val)
 {
-	struct ds2760_device_info *di = to_ds2760_device_info(psy);
+	struct ds2760_device_info *di = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
@@ -508,6 +506,7 @@ static enum power_supply_property ds2760_battery_props[] = {
 
 static int ds2760_battery_probe(struct platform_device *pdev)
 {
+	struct power_supply_config psy_cfg = {};
 	char status;
 	int retval = 0;
 	struct ds2760_device_info *di;
@@ -520,20 +519,22 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, di);
 
-	di->dev			= &pdev->dev;
-	di->w1_dev		= pdev->dev.parent;
-	di->bat.name		= dev_name(&pdev->dev);
-	di->bat.type		= POWER_SUPPLY_TYPE_BATTERY;
-	di->bat.properties	= ds2760_battery_props;
-	di->bat.num_properties	= ARRAY_SIZE(ds2760_battery_props);
-	di->bat.get_property	= ds2760_battery_get_property;
-	di->bat.set_property	= ds2760_battery_set_property;
-	di->bat.property_is_writeable =
+	di->dev				= &pdev->dev;
+	di->w1_dev			= pdev->dev.parent;
+	di->bat_desc.name		= dev_name(&pdev->dev);
+	di->bat_desc.type		= POWER_SUPPLY_TYPE_BATTERY;
+	di->bat_desc.properties		= ds2760_battery_props;
+	di->bat_desc.num_properties	= ARRAY_SIZE(ds2760_battery_props);
+	di->bat_desc.get_property	= ds2760_battery_get_property;
+	di->bat_desc.set_property	= ds2760_battery_set_property;
+	di->bat_desc.property_is_writeable =
 				  ds2760_battery_property_is_writeable;
-	di->bat.set_charged	= ds2760_battery_set_charged;
-	di->bat.external_power_changed =
+	di->bat_desc.set_charged	= ds2760_battery_set_charged;
+	di->bat_desc.external_power_changed =
 				  ds2760_battery_external_power_changed;
 
+	psy_cfg.drv_data		= di;
+
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
 
 	/* enable sleep mode feature */
@@ -555,9 +556,10 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	if (current_accum)
 		ds2760_battery_set_current_accum(di, current_accum);
 
-	retval = power_supply_register(&pdev->dev, &di->bat, NULL);
-	if (retval) {
+	di->bat = power_supply_register(&pdev->dev, &di->bat_desc, &psy_cfg);
+	if (IS_ERR(di->bat)) {
 		dev_err(di->dev, "failed to register battery\n");
+		retval = PTR_ERR(di->bat);
 		goto batt_failed;
 	}
 
@@ -574,7 +576,7 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	goto success;
 
 workqueue_failed:
-	power_supply_unregister(&di->bat);
+	power_supply_unregister(di->bat);
 batt_failed:
 di_alloc_failed:
 success:
@@ -588,7 +590,7 @@ static int ds2760_battery_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&di->monitor_work);
 	cancel_delayed_work_sync(&di->set_charged_work);
 	destroy_workqueue(di->monitor_wqueue);
-	power_supply_unregister(&di->bat);
+	power_supply_unregister(di->bat);
 
 	return 0;
 }
@@ -610,7 +612,7 @@ static int ds2760_battery_resume(struct platform_device *pdev)
 	struct ds2760_device_info *di = platform_get_drvdata(pdev);
 
 	di->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
-	power_supply_changed(&di->bat);
+	power_supply_changed(di->bat);
 
 	mod_delayed_work(di->monitor_wqueue, &di->monitor_work, HZ);
 
diff --git a/drivers/power/ds2780_battery.c b/drivers/power/ds2780_battery.c
index b1d3570ea730..a7a0427343f3 100644
--- a/drivers/power/ds2780_battery.c
+++ b/drivers/power/ds2780_battery.c
@@ -37,7 +37,8 @@
 
 struct ds2780_device_info {
 	struct device *dev;
-	struct power_supply bat;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
 	struct device *w1_dev;
 };
 
@@ -52,7 +53,7 @@ static const char manufacturer[] = "Maxim/Dallas";
 static inline struct ds2780_device_info *
 to_ds2780_device_info(struct power_supply *psy)
 {
-	return container_of(psy, struct ds2780_device_info, bat);
+	return power_supply_get_drvdata(psy);
 }
 
 static inline struct power_supply *to_power_supply(struct device *dev)
@@ -757,6 +758,7 @@ static const struct attribute_group ds2780_attr_group = {
 
 static int ds2780_battery_probe(struct platform_device *pdev)
 {
+	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 	struct ds2780_device_info *dev_info;
 
@@ -770,25 +772,29 @@ static int ds2780_battery_probe(struct platform_device *pdev)
 
 	dev_info->dev			= &pdev->dev;
 	dev_info->w1_dev		= pdev->dev.parent;
-	dev_info->bat.name		= dev_name(&pdev->dev);
-	dev_info->bat.type		= POWER_SUPPLY_TYPE_BATTERY;
-	dev_info->bat.properties	= ds2780_battery_props;
-	dev_info->bat.num_properties	= ARRAY_SIZE(ds2780_battery_props);
-	dev_info->bat.get_property	= ds2780_battery_get_property;
+	dev_info->bat_desc.name		= dev_name(&pdev->dev);
+	dev_info->bat_desc.type		= POWER_SUPPLY_TYPE_BATTERY;
+	dev_info->bat_desc.properties	= ds2780_battery_props;
+	dev_info->bat_desc.num_properties = ARRAY_SIZE(ds2780_battery_props);
+	dev_info->bat_desc.get_property	= ds2780_battery_get_property;
 
-	ret = power_supply_register(&pdev->dev, &dev_info->bat, NULL);
-	if (ret) {
+	psy_cfg.drv_data		= dev_info;
+
+	dev_info->bat = power_supply_register(&pdev->dev, &dev_info->bat_desc,
+					      &psy_cfg);
+	if (IS_ERR(dev_info->bat)) {
 		dev_err(dev_info->dev, "failed to register battery\n");
+		ret = PTR_ERR(dev_info->bat);
 		goto fail;
 	}
 
-	ret = sysfs_create_group(&dev_info->bat.dev->kobj, &ds2780_attr_group);
+	ret = sysfs_create_group(&dev_info->bat->dev.kobj, &ds2780_attr_group);
 	if (ret) {
 		dev_err(dev_info->dev, "failed to create sysfs group\n");
 		goto fail_unregister;
 	}
 
-	ret = sysfs_create_bin_file(&dev_info->bat.dev->kobj,
+	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
 					&ds2780_param_eeprom_bin_attr);
 	if (ret) {
 		dev_err(dev_info->dev,
@@ -796,7 +802,7 @@ static int ds2780_battery_probe(struct platform_device *pdev)
 		goto fail_remove_group;
 	}
 
-	ret = sysfs_create_bin_file(&dev_info->bat.dev->kobj,
+	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
 					&ds2780_user_eeprom_bin_attr);
 	if (ret) {
 		dev_err(dev_info->dev,
@@ -807,12 +813,12 @@ static int ds2780_battery_probe(struct platform_device *pdev)
 	return 0;
 
 fail_remove_bin_file:
-	sysfs_remove_bin_file(&dev_info->bat.dev->kobj,
+	sysfs_remove_bin_file(&dev_info->bat->dev.kobj,
 				&ds2780_param_eeprom_bin_attr);
 fail_remove_group:
-	sysfs_remove_group(&dev_info->bat.dev->kobj, &ds2780_attr_group);
+	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2780_attr_group);
 fail_unregister:
-	power_supply_unregister(&dev_info->bat);
+	power_supply_unregister(dev_info->bat);
 fail:
 	return ret;
 }
@@ -821,10 +827,13 @@ static int ds2780_battery_remove(struct platform_device *pdev)
 {
 	struct ds2780_device_info *dev_info = platform_get_drvdata(pdev);
 
-	/* remove attributes */
-	sysfs_remove_group(&dev_info->bat.dev->kobj, &ds2780_attr_group);
+	/*
+	 * Remove attributes before unregistering power supply
+	 * because 'bat' will be freed on power_supply_unregister() call.
+	 */
+	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2780_attr_group);
 
-	power_supply_unregister(&dev_info->bat);
+	power_supply_unregister(dev_info->bat);
 
 	return 0;
 }
diff --git a/drivers/power/ds2781_battery.c b/drivers/power/ds2781_battery.c
index 50686dc59711..56d583dae908 100644
--- a/drivers/power/ds2781_battery.c
+++ b/drivers/power/ds2781_battery.c
@@ -35,7 +35,8 @@
 
 struct ds2781_device_info {
 	struct device *dev;
-	struct power_supply bat;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
 	struct device *w1_dev;
 };
 
@@ -50,7 +51,7 @@ static const char manufacturer[] = "Maxim/Dallas";
 static inline struct ds2781_device_info *
 to_ds2781_device_info(struct power_supply *psy)
 {
-	return container_of(psy, struct ds2781_device_info, bat);
+	return power_supply_get_drvdata(psy);
 }
 
 static inline struct power_supply *to_power_supply(struct device *dev)
@@ -328,7 +329,7 @@ static int ds2781_get_status(struct ds2781_device_info *dev_info, int *status)
 	if (ret < 0)
 		return ret;
 
-	if (power_supply_am_i_supplied(&dev_info->bat)) {
+	if (power_supply_am_i_supplied(dev_info->bat)) {
 		if (capacity == 100)
 			*status = POWER_SUPPLY_STATUS_FULL;
 		else if (current_uA > 50000)
@@ -752,6 +753,7 @@ static const struct attribute_group ds2781_attr_group = {
 
 static int ds2781_battery_probe(struct platform_device *pdev)
 {
+	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 	struct ds2781_device_info *dev_info;
 
@@ -763,25 +765,29 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 
 	dev_info->dev			= &pdev->dev;
 	dev_info->w1_dev		= pdev->dev.parent;
-	dev_info->bat.name		= dev_name(&pdev->dev);
-	dev_info->bat.type		= POWER_SUPPLY_TYPE_BATTERY;
-	dev_info->bat.properties	= ds2781_battery_props;
-	dev_info->bat.num_properties	= ARRAY_SIZE(ds2781_battery_props);
-	dev_info->bat.get_property	= ds2781_battery_get_property;
+	dev_info->bat_desc.name		= dev_name(&pdev->dev);
+	dev_info->bat_desc.type		= POWER_SUPPLY_TYPE_BATTERY;
+	dev_info->bat_desc.properties	= ds2781_battery_props;
+	dev_info->bat_desc.num_properties = ARRAY_SIZE(ds2781_battery_props);
+	dev_info->bat_desc.get_property	= ds2781_battery_get_property;
 
-	ret = power_supply_register(&pdev->dev, &dev_info->bat, NULL);
-	if (ret) {
+	psy_cfg.drv_data		= dev_info;
+
+	dev_info->bat = power_supply_register(&pdev->dev, &dev_info->bat_desc,
+						&psy_cfg);
+	if (IS_ERR(dev_info->bat)) {
 		dev_err(dev_info->dev, "failed to register battery\n");
+		ret = PTR_ERR(dev_info->bat);
 		goto fail;
 	}
 
-	ret = sysfs_create_group(&dev_info->bat.dev->kobj, &ds2781_attr_group);
+	ret = sysfs_create_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
 	if (ret) {
 		dev_err(dev_info->dev, "failed to create sysfs group\n");
 		goto fail_unregister;
 	}
 
-	ret = sysfs_create_bin_file(&dev_info->bat.dev->kobj,
+	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
 					&ds2781_param_eeprom_bin_attr);
 	if (ret) {
 		dev_err(dev_info->dev,
@@ -789,7 +795,7 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 		goto fail_remove_group;
 	}
 
-	ret = sysfs_create_bin_file(&dev_info->bat.dev->kobj,
+	ret = sysfs_create_bin_file(&dev_info->bat->dev.kobj,
 					&ds2781_user_eeprom_bin_attr);
 	if (ret) {
 		dev_err(dev_info->dev,
@@ -800,12 +806,12 @@ static int ds2781_battery_probe(struct platform_device *pdev)
 	return 0;
 
 fail_remove_bin_file:
-	sysfs_remove_bin_file(&dev_info->bat.dev->kobj,
+	sysfs_remove_bin_file(&dev_info->bat->dev.kobj,
 				&ds2781_param_eeprom_bin_attr);
 fail_remove_group:
-	sysfs_remove_group(&dev_info->bat.dev->kobj, &ds2781_attr_group);
+	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
 fail_unregister:
-	power_supply_unregister(&dev_info->bat);
+	power_supply_unregister(dev_info->bat);
 fail:
 	return ret;
 }
@@ -814,10 +820,13 @@ static int ds2781_battery_remove(struct platform_device *pdev)
 {
 	struct ds2781_device_info *dev_info = platform_get_drvdata(pdev);
 
-	/* remove attributes */
-	sysfs_remove_group(&dev_info->bat.dev->kobj, &ds2781_attr_group);
+	/*
+	 * Remove attributes before unregistering power supply
+	 * because 'bat' will be freed on power_supply_unregister() call.
+	 */
+	sysfs_remove_group(&dev_info->bat->dev.kobj, &ds2781_attr_group);
 
-	power_supply_unregister(&dev_info->bat);
+	power_supply_unregister(dev_info->bat);
 
 	return 0;
 }
diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_battery.c
index 2dcb96a83cee..ed4d756d21e4 100644
--- a/drivers/power/ds2782_battery.c
+++ b/drivers/power/ds2782_battery.c
@@ -53,11 +53,12 @@ struct ds278x_battery_ops {
 	int (*get_battery_capacity)(struct ds278x_info *info, int *capacity);
 };
 
-#define to_ds278x_info(x) container_of(x, struct ds278x_info, battery)
+#define to_ds278x_info(x) power_supply_get_drvdata(x)
 
 struct ds278x_info {
 	struct i2c_client	*client;
-	struct power_supply	battery;
+	struct power_supply	*battery;
+	struct power_supply_desc	battery_desc;
 	struct ds278x_battery_ops  *ops;
 	struct delayed_work	bat_work;
 	int			id;
@@ -285,7 +286,7 @@ static void ds278x_bat_update(struct ds278x_info *info)
 	ds278x_get_status(info, &info->status);
 
 	if ((old_status != info->status) || (old_capacity != info->capacity))
-		power_supply_changed(&info->battery);
+		power_supply_changed(info->battery);
 }
 
 static void ds278x_bat_work(struct work_struct *work)
@@ -306,7 +307,7 @@ static enum power_supply_property ds278x_battery_props[] = {
 	POWER_SUPPLY_PROP_TEMP,
 };
 
-static void ds278x_power_supply_init(struct power_supply *battery)
+static void ds278x_power_supply_init(struct power_supply_desc *battery)
 {
 	battery->type			= POWER_SUPPLY_TYPE_BATTERY;
 	battery->properties		= ds278x_battery_props;
@@ -319,8 +320,8 @@ static int ds278x_battery_remove(struct i2c_client *client)
 {
 	struct ds278x_info *info = i2c_get_clientdata(client);
 
-	power_supply_unregister(&info->battery);
-	kfree(info->battery.name);
+	power_supply_unregister(info->battery);
+	kfree(info->battery_desc.name);
 
 	mutex_lock(&battery_lock);
 	idr_remove(&battery_id, info->id);
@@ -377,6 +378,7 @@ static int ds278x_battery_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct ds278x_platform_data *pdata = client->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct ds278x_info *info;
 	int ret;
 	int num;
@@ -404,8 +406,9 @@ static int ds278x_battery_probe(struct i2c_client *client,
 		goto fail_info;
 	}
 
-	info->battery.name = kasprintf(GFP_KERNEL, "%s-%d", client->name, num);
-	if (!info->battery.name) {
+	info->battery_desc.name = kasprintf(GFP_KERNEL, "%s-%d",
+					    client->name, num);
+	if (!info->battery_desc.name) {
 		ret = -ENOMEM;
 		goto fail_name;
 	}
@@ -417,16 +420,19 @@ static int ds278x_battery_probe(struct i2c_client *client,
 	info->client = client;
 	info->id = num;
 	info->ops  = &ds278x_ops[id->driver_data];
-	ds278x_power_supply_init(&info->battery);
+	ds278x_power_supply_init(&info->battery_desc);
+	psy_cfg.drv_data = info;
 
 	info->capacity = 100;
 	info->status = POWER_SUPPLY_STATUS_FULL;
 
 	INIT_DELAYED_WORK(&info->bat_work, ds278x_bat_work);
 
-	ret = power_supply_register(&client->dev, &info->battery, NULL);
-	if (ret) {
+	info->battery = power_supply_register(&client->dev,
+					      &info->battery_desc, &psy_cfg);
+	if (IS_ERR(info->battery)) {
 		dev_err(&client->dev, "failed to register battery\n");
+		ret = PTR_ERR(info->battery);
 		goto fail_register;
 	} else {
 		schedule_delayed_work(&info->bat_work, DS278x_DELAY);
@@ -435,7 +441,7 @@ static int ds278x_battery_probe(struct i2c_client *client,
 	return 0;
 
 fail_register:
-	kfree(info->battery.name);
+	kfree(info->battery_desc.name);
 fail_name:
 	kfree(info);
 fail_info:
diff --git a/drivers/power/generic-adc-battery.c b/drivers/power/generic-adc-battery.c
index 8ddbcffdb7f6..70f8e214e6cd 100644
--- a/drivers/power/generic-adc-battery.c
+++ b/drivers/power/generic-adc-battery.c
@@ -44,7 +44,8 @@ static const char *const gab_chan_name[] = {
 };
 
 struct gab {
-	struct power_supply	psy;
+	struct power_supply		*psy;
+	struct power_supply_desc	psy_desc;
 	struct iio_channel	*channel[GAB_MAX_CHAN_TYPE];
 	struct gab_platform_data	*pdata;
 	struct delayed_work bat_work;
@@ -55,7 +56,7 @@ struct gab {
 
 static struct gab *to_generic_bat(struct power_supply *psy)
 {
-	return container_of(psy, struct gab, psy);
+	return power_supply_get_drvdata(psy);
 }
 
 static void gab_ext_power_changed(struct power_supply *psy)
@@ -151,7 +152,7 @@ static int gab_get_property(struct power_supply *psy,
 
 	adc_bat = to_generic_bat(psy);
 	if (!adc_bat) {
-		dev_err(psy->dev, "no battery infos ?!\n");
+		dev_err(&psy->dev, "no battery infos ?!\n");
 		return -EINVAL;
 	}
 	pdata = adc_bat->pdata;
@@ -210,7 +211,7 @@ static void gab_work(struct work_struct *work)
 	pdata = adc_bat->pdata;
 	status = adc_bat->status;
 
-	is_plugged = power_supply_am_i_supplied(&adc_bat->psy);
+	is_plugged = power_supply_am_i_supplied(adc_bat->psy);
 	adc_bat->cable_plugged = is_plugged;
 
 	if (!is_plugged)
@@ -221,7 +222,7 @@ static void gab_work(struct work_struct *work)
 		adc_bat->status = POWER_SUPPLY_STATUS_CHARGING;
 
 	if (status != adc_bat->status)
-		power_supply_changed(&adc_bat->psy);
+		power_supply_changed(adc_bat->psy);
 }
 
 static irqreturn_t gab_charged(int irq, void *dev_id)
@@ -239,7 +240,8 @@ static irqreturn_t gab_charged(int irq, void *dev_id)
 static int gab_probe(struct platform_device *pdev)
 {
 	struct gab *adc_bat;
-	struct power_supply *psy;
+	struct power_supply_desc *psy_desc;
+	struct power_supply_config psy_cfg = {};
 	struct gab_platform_data *pdata = pdev->dev.platform_data;
 	enum power_supply_property *properties;
 	int ret = 0;
@@ -252,32 +254,34 @@ static int gab_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	psy = &adc_bat->psy;
-	psy->name = pdata->battery_info.name;
+	psy_cfg.drv_data = adc_bat;
+	psy_desc = &adc_bat->psy_desc;
+	psy_desc->name = pdata->battery_info.name;
 
 	/* bootup default values for the battery */
 	adc_bat->cable_plugged = false;
 	adc_bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
-	psy->type = POWER_SUPPLY_TYPE_BATTERY;
-	psy->get_property = gab_get_property;
-	psy->external_power_changed = gab_ext_power_changed;
+	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	psy_desc->get_property = gab_get_property;
+	psy_desc->external_power_changed = gab_ext_power_changed;
 	adc_bat->pdata = pdata;
 
 	/*
 	 * copying the static properties and allocating extra memory for holding
 	 * the extra configurable properties received from platform data.
 	 */
-	psy->properties = kcalloc(ARRAY_SIZE(gab_props) +
+	psy_desc->properties = kcalloc(ARRAY_SIZE(gab_props) +
 					ARRAY_SIZE(gab_chan_name),
-					sizeof(*psy->properties), GFP_KERNEL);
-	if (!psy->properties) {
+					sizeof(*psy_desc->properties),
+					GFP_KERNEL);
+	if (!psy_desc->properties) {
 		ret = -ENOMEM;
 		goto first_mem_fail;
 	}
 
-	memcpy(psy->properties, gab_props, sizeof(gab_props));
+	memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
 	properties = (enum power_supply_property *)
-				((char *)psy->properties + sizeof(gab_props));
+			((char *)psy_desc->properties + sizeof(gab_props));
 
 	/*
 	 * getting channel from iio and copying the battery properties
@@ -291,7 +295,7 @@ static int gab_probe(struct platform_device *pdev)
 			adc_bat->channel[chan] = NULL;
 		} else {
 			/* copying properties for supported channels only */
-			memcpy(properties + sizeof(*(psy->properties)) * index,
+			memcpy(properties + sizeof(*(psy_desc->properties)) * index,
 					&gab_dyn_props[chan],
 					sizeof(gab_dyn_props[chan]));
 			index++;
@@ -310,11 +314,13 @@ static int gab_probe(struct platform_device *pdev)
 	 * as come channels may be not be supported by the device.So
 	 * we need to take care of that.
 	 */
-	psy->num_properties = ARRAY_SIZE(gab_props) + index;
+	psy_desc->num_properties = ARRAY_SIZE(gab_props) + index;
 
-	ret = power_supply_register(&pdev->dev, psy, NULL);
-	if (ret)
+	adc_bat->psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(adc_bat->psy)) {
+		ret = PTR_ERR(adc_bat->psy);
 		goto err_reg_fail;
+	}
 
 	INIT_DELAYED_WORK(&adc_bat->bat_work, gab_work);
 
@@ -342,14 +348,14 @@ static int gab_probe(struct platform_device *pdev)
 err_gpio:
 	gpio_free(pdata->gpio_charge_finished);
 gpio_req_fail:
-	power_supply_unregister(psy);
+	power_supply_unregister(adc_bat->psy);
 err_reg_fail:
 	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
 		if (adc_bat->channel[chan])
 			iio_channel_release(adc_bat->channel[chan]);
 	}
 second_mem_fail:
-	kfree(psy->properties);
+	kfree(psy_desc->properties);
 first_mem_fail:
 	return ret;
 }
@@ -360,7 +366,7 @@ static int gab_remove(struct platform_device *pdev)
 	struct gab *adc_bat = platform_get_drvdata(pdev);
 	struct gab_platform_data *pdata = adc_bat->pdata;
 
-	power_supply_unregister(&adc_bat->psy);
+	power_supply_unregister(adc_bat->psy);
 
 	if (gpio_is_valid(pdata->gpio_charge_finished)) {
 		free_irq(gpio_to_irq(pdata->gpio_charge_finished), adc_bat);
@@ -372,7 +378,7 @@ static int gab_remove(struct platform_device *pdev)
 			iio_channel_release(adc_bat->channel[chan]);
 	}
 
-	kfree(adc_bat->psy.properties);
+	kfree(adc_bat->psy_desc.properties);
 	cancel_delayed_work(&adc_bat->bat_work);
 	return 0;
 }
diff --git a/drivers/power/goldfish_battery.c b/drivers/power/goldfish_battery.c
index 61d437f8cf76..a50bb988c69a 100644
--- a/drivers/power/goldfish_battery.c
+++ b/drivers/power/goldfish_battery.c
@@ -30,8 +30,8 @@ struct goldfish_battery_data {
 	int irq;
 	spinlock_t lock;
 
-	struct power_supply battery;
-	struct power_supply ac;
+	struct power_supply *battery;
+	struct power_supply *ac;
 };
 
 #define GOLDFISH_BATTERY_READ(data, addr) \
@@ -67,8 +67,7 @@ static int goldfish_ac_get_property(struct power_supply *psy,
 			enum power_supply_property psp,
 			union power_supply_propval *val)
 {
-	struct goldfish_battery_data *data = container_of(psy,
-		struct goldfish_battery_data, ac);
+	struct goldfish_battery_data *data = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
@@ -86,8 +85,7 @@ static int goldfish_battery_get_property(struct power_supply *psy,
 				 enum power_supply_property psp,
 				 union power_supply_propval *val)
 {
-	struct goldfish_battery_data *data = container_of(psy,
-		struct goldfish_battery_data, battery);
+	struct goldfish_battery_data *data = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
@@ -139,20 +137,36 @@ static irqreturn_t goldfish_battery_interrupt(int irq, void *dev_id)
 	status &= BATTERY_INT_MASK;
 
 	if (status & BATTERY_STATUS_CHANGED)
-		power_supply_changed(&data->battery);
+		power_supply_changed(data->battery);
 	if (status & AC_STATUS_CHANGED)
-		power_supply_changed(&data->ac);
+		power_supply_changed(data->ac);
 
 	spin_unlock_irqrestore(&data->lock, irq_flags);
 	return status ? IRQ_HANDLED : IRQ_NONE;
 }
 
+static const struct power_supply_desc battery_desc = {
+	.properties	= goldfish_battery_props,
+	.num_properties	= ARRAY_SIZE(goldfish_battery_props),
+	.get_property	= goldfish_battery_get_property,
+	.name		= "battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+};
+
+static const struct power_supply_desc ac_desc = {
+	.properties	= goldfish_ac_props,
+	.num_properties	= ARRAY_SIZE(goldfish_ac_props),
+	.get_property	= goldfish_ac_get_property,
+	.name		= "ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+};
 
 static int goldfish_battery_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *r;
 	struct goldfish_battery_data *data;
+	struct power_supply_config psy_cfg = {};
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
@@ -160,18 +174,6 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 
 	spin_lock_init(&data->lock);
 
-	data->battery.properties = goldfish_battery_props;
-	data->battery.num_properties = ARRAY_SIZE(goldfish_battery_props);
-	data->battery.get_property = goldfish_battery_get_property;
-	data->battery.name = "battery";
-	data->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-
-	data->ac.properties = goldfish_ac_props;
-	data->ac.num_properties = ARRAY_SIZE(goldfish_ac_props);
-	data->ac.get_property = goldfish_ac_get_property;
-	data->ac.name = "ac";
-	data->ac.type = POWER_SUPPLY_TYPE_MAINS;
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "platform_get_resource failed\n");
@@ -195,14 +197,17 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = power_supply_register(&pdev->dev, &data->ac, NULL);
-	if (ret)
-		return ret;
+	psy_cfg.drv_data = data;
 
-	ret = power_supply_register(&pdev->dev, &data->battery, NULL);
-	if (ret) {
-		power_supply_unregister(&data->ac);
-		return ret;
+	data->ac = power_supply_register(&pdev->dev, &ac_desc, &psy_cfg);
+	if (IS_ERR(data->ac))
+		return PTR_ERR(data->ac);
+
+	data->battery = power_supply_register(&pdev->dev, &battery_desc,
+						&psy_cfg);
+	if (IS_ERR(data->battery)) {
+		power_supply_unregister(data->ac);
+		return PTR_ERR(data->battery);
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -216,8 +221,8 @@ static int goldfish_battery_remove(struct platform_device *pdev)
 {
 	struct goldfish_battery_data *data = platform_get_drvdata(pdev);
 
-	power_supply_unregister(&data->battery);
-	power_supply_unregister(&data->ac);
+	power_supply_unregister(data->battery);
+	power_supply_unregister(data->ac);
 	battery_data = NULL;
 	return 0;
 }
diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index 47a9e2bd94d9..c5869b1941ac 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -32,7 +32,8 @@ struct gpio_charger {
 	unsigned int irq;
 	bool wakeup_enabled;
 
-	struct power_supply charger;
+	struct power_supply *charger;
+	struct power_supply_desc charger_desc;
 };
 
 static irqreturn_t gpio_charger_irq(int irq, void *devid)
@@ -46,7 +47,7 @@ static irqreturn_t gpio_charger_irq(int irq, void *devid)
 
 static inline struct gpio_charger *psy_to_gpio_charger(struct power_supply *psy)
 {
-	return container_of(psy, struct gpio_charger, charger);
+	return power_supply_get_drvdata(psy);
 }
 
 static int gpio_charger_get_property(struct power_supply *psy,
@@ -129,7 +130,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	const struct gpio_charger_platform_data *pdata = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
 	struct gpio_charger *gpio_charger;
-	struct power_supply *charger;
+	struct power_supply_desc *charger_desc;
 	int ret;
 	int irq;
 
@@ -155,17 +156,18 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	charger = &gpio_charger->charger;
+	charger_desc = &gpio_charger->charger_desc;
 
-	charger->name = pdata->name ? pdata->name : "gpio-charger";
-	charger->type = pdata->type;
-	charger->properties = gpio_charger_properties;
-	charger->num_properties = ARRAY_SIZE(gpio_charger_properties);
-	charger->get_property = gpio_charger_get_property;
+	charger_desc->name = pdata->name ? pdata->name : "gpio-charger";
+	charger_desc->type = pdata->type;
+	charger_desc->properties = gpio_charger_properties;
+	charger_desc->num_properties = ARRAY_SIZE(gpio_charger_properties);
+	charger_desc->get_property = gpio_charger_get_property;
 
 	psy_cfg.supplied_to = pdata->supplied_to;
 	psy_cfg.num_supplicants = pdata->num_supplicants;
 	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = gpio_charger;
 
 	ret = gpio_request(pdata->gpio, dev_name(&pdev->dev));
 	if (ret) {
@@ -180,8 +182,10 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	gpio_charger->pdata = pdata;
 
-	ret = power_supply_register(&pdev->dev, charger, &psy_cfg);
-	if (ret < 0) {
+	gpio_charger->charger = power_supply_register(&pdev->dev,
+						      charger_desc, &psy_cfg);
+	if (IS_ERR(gpio_charger->charger)) {
+		ret = PTR_ERR(gpio_charger->charger);
 		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
 			ret);
 		goto err_gpio_free;
@@ -191,7 +195,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		ret = request_any_context_irq(irq, gpio_charger_irq,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), charger);
+				dev_name(&pdev->dev), gpio_charger->charger);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "Failed to request irq: %d\n", ret);
 		else
@@ -215,9 +219,9 @@ static int gpio_charger_remove(struct platform_device *pdev)
 	struct gpio_charger *gpio_charger = platform_get_drvdata(pdev);
 
 	if (gpio_charger->irq)
-		free_irq(gpio_charger->irq, &gpio_charger->charger);
+		free_irq(gpio_charger->irq, gpio_charger->charger);
 
-	power_supply_unregister(&gpio_charger->charger);
+	power_supply_unregister(gpio_charger->charger);
 
 	gpio_free(gpio_charger->pdata->gpio);
 
@@ -243,7 +247,7 @@ static int gpio_charger_resume(struct device *dev)
 
 	if (device_may_wakeup(dev) && gpio_charger->wakeup_enabled)
 		disable_irq_wake(gpio_charger->irq);
-	power_supply_changed(&gpio_charger->charger);
+	power_supply_changed(gpio_charger->charger);
 
 	return 0;
 }
diff --git a/drivers/power/intel_mid_battery.c b/drivers/power/intel_mid_battery.c
index 8a149657cd71..9fa4acc107ca 100644
--- a/drivers/power/intel_mid_battery.c
+++ b/drivers/power/intel_mid_battery.c
@@ -107,8 +107,8 @@ struct pmic_power_module_info {
 	unsigned int batt_prev_charge_full;	/* in mAS */
 	unsigned int batt_charge_rate;		/* in units per second */
 
-	struct power_supply usb;
-	struct power_supply batt;
+	struct power_supply *usb;
+	struct power_supply *batt;
 	int irq;				/* GPE_ID or IRQ# */
 	struct workqueue_struct *monitor_wqueue;
 	struct delayed_work monitor_battery;
@@ -404,8 +404,7 @@ static int pmic_usb_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct pmic_power_module_info *pbi = container_of(psy,
-				struct pmic_power_module_info, usb);
+	struct pmic_power_module_info *pbi = power_supply_get_drvdata(psy);
 
 	/* update pmic_power_module_info members */
 	pmic_battery_read_status(pbi);
@@ -444,8 +443,7 @@ static int pmic_battery_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct pmic_power_module_info *pbi = container_of(psy,
-				struct pmic_power_module_info, batt);
+	struct pmic_power_module_info *pbi = power_supply_get_drvdata(psy);
 
 	/* update pmic_power_module_info members */
 	pmic_battery_read_status(pbi);
@@ -640,6 +638,25 @@ static void pmic_battery_handle_intrpt(struct work_struct *work)
 			__func__);
 }
 
+/*
+ * Description of power supplies
+ */
+static const struct power_supply_desc pmic_usb_desc = {
+	.name		= "pmic-usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= pmic_usb_props,
+	.num_properties	= ARRAY_SIZE(pmic_usb_props),
+	.get_property	= pmic_usb_get_property,
+};
+
+static const struct power_supply_desc pmic_batt_desc = {
+	.name		= "pmic-batt",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= pmic_battery_props,
+	.num_properties	= ARRAY_SIZE(pmic_battery_props),
+	.get_property	= pmic_battery_get_property,
+};
+
 /**
  * pmic_battery_probe - pmic battery initialize
  * @irq: pmic battery device irq
@@ -653,6 +670,7 @@ static int probe(int irq, struct device *dev)
 {
 	int retval = 0;
 	struct pmic_power_module_info *pbi;
+	struct power_supply_config psy_cfg = {};
 
 	dev_dbg(dev, "pmic-battery: found pmic battery device\n");
 
@@ -666,6 +684,7 @@ static int probe(int irq, struct device *dev)
 	pbi->dev = dev;
 	pbi->irq = irq;
 	dev_set_drvdata(dev, pbi);
+	psy_cfg.drv_data = pbi;
 
 	/* initialize all required framework before enabling interrupts */
 	INIT_WORK(&pbi->handler, pmic_battery_handle_intrpt);
@@ -687,16 +706,12 @@ static int probe(int irq, struct device *dev)
 	}
 
 	/* register pmic-batt with power supply subsystem */
-	pbi->batt.name = "pmic-batt";
-	pbi->batt.type = POWER_SUPPLY_TYPE_BATTERY;
-	pbi->batt.properties = pmic_battery_props;
-	pbi->batt.num_properties = ARRAY_SIZE(pmic_battery_props);
-	pbi->batt.get_property = pmic_battery_get_property;
-	retval = power_supply_register(dev, &pbi->batt, NULL);
-	if (retval) {
+	pbi->batt = power_supply_register(dev, &pmic_usb_desc, &psy_cfg);
+	if (IS_ERR(pbi->batt)) {
 		dev_err(dev,
 			"%s(): failed to register pmic battery device with power supply subsystem\n",
 				__func__);
+		retval = PTR_ERR(pbi->batt);
 		goto power_reg_failed;
 	}
 
@@ -707,16 +722,12 @@ static int probe(int irq, struct device *dev)
 	queue_delayed_work(pbi->monitor_wqueue, &pbi->monitor_battery, HZ * 1);
 
 	/* register pmic-usb with power supply subsystem */
-	pbi->usb.name = "pmic-usb";
-	pbi->usb.type = POWER_SUPPLY_TYPE_USB;
-	pbi->usb.properties = pmic_usb_props;
-	pbi->usb.num_properties = ARRAY_SIZE(pmic_usb_props);
-	pbi->usb.get_property = pmic_usb_get_property;
-	retval = power_supply_register(dev, &pbi->usb, NULL);
-	if (retval) {
+	pbi->usb = power_supply_register(dev, &pmic_batt_desc, &psy_cfg);
+	if (IS_ERR(pbi->usb)) {
 		dev_err(dev,
 			"%s(): failed to register pmic usb device with power supply subsystem\n",
 				__func__);
+		retval = PTR_ERR(pbi->usb);
 		goto power_reg_failed_1;
 	}
 
@@ -728,7 +739,7 @@ static int probe(int irq, struct device *dev)
 	return retval;
 
 power_reg_failed_1:
-	power_supply_unregister(&pbi->batt);
+	power_supply_unregister(pbi->batt);
 power_reg_failed:
 	cancel_delayed_work_sync(&pbi->monitor_battery);
 requestirq_failed:
@@ -762,8 +773,8 @@ static int platform_pmic_battery_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&pbi->monitor_battery);
 	destroy_workqueue(pbi->monitor_wqueue);
 
-	power_supply_unregister(&pbi->usb);
-	power_supply_unregister(&pbi->batt);
+	power_supply_unregister(pbi->usb);
+	power_supply_unregister(pbi->batt);
 
 	cancel_work_sync(&pbi->handler);
 	kfree(pbi);
diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/ipaq_micro_battery.c
index 842e7e2e1cb5..f03014ea1dc4 100644
--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -93,7 +93,7 @@ static void micro_battery_work(struct work_struct *work)
 
 static int get_capacity(struct power_supply *b)
 {
-	struct micro_battery *mb = dev_get_drvdata(b->dev->parent);
+	struct micro_battery *mb = dev_get_drvdata(b->dev.parent);
 
 	switch (mb->flag & 0x07) {
 	case MICRO_BATT_STATUS_HIGH:
@@ -113,7 +113,7 @@ static int get_capacity(struct power_supply *b)
 
 static int get_status(struct power_supply *b)
 {
-	struct micro_battery *mb = dev_get_drvdata(b->dev->parent);
+	struct micro_battery *mb = dev_get_drvdata(b->dev.parent);
 
 	if (mb->flag == MICRO_BATT_STATUS_UNKNOWN)
 		return POWER_SUPPLY_STATUS_UNKNOWN;
@@ -132,7 +132,7 @@ static int micro_batt_get_property(struct power_supply *b,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct micro_battery *mb = dev_get_drvdata(b->dev->parent);
+	struct micro_battery *mb = dev_get_drvdata(b->dev.parent);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
@@ -180,7 +180,7 @@ static int micro_ac_get_property(struct power_supply *b,
 				 enum power_supply_property psp,
 				 union power_supply_propval *val)
 {
-	struct micro_battery *mb = dev_get_drvdata(b->dev->parent);
+	struct micro_battery *mb = dev_get_drvdata(b->dev.parent);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -202,7 +202,7 @@ static enum power_supply_property micro_batt_power_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
 
-static struct power_supply micro_batt_power = {
+static const struct power_supply_desc micro_batt_power_desc = {
 	.name			= "main-battery",
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.properties		= micro_batt_power_props,
@@ -215,7 +215,7 @@ static enum power_supply_property micro_ac_power_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-static struct power_supply micro_ac_power = {
+static const struct power_supply_desc micro_ac_power_desc = {
 	.name			= "ac",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
 	.properties		= micro_ac_power_props,
@@ -223,6 +223,8 @@ static struct power_supply micro_ac_power = {
 	.get_property		= micro_ac_get_property,
 };
 
+static struct power_supply *micro_batt_power, *micro_ac_power;
+
 static int micro_batt_probe(struct platform_device *pdev)
 {
 	struct micro_battery *mb;
@@ -241,19 +243,25 @@ static int micro_batt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mb);
 	queue_delayed_work(mb->wq, &mb->update, 1);
 
-	ret = power_supply_register(&pdev->dev, &micro_batt_power, NULL);
-	if (ret < 0)
+	micro_batt_power = power_supply_register(&pdev->dev,
+						 &micro_batt_power_desc, NULL);
+	if (IS_ERR(micro_batt_power)) {
+		ret = PTR_ERR(micro_batt_power);
 		goto batt_err;
+	}
 
-	ret = power_supply_register(&pdev->dev, &micro_ac_power, NULL);
-	if (ret < 0)
+	micro_ac_power = power_supply_register(&pdev->dev,
+					       &micro_ac_power_desc, NULL);
+	if (IS_ERR(micro_ac_power)) {
+		ret = PTR_ERR(micro_ac_power);
 		goto ac_err;
+	}
 
 	dev_info(&pdev->dev, "iPAQ micro battery driver\n");
 	return 0;
 
 ac_err:
-	power_supply_unregister(&micro_ac_power);
+	power_supply_unregister(micro_ac_power);
 batt_err:
 	cancel_delayed_work_sync(&mb->update);
 	destroy_workqueue(mb->wq);
@@ -265,8 +273,8 @@ static int micro_batt_remove(struct platform_device *pdev)
 {
 	struct micro_battery *mb = platform_get_drvdata(pdev);
 
-	power_supply_unregister(&micro_ac_power);
-	power_supply_unregister(&micro_batt_power);
+	power_supply_unregister(micro_ac_power);
+	power_supply_unregister(micro_batt_power);
 	cancel_delayed_work_sync(&mb->update);
 	destroy_workqueue(mb->wq);
 
diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_charger.c
index 5521178bdc08..f2a7d970388f 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -57,11 +57,12 @@ static u16 isp170x_id[] = {
 };
 
 struct isp1704_charger {
-	struct device		*dev;
-	struct power_supply	psy;
-	struct usb_phy		*phy;
-	struct notifier_block	nb;
-	struct work_struct	work;
+	struct device			*dev;
+	struct power_supply		*psy;
+	struct power_supply_desc	psy_desc;
+	struct usb_phy			*phy;
+	struct notifier_block		nb;
+	struct work_struct		work;
 
 	/* properties */
 	char			model[8];
@@ -259,10 +260,10 @@ static void isp1704_charger_work(struct work_struct *data)
 
 			/* detect wall charger */
 			if (isp1704_charger_detect_dcp(isp)) {
-				isp->psy.type = POWER_SUPPLY_TYPE_USB_DCP;
+				isp->psy_desc.type = POWER_SUPPLY_TYPE_USB_DCP;
 				isp->current_max = 1800;
 			} else {
-				isp->psy.type = POWER_SUPPLY_TYPE_USB;
+				isp->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 				isp->current_max = 500;
 			}
 
@@ -271,7 +272,7 @@ static void isp1704_charger_work(struct work_struct *data)
 				usb_gadget_connect(isp->phy->otg->gadget);
 		}
 
-		if (isp->psy.type != POWER_SUPPLY_TYPE_USB_DCP) {
+		if (isp->psy_desc.type != POWER_SUPPLY_TYPE_USB_DCP) {
 			/*
 			 * Only 500mA here or high speed chirp
 			 * handshaking may break
@@ -280,14 +281,14 @@ static void isp1704_charger_work(struct work_struct *data)
 				isp->current_max = 500;
 
 			if (isp->current_max > 100)
-				isp->psy.type = POWER_SUPPLY_TYPE_USB_CDP;
+				isp->psy_desc.type = POWER_SUPPLY_TYPE_USB_CDP;
 		}
 		break;
 	case USB_EVENT_NONE:
 		isp->online = false;
 		isp->present = 0;
 		isp->current_max = 0;
-		isp->psy.type = POWER_SUPPLY_TYPE_USB;
+		isp->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 
 		/*
 		 * Disable data pullups. We need to prevent the controller from
@@ -306,7 +307,7 @@ static void isp1704_charger_work(struct work_struct *data)
 		goto out;
 	}
 
-	power_supply_changed(&isp->psy);
+	power_supply_changed(isp->psy);
 out:
 	mutex_unlock(&lock);
 }
@@ -326,8 +327,7 @@ static int isp1704_charger_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct isp1704_charger *isp =
-		container_of(psy, struct isp1704_charger, psy);
+	struct isp1704_charger *isp = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -403,6 +403,7 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 {
 	struct isp1704_charger	*isp;
 	int			ret = -ENODEV;
+	struct power_supply_config psy_cfg = {};
 
 	struct isp1704_charger_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
@@ -454,15 +455,19 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto fail1;
 
-	isp->psy.name		= "isp1704";
-	isp->psy.type		= POWER_SUPPLY_TYPE_USB;
-	isp->psy.properties	= power_props;
-	isp->psy.num_properties	= ARRAY_SIZE(power_props);
-	isp->psy.get_property	= isp1704_charger_get_property;
+	isp->psy_desc.name		= "isp1704";
+	isp->psy_desc.type		= POWER_SUPPLY_TYPE_USB;
+	isp->psy_desc.properties	= power_props;
+	isp->psy_desc.num_properties	= ARRAY_SIZE(power_props);
+	isp->psy_desc.get_property	= isp1704_charger_get_property;
 
-	ret = power_supply_register(isp->dev, &isp->psy, NULL);
-	if (ret)
+	psy_cfg.drv_data		= isp;
+
+	isp->psy = power_supply_register(isp->dev, &isp->psy_desc, &psy_cfg);
+	if (IS_ERR(isp->psy)) {
+		ret = PTR_ERR(isp->psy);
 		goto fail1;
+	}
 
 	/*
 	 * REVISIT: using work in order to allow the usb notifications to be
@@ -498,7 +503,7 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 
 	return 0;
 fail2:
-	power_supply_unregister(&isp->psy);
+	power_supply_unregister(isp->psy);
 fail1:
 	isp1704_charger_set_power(isp, 0);
 fail0:
@@ -512,7 +517,7 @@ static int isp1704_charger_remove(struct platform_device *pdev)
 	struct isp1704_charger *isp = platform_get_drvdata(pdev);
 
 	usb_unregister_notifier(isp->phy, &isp->nb);
-	power_supply_unregister(&isp->psy);
+	power_supply_unregister(isp->psy);
 	isp1704_charger_set_power(isp, 0);
 
 	return 0;
diff --git a/drivers/power/jz4740-battery.c b/drivers/power/jz4740-battery.c
index 0444434e1927..abdfc21ec13f 100644
--- a/drivers/power/jz4740-battery.c
+++ b/drivers/power/jz4740-battery.c
@@ -46,7 +46,8 @@ struct jz_battery {
 
 	struct completion read_completion;
 
-	struct power_supply battery;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	struct delayed_work work;
 
 	struct mutex lock;
@@ -54,7 +55,7 @@ struct jz_battery {
 
 static inline struct jz_battery *psy_to_jz_battery(struct power_supply *psy)
 {
-	return container_of(psy, struct jz_battery, battery);
+	return power_supply_get_drvdata(psy);
 }
 
 static irqreturn_t jz_battery_irq_handler(int irq, void *devid)
@@ -213,7 +214,7 @@ static void jz_battery_update(struct jz_battery *jz_battery)
 	}
 
 	if (has_changed)
-		power_supply_changed(&jz_battery->battery);
+		power_supply_changed(jz_battery->battery);
 }
 
 static enum power_supply_property jz_battery_properties[] = {
@@ -242,8 +243,9 @@ static int jz_battery_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct jz_battery_platform_data *pdata = pdev->dev.parent->platform_data;
+	struct power_supply_config psy_cfg = {};
 	struct jz_battery *jz_battery;
-	struct power_supply *battery;
+	struct power_supply_desc *battery_desc;
 	struct resource *mem;
 
 	if (!pdata) {
@@ -271,14 +273,17 @@ static int jz_battery_probe(struct platform_device *pdev)
 	if (IS_ERR(jz_battery->base))
 		return PTR_ERR(jz_battery->base);
 
-	battery = &jz_battery->battery;
-	battery->name = pdata->info.name;
-	battery->type = POWER_SUPPLY_TYPE_BATTERY;
-	battery->properties	= jz_battery_properties;
-	battery->num_properties	= ARRAY_SIZE(jz_battery_properties);
-	battery->get_property = jz_battery_get_property;
-	battery->external_power_changed = jz_battery_external_power_changed;
-	battery->use_for_apm = 1;
+	battery_desc = &jz_battery->battery_desc;
+	battery_desc->name = pdata->info.name;
+	battery_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	battery_desc->properties	= jz_battery_properties;
+	battery_desc->num_properties	= ARRAY_SIZE(jz_battery_properties);
+	battery_desc->get_property	= jz_battery_get_property;
+	battery_desc->external_power_changed =
+					jz_battery_external_power_changed;
+	battery_desc->use_for_apm	= 1;
+
+	psy_cfg.drv_data = jz_battery;
 
 	jz_battery->pdata = pdata;
 	jz_battery->pdev = pdev;
@@ -330,9 +335,11 @@ static int jz_battery_probe(struct platform_device *pdev)
 	else
 		jz4740_adc_set_config(pdev->dev.parent, JZ_ADC_CONFIG_BAT_MB, 0);
 
-	ret = power_supply_register(&pdev->dev, &jz_battery->battery, NULL);
-	if (ret) {
+	jz_battery->battery = power_supply_register(&pdev->dev, battery_desc,
+							&psy_cfg);
+	if (IS_ERR(jz_battery->battery)) {
 		dev_err(&pdev->dev, "power supply battery register failed.\n");
+		ret = PTR_ERR(jz_battery->battery);
 		goto err_free_charge_irq;
 	}
 
@@ -364,7 +371,7 @@ static int jz_battery_remove(struct platform_device *pdev)
 		gpio_free(jz_battery->pdata->gpio_charge);
 	}
 
-	power_supply_unregister(&jz_battery->battery);
+	power_supply_unregister(jz_battery->battery);
 
 	free_irq(jz_battery->irq, jz_battery);
 
diff --git a/drivers/power/lp8727_charger.c b/drivers/power/lp8727_charger.c
index 1f71af7a3811..7e741f1d3cd5 100644
--- a/drivers/power/lp8727_charger.c
+++ b/drivers/power/lp8727_charger.c
@@ -80,9 +80,9 @@ enum lp8727_die_temp {
 };
 
 struct lp8727_psy {
-	struct power_supply ac;
-	struct power_supply usb;
-	struct power_supply batt;
+	struct power_supply *ac;
+	struct power_supply *usb;
+	struct power_supply *batt;
 };
 
 struct lp8727_chg {
@@ -242,9 +242,9 @@ static void lp8727_delayed_func(struct work_struct *_work)
 	lp8727_id_detection(pchg, idno, vbus);
 	lp8727_enable_chgdet(pchg);
 
-	power_supply_changed(&pchg->psy->ac);
-	power_supply_changed(&pchg->psy->usb);
-	power_supply_changed(&pchg->psy->batt);
+	power_supply_changed(pchg->psy->ac);
+	power_supply_changed(pchg->psy->usb);
+	power_supply_changed(pchg->psy->batt);
 }
 
 static irqreturn_t lp8727_isr_func(int irq, void *ptr)
@@ -311,12 +311,12 @@ static int lp8727_charger_get_property(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       union power_supply_propval *val)
 {
-	struct lp8727_chg *pchg = dev_get_drvdata(psy->dev->parent);
+	struct lp8727_chg *pchg = dev_get_drvdata(psy->dev.parent);
 
 	if (psp != POWER_SUPPLY_PROP_ONLINE)
 		return -EINVAL;
 
-	val->intval = lp8727_is_charger_attached(psy->name, pchg->devid);
+	val->intval = lp8727_is_charger_attached(psy->desc->name, pchg->devid);
 
 	return 0;
 }
@@ -337,14 +337,14 @@ static int lp8727_battery_get_property(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       union power_supply_propval *val)
 {
-	struct lp8727_chg *pchg = dev_get_drvdata(psy->dev->parent);
+	struct lp8727_chg *pchg = dev_get_drvdata(psy->dev.parent);
 	struct lp8727_platform_data *pdata = pchg->pdata;
 	enum lp8727_die_temp temp;
 	u8 read;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (!lp8727_is_charger_attached(psy->name, pchg->devid)) {
+		if (!lp8727_is_charger_attached(psy->desc->name, pchg->devid)) {
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 			return 0;
 		}
@@ -400,13 +400,13 @@ static int lp8727_battery_get_property(struct power_supply *psy,
 
 static void lp8727_charger_changed(struct power_supply *psy)
 {
-	struct lp8727_chg *pchg = dev_get_drvdata(psy->dev->parent);
+	struct lp8727_chg *pchg = dev_get_drvdata(psy->dev.parent);
 	u8 eoc_level;
 	u8 ichg;
 	u8 val;
 
 	/* skip if no charger exists */
-	if (!lp8727_is_charger_attached(psy->name, pchg->devid))
+	if (!lp8727_is_charger_attached(psy->desc->name, pchg->devid))
 		return;
 
 	/* update charging parameters */
@@ -418,6 +418,31 @@ static void lp8727_charger_changed(struct power_supply *psy)
 	}
 }
 
+static const struct power_supply_desc lp8727_ac_desc = {
+	.name			= "ac",
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+	.properties		= lp8727_charger_prop,
+	.num_properties		= ARRAY_SIZE(lp8727_charger_prop),
+	.get_property		= lp8727_charger_get_property,
+};
+
+static const struct power_supply_desc lp8727_usb_desc = {
+	.name			= "usb",
+	.type			= POWER_SUPPLY_TYPE_USB,
+	.properties		= lp8727_charger_prop,
+	.num_properties		= ARRAY_SIZE(lp8727_charger_prop),
+	.get_property		= lp8727_charger_get_property,
+};
+
+static const struct power_supply_desc lp8727_batt_desc = {
+	.name			= "main_batt",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= lp8727_battery_prop,
+	.num_properties		= ARRAY_SIZE(lp8727_battery_prop),
+	.get_property		= lp8727_battery_get_property,
+	.external_power_changed	= lp8727_charger_changed,
+};
+
 static int lp8727_register_psy(struct lp8727_chg *pchg)
 {
 	struct power_supply_config psy_cfg = {}; /* Only for ac and usb */
@@ -432,40 +457,25 @@ static int lp8727_register_psy(struct lp8727_chg *pchg)
 	psy_cfg.supplied_to = battery_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	psy->ac.name = "ac";
-	psy->ac.type = POWER_SUPPLY_TYPE_MAINS;
-	psy->ac.properties = lp8727_charger_prop;
-	psy->ac.num_properties = ARRAY_SIZE(lp8727_charger_prop);
-	psy->ac.get_property = lp8727_charger_get_property;
-
-	if (power_supply_register(pchg->dev, &psy->ac, &psy_cfg))
+	psy->ac = power_supply_register(pchg->dev, &lp8727_ac_desc, &psy_cfg);
+	if (IS_ERR(psy->ac))
 		goto err_psy_ac;
 
-	psy->usb.name = "usb";
-	psy->usb.type = POWER_SUPPLY_TYPE_USB;
-	psy->usb.properties = lp8727_charger_prop;
-	psy->usb.num_properties = ARRAY_SIZE(lp8727_charger_prop);
-	psy->usb.get_property = lp8727_charger_get_property;
-
-	if (power_supply_register(pchg->dev, &psy->usb, &psy_cfg))
+	psy->usb = power_supply_register(pchg->dev, &lp8727_usb_desc,
+					 &psy_cfg);
+	if (IS_ERR(psy->usb))
 		goto err_psy_usb;
 
-	psy->batt.name = "main_batt";
-	psy->batt.type = POWER_SUPPLY_TYPE_BATTERY;
-	psy->batt.properties = lp8727_battery_prop;
-	psy->batt.num_properties = ARRAY_SIZE(lp8727_battery_prop);
-	psy->batt.get_property = lp8727_battery_get_property;
-	psy->batt.external_power_changed = lp8727_charger_changed;
-
-	if (power_supply_register(pchg->dev, &psy->batt, NULL))
+	psy->batt = power_supply_register(pchg->dev, &lp8727_batt_desc, NULL);
+	if (IS_ERR(psy->batt))
 		goto err_psy_batt;
 
 	return 0;
 
 err_psy_batt:
-	power_supply_unregister(&psy->usb);
+	power_supply_unregister(psy->usb);
 err_psy_usb:
-	power_supply_unregister(&psy->ac);
+	power_supply_unregister(psy->ac);
 err_psy_ac:
 	return -EPERM;
 }
@@ -477,9 +487,9 @@ static void lp8727_unregister_psy(struct lp8727_chg *pchg)
 	if (!psy)
 		return;
 
-	power_supply_unregister(&psy->ac);
-	power_supply_unregister(&psy->usb);
-	power_supply_unregister(&psy->batt);
+	power_supply_unregister(psy->ac);
+	power_supply_unregister(psy->usb);
+	power_supply_unregister(psy->batt);
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/power/lp8788-charger.c b/drivers/power/lp8788-charger.c
index 8e4d228519c1..f5a48fd68b01 100644
--- a/drivers/power/lp8788-charger.c
+++ b/drivers/power/lp8788-charger.c
@@ -105,8 +105,8 @@ struct lp8788_chg_irq {
  */
 struct lp8788_charger {
 	struct lp8788 *lp;
-	struct power_supply charger;
-	struct power_supply battery;
+	struct power_supply *charger;
+	struct power_supply *battery;
 	struct work_struct charger_work;
 	struct iio_channel *chan[LP8788_NUM_CHG_ADC];
 	struct lp8788_chg_irq irqs[LP8788_MAX_CHG_IRQS];
@@ -148,7 +148,7 @@ static int lp8788_charger_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct lp8788_charger *pchg = dev_get_drvdata(psy->dev->parent);
+	struct lp8788_charger *pchg = dev_get_drvdata(psy->dev.parent);
 	u8 read;
 
 	switch (psp) {
@@ -337,7 +337,7 @@ static int lp8788_battery_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct lp8788_charger *pchg = dev_get_drvdata(psy->dev->parent);
+	struct lp8788_charger *pchg = dev_get_drvdata(psy->dev.parent);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -397,31 +397,40 @@ static int lp8788_update_charger_params(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct power_supply_desc lp8788_psy_charger_desc = {
+	.name		= LP8788_CHARGER_NAME,
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= lp8788_charger_prop,
+	.num_properties	= ARRAY_SIZE(lp8788_charger_prop),
+	.get_property	= lp8788_charger_get_property,
+};
+
+static const struct power_supply_desc lp8788_psy_battery_desc = {
+	.name		= LP8788_BATTERY_NAME,
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= lp8788_battery_prop,
+	.num_properties	= ARRAY_SIZE(lp8788_battery_prop),
+	.get_property	= lp8788_battery_get_property,
+};
+
 static int lp8788_psy_register(struct platform_device *pdev,
 				struct lp8788_charger *pchg)
 {
 	struct power_supply_config charger_cfg = {};
 
-	pchg->charger.name = LP8788_CHARGER_NAME;
-	pchg->charger.type = POWER_SUPPLY_TYPE_MAINS;
-	pchg->charger.properties = lp8788_charger_prop;
-	pchg->charger.num_properties = ARRAY_SIZE(lp8788_charger_prop);
-	pchg->charger.get_property = lp8788_charger_get_property;
-
 	charger_cfg.supplied_to = battery_supplied_to;
 	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	if (power_supply_register(&pdev->dev, &pchg->charger, &charger_cfg))
+	pchg->charger = power_supply_register(&pdev->dev,
+					      &lp8788_psy_charger_desc,
+					      &charger_cfg);
+	if (IS_ERR(pchg->charger))
 		return -EPERM;
 
-	pchg->battery.name = LP8788_BATTERY_NAME;
-	pchg->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	pchg->battery.properties = lp8788_battery_prop;
-	pchg->battery.num_properties = ARRAY_SIZE(lp8788_battery_prop);
-	pchg->battery.get_property = lp8788_battery_get_property;
-
-	if (power_supply_register(&pdev->dev, &pchg->battery, NULL)) {
-		power_supply_unregister(&pchg->charger);
+	pchg->battery = power_supply_register(&pdev->dev,
+					      &lp8788_psy_battery_desc, NULL);
+	if (IS_ERR(pchg->battery)) {
+		power_supply_unregister(pchg->charger);
 		return -EPERM;
 	}
 
@@ -430,8 +439,8 @@ static int lp8788_psy_register(struct platform_device *pdev,
 
 static void lp8788_psy_unregister(struct lp8788_charger *pchg)
 {
-	power_supply_unregister(&pchg->battery);
-	power_supply_unregister(&pchg->charger);
+	power_supply_unregister(pchg->battery);
+	power_supply_unregister(pchg->charger);
 }
 
 static void lp8788_charger_event(struct work_struct *work)
@@ -475,8 +484,8 @@ static irqreturn_t lp8788_charger_irq_thread(int virq, void *ptr)
 	case LP8788_INT_EOC:
 	case LP8788_INT_BATT_LOW:
 	case LP8788_INT_NO_BATT:
-		power_supply_changed(&pchg->charger);
-		power_supply_changed(&pchg->battery);
+		power_supply_changed(pchg->charger);
+		power_supply_changed(pchg->battery);
 		break;
 	default:
 		break;
diff --git a/drivers/power/ltc2941-battery-gauge.c b/drivers/power/ltc2941-battery-gauge.c
index f9fab730bb24..3c15dbf8cc4b 100644
--- a/drivers/power/ltc2941-battery-gauge.c
+++ b/drivers/power/ltc2941-battery-gauge.c
@@ -59,7 +59,8 @@ enum ltc294x_reg {
 
 struct ltc294x_info {
 	struct i2c_client *client;	/* I2C Client pointer */
-	struct power_supply supply;	/* Supply pointer */
+	struct power_supply *supply;	/* Supply pointer */
+	struct power_supply_desc supply_desc;	/* Supply description */
 	struct delayed_work work;	/* Work scheduler */
 	int num_regs;	/* Number of registers (chip type) */
 	int id;		/* Identifier of ltc294x chip */
@@ -294,8 +295,7 @@ static int ltc294x_get_property(struct power_supply *psy,
 				enum power_supply_property prop,
 				union power_supply_propval *val)
 {
-	struct ltc294x_info *info =
-		container_of(psy, struct ltc294x_info, supply);
+	struct ltc294x_info *info = power_supply_get_drvdata(psy);
 
 	switch (prop) {
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
@@ -317,8 +317,7 @@ static int ltc294x_set_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	const union power_supply_propval *val)
 {
-	struct ltc294x_info *info =
-		container_of(psy, struct ltc294x_info, supply);
+	struct ltc294x_info *info = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
@@ -345,7 +344,7 @@ static void ltc294x_update(struct ltc294x_info *info)
 
 	if (charge != info->charge) {
 		info->charge = charge;
-		power_supply_changed(&info->supply);
+		power_supply_changed(info->supply);
 	}
 }
 
@@ -371,8 +370,8 @@ static int ltc294x_i2c_remove(struct i2c_client *client)
 	struct ltc294x_info *info = i2c_get_clientdata(client);
 
 	cancel_delayed_work(&info->work);
-	power_supply_unregister(&info->supply);
-	kfree(info->supply.name);
+	power_supply_unregister(info->supply);
+	kfree(info->supply_desc.name);
 	mutex_lock(&ltc294x_lock);
 	idr_remove(&ltc294x_id, info->id);
 	mutex_unlock(&ltc294x_lock);
@@ -382,6 +381,7 @@ static int ltc294x_i2c_remove(struct i2c_client *client)
 static int ltc294x_i2c_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
+	struct power_supply_config psy_cfg = {};
 	struct ltc294x_info *info;
 	int ret;
 	int num;
@@ -406,8 +406,9 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, info);
 
 	info->num_regs = id->driver_data;
-	info->supply.name = kasprintf(GFP_KERNEL, "%s-%d", client->name, num);
-	if (!info->supply.name) {
+	info->supply_desc.name = kasprintf(GFP_KERNEL, "%s-%d", client->name,
+					   num);
+	if (!info->supply_desc.name) {
 		ret = -ENOMEM;
 		goto fail_name;
 	}
@@ -446,24 +447,26 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 
 	info->client = client;
 	info->id = num;
-	info->supply.type = POWER_SUPPLY_TYPE_BATTERY;
-	info->supply.properties = ltc294x_properties;
+	info->supply_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	info->supply_desc.properties = ltc294x_properties;
 	if (info->num_regs >= LTC294X_REG_TEMPERATURE_LSB)
-		info->supply.num_properties =
+		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties);
 	else if (info->num_regs >= LTC294X_REG_CURRENT_LSB)
-		info->supply.num_properties =
+		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties) - 1;
 	else if (info->num_regs >= LTC294X_REG_VOLTAGE_LSB)
-		info->supply.num_properties =
+		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties) - 2;
 	else
-		info->supply.num_properties =
+		info->supply_desc.num_properties =
 			ARRAY_SIZE(ltc294x_properties) - 3;
-	info->supply.get_property = ltc294x_get_property;
-	info->supply.set_property = ltc294x_set_property;
-	info->supply.property_is_writeable = ltc294x_property_is_writeable;
-	info->supply.external_power_changed	= NULL;
+	info->supply_desc.get_property = ltc294x_get_property;
+	info->supply_desc.set_property = ltc294x_set_property;
+	info->supply_desc.property_is_writeable = ltc294x_property_is_writeable;
+	info->supply_desc.external_power_changed	= NULL;
+
+	psy_cfg.drv_data = info;
 
 	INIT_DELAYED_WORK(&info->work, ltc294x_work);
 
@@ -473,9 +476,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		goto fail_comm;
 	}
 
-	ret = power_supply_register(&client->dev, &info->supply, NULL);
-	if (ret) {
+	info->supply = power_supply_register(&client->dev, &info->supply_desc,
+					     &psy_cfg);
+	if (IS_ERR(info->supply)) {
 		dev_err(&client->dev, "failed to register ltc2941\n");
+		ret = PTR_ERR(info->supply);
 		goto fail_register;
 	} else {
 		schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
@@ -484,7 +489,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	return 0;
 
 fail_register:
-	kfree(info->supply.name);
+	kfree(info->supply_desc.name);
 fail_comm:
 fail_name:
 fail_info:
diff --git a/drivers/power/max14577_charger.c b/drivers/power/max14577_charger.c
index 8f113ed73e6c..70d601f82098 100644
--- a/drivers/power/max14577_charger.c
+++ b/drivers/power/max14577_charger.c
@@ -22,9 +22,9 @@
 #include <linux/mfd/max14577.h>
 
 struct max14577_charger {
-	struct device *dev;
-	struct max14577	*max14577;
-	struct power_supply	charger;
+	struct device		*dev;
+	struct max14577		*max14577;
+	struct power_supply	*charger;
 
 	unsigned int		charging_state;
 	unsigned int		battery_state;
@@ -389,9 +389,7 @@ static int max14577_charger_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	struct max14577_charger *chg = container_of(psy,
-						  struct max14577_charger,
-						  charger);
+	struct max14577_charger *chg = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
@@ -424,6 +422,14 @@ static int max14577_charger_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static const struct power_supply_desc max14577_charger_desc = {
+	.name = "max14577-charger",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = max14577_charger_props,
+	.num_properties = ARRAY_SIZE(max14577_charger_props),
+	.get_property = max14577_charger_get_property,
+};
+
 #ifdef CONFIG_OF
 static struct max14577_charger_platform_data *max14577_charger_dt_init(
 		struct platform_device *pdev)
@@ -531,6 +537,7 @@ static DEVICE_ATTR(fast_charge_timer, S_IRUGO | S_IWUSR,
 static int max14577_charger_probe(struct platform_device *pdev)
 {
 	struct max14577_charger *chg;
+	struct power_supply_config psy_cfg = {};
 	struct max14577 *max14577 = dev_get_drvdata(pdev->dev.parent);
 	int ret;
 
@@ -550,21 +557,18 @@ static int max14577_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	chg->charger.name = "max14577-charger",
-	chg->charger.type = POWER_SUPPLY_TYPE_BATTERY,
-	chg->charger.properties = max14577_charger_props,
-	chg->charger.num_properties = ARRAY_SIZE(max14577_charger_props),
-	chg->charger.get_property = max14577_charger_get_property,
-
 	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: create sysfs entry\n");
 		return ret;
 	}
 
-	ret = power_supply_register(&pdev->dev, &chg->charger, NULL);
-	if (ret) {
+	psy_cfg.drv_data = chg;
+	chg->charger = power_supply_register(&pdev->dev, &max14577_charger_desc,
+						&psy_cfg);
+	if (IS_ERR(chg->charger)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
+		ret = PTR_ERR(chg->charger);
 		goto err;
 	}
 
@@ -585,7 +589,7 @@ static int max14577_charger_remove(struct platform_device *pdev)
 	struct max14577_charger *chg = platform_get_drvdata(pdev);
 
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
-	power_supply_unregister(&chg->charger);
+	power_supply_unregister(chg->charger);
 
 	return 0;
 }
diff --git a/drivers/power/max17040_battery.c b/drivers/power/max17040_battery.c
index bf42c57a4247..2bfe4bbbc29a 100644
--- a/drivers/power/max17040_battery.c
+++ b/drivers/power/max17040_battery.c
@@ -40,7 +40,7 @@
 struct max17040_chip {
 	struct i2c_client		*client;
 	struct delayed_work		work;
-	struct power_supply		battery;
+	struct power_supply		*battery;
 	struct max17040_platform_data	*pdata;
 
 	/* State Of Connect */
@@ -57,8 +57,7 @@ static int max17040_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	struct max17040_chip *chip = container_of(psy,
-				struct max17040_chip, battery);
+	struct max17040_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -198,12 +197,20 @@ static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 };
 
+static const struct power_supply_desc max17040_battery_desc = {
+	.name		= "battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= max17040_get_property,
+	.properties	= max17040_battery_props,
+	.num_properties	= ARRAY_SIZE(max17040_battery_props),
+};
+
 static int max17040_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
-	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -216,17 +223,13 @@ static int max17040_probe(struct i2c_client *client,
 	chip->pdata = client->dev.platform_data;
 
 	i2c_set_clientdata(client, chip);
+	psy_cfg.drv_data = chip;
 
-	chip->battery.name		= "battery";
-	chip->battery.type		= POWER_SUPPLY_TYPE_BATTERY;
-	chip->battery.get_property	= max17040_get_property;
-	chip->battery.properties	= max17040_battery_props;
-	chip->battery.num_properties	= ARRAY_SIZE(max17040_battery_props);
-
-	ret = power_supply_register(&client->dev, &chip->battery, NULL);
-	if (ret) {
+	chip->battery = power_supply_register(&client->dev,
+				&max17040_battery_desc, &psy_cfg);
+	if (IS_ERR(chip->battery)) {
 		dev_err(&client->dev, "failed: power supply register\n");
-		return ret;
+		return PTR_ERR(chip->battery);
 	}
 
 	max17040_reset(client);
@@ -242,7 +245,7 @@ static int max17040_remove(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
-	power_supply_unregister(&chip->battery);
+	power_supply_unregister(chip->battery);
 	cancel_delayed_work(&chip->work);
 	return 0;
 }
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index c62d1428803e..40e7056d211e 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -69,7 +69,7 @@
 struct max17042_chip {
 	struct i2c_client *client;
 	struct regmap *regmap;
-	struct power_supply battery;
+	struct power_supply *battery;
 	enum max170xx_chip_type chip_type;
 	struct max17042_platform_data *pdata;
 	struct work_struct work;
@@ -96,8 +96,7 @@ static int max17042_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	struct max17042_chip *chip = container_of(psy,
-				struct max17042_chip, battery);
+	struct max17042_chip *chip = power_supply_get_drvdata(psy);
 	struct regmap *map = chip->regmap;
 	int ret;
 	u32 data;
@@ -604,7 +603,7 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 		max17042_set_soc_threshold(chip, 1);
 	}
 
-	power_supply_changed(&chip->battery);
+	power_supply_changed(chip->battery);
 	return IRQ_HANDLED;
 }
 
@@ -664,10 +663,28 @@ static const struct regmap_config max17042_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
 };
 
+static const struct power_supply_desc max17042_psy_desc = {
+	.name		= "max170xx_battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= max17042_get_property,
+	.properties	= max17042_battery_props,
+	.num_properties	= ARRAY_SIZE(max17042_battery_props),
+};
+
+static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
+	.name		= "max170xx_battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= max17042_get_property,
+	.properties	= max17042_battery_props,
+	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
+};
+
 static int max17042_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
+	struct power_supply_config psy_cfg = {};
 	struct max17042_chip *chip;
 	int ret;
 	int i;
@@ -694,6 +711,7 @@ static int max17042_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, chip);
+	psy_cfg.drv_data = chip;
 
 	regmap_read(chip->regmap, MAX17042_DevName, &val);
 	if (val == MAX17042_IC_VERSION) {
@@ -707,16 +725,10 @@ static int max17042_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	chip->battery.name		= "max170xx_battery";
-	chip->battery.type		= POWER_SUPPLY_TYPE_BATTERY;
-	chip->battery.get_property	= max17042_get_property;
-	chip->battery.properties	= max17042_battery_props;
-	chip->battery.num_properties	= ARRAY_SIZE(max17042_battery_props);
-
 	/* When current is not measured,
 	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
 	if (!chip->pdata->enable_current_sense)
-		chip->battery.num_properties -= 2;
+		max17042_desc = &max17042_no_current_sense_psy_desc;
 
 	if (chip->pdata->r_sns == 0)
 		chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
@@ -733,17 +745,18 @@ static int max17042_probe(struct i2c_client *client,
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
-	ret = power_supply_register(&client->dev, &chip->battery, NULL);
-	if (ret) {
+	chip->battery = power_supply_register(&client->dev, max17042_desc,
+						&psy_cfg);
+	if (IS_ERR(chip->battery)) {
 		dev_err(&client->dev, "failed: power supply register\n");
-		return ret;
+		return PTR_ERR(chip->battery);
 	}
 
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq, NULL,
 					max17042_thread_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					chip->battery.name, chip);
+					chip->battery->desc->name, chip);
 		if (!ret) {
 			regmap_read(chip->regmap, MAX17042_CONFIG, &val);
 			val |= CONFIG_ALRT_BIT_ENBL;
@@ -773,7 +786,7 @@ static int max17042_remove(struct i2c_client *client)
 
 	if (client->irq)
 		free_irq(client->irq, chip);
-	power_supply_unregister(&chip->battery);
+	power_supply_unregister(chip->battery);
 	return 0;
 }
 
diff --git a/drivers/power/max77693_charger.c b/drivers/power/max77693_charger.c
index 884ec851e993..e3870df93807 100644
--- a/drivers/power/max77693_charger.c
+++ b/drivers/power/max77693_charger.c
@@ -22,14 +22,14 @@
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-private.h>
 
-static const char *max77693_charger_name		= "max77693-charger";
+#define MAX77693_CHARGER_NAME				"max77693-charger"
 static const char *max77693_charger_model		= "MAX77693";
 static const char *max77693_charger_manufacturer	= "Maxim Integrated";
 
 struct max77693_charger {
 	struct device		*dev;
 	struct max77693_dev	*max77693;
-	struct power_supply	charger;
+	struct power_supply	*charger;
 
 	u32 constant_volt;
 	u32 min_system_volt;
@@ -209,9 +209,7 @@ static int max77693_charger_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	struct max77693_charger *chg = container_of(psy,
-						  struct max77693_charger,
-						  charger);
+	struct max77693_charger *chg = power_supply_get_drvdata(psy);
 	struct regmap *regmap = chg->max77693->regmap;
 	int ret = 0;
 
@@ -244,6 +242,14 @@ static int max77693_charger_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static const struct power_supply_desc max77693_charger_desc = {
+	.name		= MAX77693_CHARGER_NAME,
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= max77693_charger_props,
+	.num_properties	= ARRAY_SIZE(max77693_charger_props),
+	.get_property	= max77693_charger_get_property,
+};
+
 static ssize_t device_attr_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count,
 		int (*fn)(struct max77693_charger *, unsigned long))
@@ -659,6 +665,7 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 static int max77693_charger_probe(struct platform_device *pdev)
 {
 	struct max77693_charger *chg;
+	struct power_supply_config psy_cfg = {};
 	struct max77693_dev *max77693 = dev_get_drvdata(pdev->dev.parent);
 	int ret;
 
@@ -678,11 +685,7 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	chg->charger.name = max77693_charger_name;
-	chg->charger.type = POWER_SUPPLY_TYPE_BATTERY;
-	chg->charger.properties = max77693_charger_props;
-	chg->charger.num_properties = ARRAY_SIZE(max77693_charger_props);
-	chg->charger.get_property = max77693_charger_get_property;
+	psy_cfg.drv_data = chg;
 
 	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
 	if (ret) {
@@ -703,9 +706,12 @@ static int max77693_charger_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = power_supply_register(&pdev->dev, &chg->charger, NULL);
-	if (ret) {
+	chg->charger = power_supply_register(&pdev->dev,
+						&max77693_charger_desc,
+						&psy_cfg);
+	if (IS_ERR(chg->charger)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
+		ret = PTR_ERR(chg->charger);
 		goto err;
 	}
 
@@ -727,7 +733,7 @@ static int max77693_charger_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
 
-	power_supply_unregister(&chg->charger);
+	power_supply_unregister(chg->charger);
 
 	return 0;
 }
diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 2f769faa85f6..bf2b4b3a7cae 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -31,7 +31,8 @@
 struct max8903_data {
 	struct max8903_pdata pdata;
 	struct device *dev;
-	struct power_supply psy;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
 	bool fault;
 	bool usb_in;
 	bool ta_in;
@@ -47,8 +48,7 @@ static int max8903_get_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		union power_supply_propval *val)
 {
-	struct max8903_data *data = container_of(psy,
-			struct max8903_data, psy);
+	struct max8903_data *data = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -104,17 +104,17 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 	dev_dbg(data->dev, "TA(DC-IN) Charger %s.\n", ta_in ?
 			"Connected" : "Disconnected");
 
-	old_type = data->psy.type;
+	old_type = data->psy_desc.type;
 
 	if (data->ta_in)
-		data->psy.type = POWER_SUPPLY_TYPE_MAINS;
+		data->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
 	else if (data->usb_in)
-		data->psy.type = POWER_SUPPLY_TYPE_USB;
+		data->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 	else
-		data->psy.type = POWER_SUPPLY_TYPE_BATTERY;
+		data->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 
-	if (old_type != data->psy.type)
-		power_supply_changed(&data->psy);
+	if (old_type != data->psy_desc.type)
+		power_supply_changed(data->psy);
 
 	return IRQ_HANDLED;
 }
@@ -143,17 +143,17 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
 	dev_dbg(data->dev, "USB Charger %s.\n", usb_in ?
 			"Connected" : "Disconnected");
 
-	old_type = data->psy.type;
+	old_type = data->psy_desc.type;
 
 	if (data->ta_in)
-		data->psy.type = POWER_SUPPLY_TYPE_MAINS;
+		data->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
 	else if (data->usb_in)
-		data->psy.type = POWER_SUPPLY_TYPE_USB;
+		data->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 	else
-		data->psy.type = POWER_SUPPLY_TYPE_BATTERY;
+		data->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 
-	if (old_type != data->psy.type)
-		power_supply_changed(&data->psy);
+	if (old_type != data->psy_desc.type)
+		power_supply_changed(data->psy);
 
 	return IRQ_HANDLED;
 }
@@ -184,6 +184,7 @@ static int max8903_probe(struct platform_device *pdev)
 	struct max8903_data *data;
 	struct device *dev = &pdev->dev;
 	struct max8903_pdata *pdata = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 	int gpio;
 	int ta_in = 0;
@@ -280,17 +281,20 @@ static int max8903_probe(struct platform_device *pdev)
 	data->ta_in = ta_in;
 	data->usb_in = usb_in;
 
-	data->psy.name = "max8903_charger";
-	data->psy.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
+	data->psy_desc.name = "max8903_charger";
+	data->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
 			((usb_in) ? POWER_SUPPLY_TYPE_USB :
 			 POWER_SUPPLY_TYPE_BATTERY);
-	data->psy.get_property = max8903_get_property;
-	data->psy.properties = max8903_charger_props;
-	data->psy.num_properties = ARRAY_SIZE(max8903_charger_props);
+	data->psy_desc.get_property = max8903_get_property;
+	data->psy_desc.properties = max8903_charger_props;
+	data->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
 
-	ret = power_supply_register(dev, &data->psy, NULL);
-	if (ret) {
+	psy_cfg.drv_data = data;
+
+	data->psy = power_supply_register(dev, &data->psy_desc, &psy_cfg);
+	if (IS_ERR(data->psy)) {
 		dev_err(dev, "failed: power supply register.\n");
+		ret = PTR_ERR(data->psy);
 		goto err;
 	}
 
@@ -339,7 +343,7 @@ err_dc_irq:
 	if (pdata->dc_valid)
 		free_irq(gpio_to_irq(pdata->dok), data);
 err_psy:
-	power_supply_unregister(&data->psy);
+	power_supply_unregister(data->psy);
 err:
 	return ret;
 }
@@ -357,7 +361,7 @@ static int max8903_remove(struct platform_device *pdev)
 			free_irq(gpio_to_irq(pdata->uok), data);
 		if (pdata->dc_valid)
 			free_irq(gpio_to_irq(pdata->dok), data);
-		power_supply_unregister(&data->psy);
+		power_supply_unregister(data->psy);
 	}
 
 	return 0;
diff --git a/drivers/power/max8925_power.c b/drivers/power/max8925_power.c
index 71c087e3feaf..57eb5c2bfc21 100644
--- a/drivers/power/max8925_power.c
+++ b/drivers/power/max8925_power.c
@@ -68,9 +68,9 @@ struct max8925_power_info {
 	struct i2c_client	*gpm;
 	struct i2c_client	*adc;
 
-	struct power_supply	ac;
-	struct power_supply	usb;
-	struct power_supply	battery;
+	struct power_supply	*ac;
+	struct power_supply	*usb;
+	struct power_supply	*battery;
 	int			irq_base;
 	unsigned		ac_online:1;
 	unsigned		usb_online:1;
@@ -196,7 +196,7 @@ static int max8925_ac_get_prop(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
 {
-	struct max8925_power_info *info = dev_get_drvdata(psy->dev->parent);
+	struct max8925_power_info *info = dev_get_drvdata(psy->dev.parent);
 	int ret = 0;
 
 	switch (psp) {
@@ -230,7 +230,7 @@ static int max8925_usb_get_prop(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct max8925_power_info *info = dev_get_drvdata(psy->dev->parent);
+	struct max8925_power_info *info = dev_get_drvdata(psy->dev.parent);
 	int ret = 0;
 
 	switch (psp) {
@@ -264,7 +264,7 @@ static int max8925_bat_get_prop(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct max8925_power_info *info = dev_get_drvdata(psy->dev->parent);
+	struct max8925_power_info *info = dev_get_drvdata(psy->dev.parent);
 	int ret = 0;
 
 	switch (psp) {
@@ -347,6 +347,30 @@ static enum power_supply_property max8925_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 };
 
+static const struct power_supply_desc ac_desc = {
+	.name		= "max8925-ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= max8925_ac_props,
+	.num_properties	= ARRAY_SIZE(max8925_ac_props),
+	.get_property	= max8925_ac_get_prop,
+};
+
+static const struct power_supply_desc usb_desc = {
+	.name		= "max8925-usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= max8925_usb_props,
+	.num_properties	= ARRAY_SIZE(max8925_usb_props),
+	.get_property	= max8925_usb_get_prop,
+};
+
+static const struct power_supply_desc battery_desc = {
+	.name		= "max8925-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= max8925_battery_props,
+	.num_properties	= ARRAY_SIZE(max8925_battery_props),
+	.get_property	= max8925_bat_get_prop,
+};
+
 #define REQUEST_IRQ(_irq, _name)					\
 do {									\
 	ret = request_threaded_irq(chip->irq_base + _irq, NULL,		\
@@ -506,36 +530,26 @@ static int max8925_power_probe(struct platform_device *pdev)
 	psy_cfg.supplied_to = pdata->supplied_to;
 	psy_cfg.num_supplicants = pdata->num_supplicants;
 
-	info->ac.name = "max8925-ac";
-	info->ac.type = POWER_SUPPLY_TYPE_MAINS;
-	info->ac.properties = max8925_ac_props;
-	info->ac.num_properties = ARRAY_SIZE(max8925_ac_props);
-	info->ac.get_property = max8925_ac_get_prop;
-	ret = power_supply_register(&pdev->dev, &info->ac, &psy_cfg);
-	if (ret)
+	info->ac = power_supply_register(&pdev->dev, &ac_desc, &psy_cfg);
+	if (IS_ERR(info->ac)) {
+		ret = PTR_ERR(info->ac);
 		goto out;
-	info->ac.dev->parent = &pdev->dev;
-
-	info->usb.name = "max8925-usb";
-	info->usb.type = POWER_SUPPLY_TYPE_USB;
-	info->usb.properties = max8925_usb_props;
-	info->usb.num_properties = ARRAY_SIZE(max8925_usb_props);
-	info->usb.get_property = max8925_usb_get_prop;
+	}
+	info->ac->dev.parent = &pdev->dev;
 
-	ret = power_supply_register(&pdev->dev, &info->usb, &psy_cfg);
-	if (ret)
+	info->usb = power_supply_register(&pdev->dev, &usb_desc, &psy_cfg);
+	if (IS_ERR(info->usb)) {
+		ret = PTR_ERR(info->usb);
 		goto out_usb;
-	info->usb.dev->parent = &pdev->dev;
-
-	info->battery.name = "max8925-battery";
-	info->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	info->battery.properties = max8925_battery_props;
-	info->battery.num_properties = ARRAY_SIZE(max8925_battery_props);
-	info->battery.get_property = max8925_bat_get_prop;
-	ret = power_supply_register(&pdev->dev, &info->battery, NULL);
-	if (ret)
+	}
+	info->usb->dev.parent = &pdev->dev;
+
+	info->battery = power_supply_register(&pdev->dev, &battery_desc, NULL);
+	if (IS_ERR(info->battery)) {
+		ret = PTR_ERR(info->battery);
 		goto out_battery;
-	info->battery.dev->parent = &pdev->dev;
+	}
+	info->battery->dev.parent = &pdev->dev;
 
 	info->batt_detect = pdata->batt_detect;
 	info->topoff_threshold = pdata->topoff_threshold;
@@ -547,9 +561,9 @@ static int max8925_power_probe(struct platform_device *pdev)
 	max8925_init_charger(chip, info);
 	return 0;
 out_battery:
-	power_supply_unregister(&info->battery);
+	power_supply_unregister(info->battery);
 out_usb:
-	power_supply_unregister(&info->ac);
+	power_supply_unregister(info->ac);
 out:
 	return ret;
 }
@@ -559,9 +573,9 @@ static int max8925_power_remove(struct platform_device *pdev)
 	struct max8925_power_info *info = platform_get_drvdata(pdev);
 
 	if (info) {
-		power_supply_unregister(&info->ac);
-		power_supply_unregister(&info->usb);
-		power_supply_unregister(&info->battery);
+		power_supply_unregister(info->ac);
+		power_supply_unregister(info->usb);
+		power_supply_unregister(info->battery);
 		max8925_deinit_charger(info);
 	}
 	return 0;
diff --git a/drivers/power/max8997_charger.c b/drivers/power/max8997_charger.c
index a9f4d506eb44..0b2eab571528 100644
--- a/drivers/power/max8997_charger.c
+++ b/drivers/power/max8997_charger.c
@@ -30,7 +30,7 @@
 struct charger_data {
 	struct device *dev;
 	struct max8997_dev *iodev;
-	struct power_supply battery;
+	struct power_supply *battery;
 };
 
 static enum power_supply_property max8997_battery_props[] = {
@@ -44,8 +44,7 @@ static int max8997_battery_get_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		union power_supply_propval *val)
 {
-	struct charger_data *charger = container_of(psy,
-			struct charger_data, battery);
+	struct charger_data *charger = power_supply_get_drvdata(psy);
 	struct i2c_client *i2c = charger->iodev->i2c;
 	int ret;
 	u8 reg;
@@ -86,12 +85,21 @@ static int max8997_battery_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static const struct power_supply_desc max8997_battery_desc = {
+	.name		= "max8997_pmic",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= max8997_battery_get_property,
+	.properties	= max8997_battery_props,
+	.num_properties	= ARRAY_SIZE(max8997_battery_props),
+};
+
 static int max8997_battery_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct charger_data *charger;
 	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct max8997_platform_data *pdata = dev_get_platdata(iodev->dev);
+	struct power_supply_config psy_cfg = {};
 
 	if (!pdata)
 		return -EINVAL;
@@ -147,19 +155,18 @@ static int max8997_battery_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, charger);
 
-	charger->battery.name = "max8997_pmic";
-	charger->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	charger->battery.get_property = max8997_battery_get_property;
-	charger->battery.properties = max8997_battery_props;
-	charger->battery.num_properties = ARRAY_SIZE(max8997_battery_props);
 
 	charger->dev = &pdev->dev;
 	charger->iodev = iodev;
 
-	ret = power_supply_register(&pdev->dev, &charger->battery, NULL);
-	if (ret) {
+	psy_cfg.drv_data = charger;
+
+	charger->battery = power_supply_register(&pdev->dev,
+						 &max8997_battery_desc,
+						 &psy_cfg);
+	if (IS_ERR(charger->battery)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
-		return ret;
+		return PTR_ERR(charger->battery);
 	}
 
 	return 0;
@@ -169,7 +176,7 @@ static int max8997_battery_remove(struct platform_device *pdev)
 {
 	struct charger_data *charger = platform_get_drvdata(pdev);
 
-	power_supply_unregister(&charger->battery);
+	power_supply_unregister(charger->battery);
 	return 0;
 }
 
diff --git a/drivers/power/max8998_charger.c b/drivers/power/max8998_charger.c
index 9ee72314b3d0..47448d4bc6cd 100644
--- a/drivers/power/max8998_charger.c
+++ b/drivers/power/max8998_charger.c
@@ -30,7 +30,7 @@
 struct max8998_battery_data {
 	struct device *dev;
 	struct max8998_dev *iodev;
-	struct power_supply battery;
+	struct power_supply *battery;
 };
 
 static enum power_supply_property max8998_battery_props[] = {
@@ -43,8 +43,7 @@ static int max8998_battery_get_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		union power_supply_propval *val)
 {
-	struct max8998_battery_data *max8998 = container_of(psy,
-			struct max8998_battery_data, battery);
+	struct max8998_battery_data *max8998 = power_supply_get_drvdata(psy);
 	struct i2c_client *i2c = max8998->iodev->i2c;
 	int ret;
 	u8 reg;
@@ -75,10 +74,19 @@ static int max8998_battery_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static const struct power_supply_desc max8998_battery_desc = {
+	.name		= "max8998_pmic",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= max8998_battery_get_property,
+	.properties	= max8998_battery_props,
+	.num_properties	= ARRAY_SIZE(max8998_battery_props),
+};
+
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
+	struct power_supply_config psy_cfg = {};
 	struct max8998_battery_data *max8998;
 	struct i2c_client *i2c;
 	int ret = 0;
@@ -161,15 +169,15 @@ static int max8998_battery_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	max8998->battery.name = "max8998_pmic";
-	max8998->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	max8998->battery.get_property = max8998_battery_get_property;
-	max8998->battery.properties = max8998_battery_props;
-	max8998->battery.num_properties = ARRAY_SIZE(max8998_battery_props);
+	psy_cfg.drv_data = max8998;
 
-	ret = power_supply_register(max8998->dev, &max8998->battery, NULL);
-	if (ret) {
-		dev_err(max8998->dev, "failed: power supply register\n");
+	max8998->battery = power_supply_register(max8998->dev,
+						 &max8998_battery_desc,
+						 &psy_cfg);
+	if (IS_ERR(max8998->battery)) {
+		ret = PTR_ERR(max8998->battery);
+		dev_err(max8998->dev, "failed: power supply register: %d\n",
+			ret);
 		goto err;
 	}
 
@@ -182,7 +190,7 @@ static int max8998_battery_remove(struct platform_device *pdev)
 {
 	struct max8998_battery_data *max8998 = platform_get_drvdata(pdev);
 
-	power_supply_unregister(&max8998->battery);
+	power_supply_unregister(max8998->battery);
 
 	return 0;
 }
diff --git a/drivers/power/olpc_battery.c b/drivers/power/olpc_battery.c
index 1340a1a75325..a944338a39de 100644
--- a/drivers/power/olpc_battery.c
+++ b/drivers/power/olpc_battery.c
@@ -81,7 +81,7 @@ static enum power_supply_property olpc_ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-static struct power_supply olpc_ac = {
+static const struct power_supply_desc olpc_ac_desc = {
 	.name = "olpc-ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
 	.properties = olpc_ac_props,
@@ -89,6 +89,8 @@ static struct power_supply olpc_ac = {
 	.get_property = olpc_ac_get_prop,
 };
 
+static struct power_supply *olpc_ac;
+
 static char bat_serial[17]; /* Ick */
 
 static int olpc_bat_get_status(union power_supply_propval *val, uint8_t ec_byte)
@@ -574,21 +576,23 @@ static struct device_attribute olpc_bat_error = {
  *		Initialisation
  *********************************************************************/
 
-static struct power_supply olpc_bat = {
+static struct power_supply_desc olpc_bat_desc = {
 	.name = "olpc-battery",
 	.get_property = olpc_bat_get_property,
 	.use_for_apm = 1,
 };
 
+static struct power_supply *olpc_bat;
+
 static int olpc_battery_suspend(struct platform_device *pdev,
 				pm_message_t state)
 {
-	if (device_may_wakeup(olpc_ac.dev))
+	if (device_may_wakeup(&olpc_ac->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_ACPWR);
 	else
 		olpc_ec_wakeup_clear(EC_SCI_SRC_ACPWR);
 
-	if (device_may_wakeup(olpc_bat.dev))
+	if (device_may_wakeup(&olpc_bat->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_BATTERY | EC_SCI_SRC_BATSOC
 				   | EC_SCI_SRC_BATERR);
 	else
@@ -619,52 +623,54 @@ static int olpc_battery_probe(struct platform_device *pdev)
 
 	/* Ignore the status. It doesn't actually matter */
 
-	ret = power_supply_register(&pdev->dev, &olpc_ac, NULL);
-	if (ret)
-		return ret;
+	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
+	if (IS_ERR(olpc_ac))
+		return PTR_ERR(olpc_ac);
 
 	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
-		olpc_bat.properties = olpc_xo15_bat_props;
-		olpc_bat.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
+		olpc_bat_desc.properties = olpc_xo15_bat_props;
+		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
 	} else { /* XO-1 */
-		olpc_bat.properties = olpc_xo1_bat_props;
-		olpc_bat.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
+		olpc_bat_desc.properties = olpc_xo1_bat_props;
+		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
 
-	ret = power_supply_register(&pdev->dev, &olpc_bat, NULL);
-	if (ret)
+	olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
+	if (IS_ERR(olpc_bat)) {
+		ret = PTR_ERR(olpc_bat);
 		goto battery_failed;
+	}
 
-	ret = device_create_bin_file(olpc_bat.dev, &olpc_bat_eeprom);
+	ret = device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
 	if (ret)
 		goto eeprom_failed;
 
-	ret = device_create_file(olpc_bat.dev, &olpc_bat_error);
+	ret = device_create_file(&olpc_bat->dev, &olpc_bat_error);
 	if (ret)
 		goto error_failed;
 
 	if (olpc_ec_wakeup_available()) {
-		device_set_wakeup_capable(olpc_ac.dev, true);
-		device_set_wakeup_capable(olpc_bat.dev, true);
+		device_set_wakeup_capable(&olpc_ac->dev, true);
+		device_set_wakeup_capable(&olpc_bat->dev, true);
 	}
 
 	return 0;
 
 error_failed:
-	device_remove_bin_file(olpc_bat.dev, &olpc_bat_eeprom);
+	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
 eeprom_failed:
-	power_supply_unregister(&olpc_bat);
+	power_supply_unregister(olpc_bat);
 battery_failed:
-	power_supply_unregister(&olpc_ac);
+	power_supply_unregister(olpc_ac);
 	return ret;
 }
 
 static int olpc_battery_remove(struct platform_device *pdev)
 {
-	device_remove_file(olpc_bat.dev, &olpc_bat_error);
-	device_remove_bin_file(olpc_bat.dev, &olpc_bat_eeprom);
-	power_supply_unregister(&olpc_bat);
-	power_supply_unregister(&olpc_ac);
+	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
+	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
+	power_supply_unregister(olpc_bat);
+	power_supply_unregister(olpc_ac);
 	return 0;
 }
 
diff --git a/drivers/power/pcf50633-charger.c b/drivers/power/pcf50633-charger.c
index 88fe7db2afcf..d05597b4e40f 100644
--- a/drivers/power/pcf50633-charger.c
+++ b/drivers/power/pcf50633-charger.c
@@ -33,9 +33,9 @@ struct pcf50633_mbc {
 	int adapter_online;
 	int usb_online;
 
-	struct power_supply usb;
-	struct power_supply adapter;
-	struct power_supply ac;
+	struct power_supply *usb;
+	struct power_supply *adapter;
+	struct power_supply *ac;
 };
 
 int pcf50633_mbc_usb_curlim_set(struct pcf50633 *pcf, int ma)
@@ -104,7 +104,7 @@ int pcf50633_mbc_usb_curlim_set(struct pcf50633 *pcf, int ma)
 				PCF50633_MBCC1_CHGENA, PCF50633_MBCC1_CHGENA);
 	}
 
-	power_supply_changed(&mbc->usb);
+	power_supply_changed(mbc->usb);
 
 	return ret;
 }
@@ -278,9 +278,9 @@ pcf50633_mbc_irq_handler(int irq, void *data)
 	else if (irq == PCF50633_IRQ_ADPREM)
 		mbc->adapter_online = 0;
 
-	power_supply_changed(&mbc->ac);
-	power_supply_changed(&mbc->usb);
-	power_supply_changed(&mbc->adapter);
+	power_supply_changed(mbc->ac);
+	power_supply_changed(mbc->usb);
+	power_supply_changed(mbc->adapter);
 
 	if (mbc->pcf->pdata->mbc_event_callback)
 		mbc->pcf->pdata->mbc_event_callback(mbc->pcf, irq);
@@ -290,8 +290,7 @@ static int adapter_get_property(struct power_supply *psy,
 			enum power_supply_property psp,
 			union power_supply_propval *val)
 {
-	struct pcf50633_mbc *mbc = container_of(psy,
-				struct pcf50633_mbc, adapter);
+	struct pcf50633_mbc *mbc = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
@@ -309,7 +308,7 @@ static int usb_get_property(struct power_supply *psy,
 			enum power_supply_property psp,
 			union power_supply_propval *val)
 {
-	struct pcf50633_mbc *mbc = container_of(psy, struct pcf50633_mbc, usb);
+	struct pcf50633_mbc *mbc = power_supply_get_drvdata(psy);
 	int ret = 0;
 	u8 usblim = pcf50633_reg_read(mbc->pcf, PCF50633_REG_MBCC7) &
 						PCF50633_MBCC7_USB_MASK;
@@ -330,7 +329,7 @@ static int ac_get_property(struct power_supply *psy,
 			enum power_supply_property psp,
 			union power_supply_propval *val)
 {
-	struct pcf50633_mbc *mbc = container_of(psy, struct pcf50633_mbc, ac);
+	struct pcf50633_mbc *mbc = power_supply_get_drvdata(psy);
 	int ret = 0;
 	u8 usblim = pcf50633_reg_read(mbc->pcf, PCF50633_REG_MBCC7) &
 						PCF50633_MBCC7_USB_MASK;
@@ -366,6 +365,30 @@ static const u8 mbc_irq_handlers[] = {
 	PCF50633_IRQ_LOWBAT,
 };
 
+static const struct power_supply_desc pcf50633_mbc_adapter_desc = {
+	.name		= "adapter",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= power_props,
+	.num_properties	= ARRAY_SIZE(power_props),
+	.get_property	= &adapter_get_property,
+};
+
+static const struct power_supply_desc pcf50633_mbc_usb_desc = {
+	.name		= "usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= power_props,
+	.num_properties	= ARRAY_SIZE(power_props),
+	.get_property	= usb_get_property,
+};
+
+static const struct power_supply_desc pcf50633_mbc_ac_desc = {
+	.name		= "ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= power_props,
+	.num_properties	= ARRAY_SIZE(power_props),
+	.get_property	= ac_get_property,
+};
+
 static int pcf50633_mbc_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
@@ -388,44 +411,34 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 
 	psy_cfg.supplied_to		= mbc->pcf->pdata->batteries;
 	psy_cfg.num_supplicants		= mbc->pcf->pdata->num_batteries;
+	psy_cfg.drv_data		= mbc;
 
 	/* Create power supplies */
-	mbc->adapter.name		= "adapter";
-	mbc->adapter.type		= POWER_SUPPLY_TYPE_MAINS;
-	mbc->adapter.properties		= power_props;
-	mbc->adapter.num_properties	= ARRAY_SIZE(power_props);
-	mbc->adapter.get_property	= &adapter_get_property;
-
-	mbc->usb.name			= "usb";
-	mbc->usb.type			= POWER_SUPPLY_TYPE_USB;
-	mbc->usb.properties		= power_props;
-	mbc->usb.num_properties		= ARRAY_SIZE(power_props);
-	mbc->usb.get_property		= usb_get_property;
-
-	mbc->ac.name			= "ac";
-	mbc->ac.type			= POWER_SUPPLY_TYPE_MAINS;
-	mbc->ac.properties		= power_props;
-	mbc->ac.num_properties		= ARRAY_SIZE(power_props);
-	mbc->ac.get_property		= ac_get_property;
-
-	ret = power_supply_register(&pdev->dev, &mbc->adapter, &psy_cfg);
-	if (ret) {
+	mbc->adapter = power_supply_register(&pdev->dev,
+					     &pcf50633_mbc_adapter_desc,
+					     &psy_cfg);
+	if (IS_ERR(mbc->adapter)) {
 		dev_err(mbc->pcf->dev, "failed to register adapter\n");
+		ret = PTR_ERR(mbc->adapter);
 		return ret;
 	}
 
-	ret = power_supply_register(&pdev->dev, &mbc->usb, &psy_cfg);
-	if (ret) {
+	mbc->usb = power_supply_register(&pdev->dev, &pcf50633_mbc_usb_desc,
+					 &psy_cfg);
+	if (IS_ERR(mbc->usb)) {
 		dev_err(mbc->pcf->dev, "failed to register usb\n");
-		power_supply_unregister(&mbc->adapter);
+		power_supply_unregister(mbc->adapter);
+		ret = PTR_ERR(mbc->usb);
 		return ret;
 	}
 
-	ret = power_supply_register(&pdev->dev, &mbc->ac, &psy_cfg);
-	if (ret) {
+	mbc->ac = power_supply_register(&pdev->dev, &pcf50633_mbc_ac_desc,
+					&psy_cfg);
+	if (IS_ERR(mbc->ac)) {
 		dev_err(mbc->pcf->dev, "failed to register ac\n");
-		power_supply_unregister(&mbc->adapter);
-		power_supply_unregister(&mbc->usb);
+		power_supply_unregister(mbc->adapter);
+		power_supply_unregister(mbc->usb);
+		ret = PTR_ERR(mbc->ac);
 		return ret;
 	}
 
@@ -452,9 +465,9 @@ static int pcf50633_mbc_remove(struct platform_device *pdev)
 		pcf50633_free_irq(mbc->pcf, mbc_irq_handlers[i]);
 
 	sysfs_remove_group(&pdev->dev.kobj, &mbc_attr_group);
-	power_supply_unregister(&mbc->usb);
-	power_supply_unregister(&mbc->adapter);
-	power_supply_unregister(&mbc->ac);
+	power_supply_unregister(mbc->usb);
+	power_supply_unregister(mbc->adapter);
+	power_supply_unregister(mbc->ac);
 
 	return 0;
 }
diff --git a/drivers/power/pda_power.c b/drivers/power/pda_power.c
index fd55fad1d0db..dfe1ee89f7c7 100644
--- a/drivers/power/pda_power.c
+++ b/drivers/power/pda_power.c
@@ -34,6 +34,7 @@ static struct timer_list charger_timer;
 static struct timer_list supply_timer;
 static struct timer_list polling_timer;
 static int polling;
+static struct power_supply *pda_psy_ac, *pda_psy_usb;
 
 #if IS_ENABLED(CONFIG_USB_PHY)
 static struct usb_phy *transceiver;
@@ -58,7 +59,7 @@ static int pda_power_get_property(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-		if (psy->type == POWER_SUPPLY_TYPE_MAINS)
+		if (psy->desc->type == POWER_SUPPLY_TYPE_MAINS)
 			val->intval = pdata->is_ac_online ?
 				      pdata->is_ac_online() : 0;
 		else
@@ -80,7 +81,7 @@ static char *pda_power_supplied_to[] = {
 	"backup-battery",
 };
 
-static struct power_supply pda_psy_ac = {
+static const struct power_supply_desc pda_psy_ac_desc = {
 	.name = "ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
 	.properties = pda_power_props,
@@ -88,7 +89,7 @@ static struct power_supply pda_psy_ac = {
 	.get_property = pda_power_get_property,
 };
 
-static struct power_supply pda_psy_usb = {
+static const struct power_supply_desc pda_psy_usb_desc = {
 	.name = "usb",
 	.type = POWER_SUPPLY_TYPE_USB,
 	.properties = pda_power_props,
@@ -143,12 +144,12 @@ static void supply_timer_func(unsigned long unused)
 {
 	if (ac_status == PDA_PSY_TO_CHANGE) {
 		ac_status = new_ac_status;
-		power_supply_changed(&pda_psy_ac);
+		power_supply_changed(pda_psy_ac);
 	}
 
 	if (usb_status == PDA_PSY_TO_CHANGE) {
 		usb_status = new_usb_status;
-		power_supply_changed(&pda_psy_usb);
+		power_supply_changed(pda_psy_usb);
 	}
 }
 
@@ -172,9 +173,9 @@ static void charger_timer_func(unsigned long unused)
 
 static irqreturn_t power_changed_isr(int irq, void *power_supply)
 {
-	if (power_supply == &pda_psy_ac)
+	if (power_supply == pda_psy_ac)
 		ac_status = PDA_PSY_TO_CHANGE;
-	else if (power_supply == &pda_psy_usb)
+	else if (power_supply == pda_psy_usb)
 		usb_status = PDA_PSY_TO_CHANGE;
 	else
 		return IRQ_NONE;
@@ -324,17 +325,19 @@ static int pda_power_probe(struct platform_device *pdev)
 #endif
 
 	if (pdata->is_ac_online) {
-		ret = power_supply_register(&pdev->dev, &pda_psy_ac, &psy_cfg);
-		if (ret) {
+		pda_psy_ac = power_supply_register(&pdev->dev,
+						   &pda_psy_ac_desc, &psy_cfg);
+		if (IS_ERR(pda_psy_ac)) {
 			dev_err(dev, "failed to register %s power supply\n",
-				pda_psy_ac.name);
+				pda_psy_ac_desc.name);
+			ret = PTR_ERR(pda_psy_ac);
 			goto ac_supply_failed;
 		}
 
 		if (ac_irq) {
 			ret = request_irq(ac_irq->start, power_changed_isr,
 					  get_irq_flags(ac_irq), ac_irq->name,
-					  &pda_psy_ac);
+					  pda_psy_ac);
 			if (ret) {
 				dev_err(dev, "request ac irq failed\n");
 				goto ac_irq_failed;
@@ -345,17 +348,20 @@ static int pda_power_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->is_usb_online) {
-		ret = power_supply_register(&pdev->dev, &pda_psy_usb, &psy_cfg);
-		if (ret) {
+		pda_psy_usb = power_supply_register(&pdev->dev,
+						    &pda_psy_usb_desc,
+						    &psy_cfg);
+		if (IS_ERR(pda_psy_usb)) {
 			dev_err(dev, "failed to register %s power supply\n",
-				pda_psy_usb.name);
+				pda_psy_usb_desc.name);
+			ret = PTR_ERR(pda_psy_usb);
 			goto usb_supply_failed;
 		}
 
 		if (usb_irq) {
 			ret = request_irq(usb_irq->start, power_changed_isr,
 					  get_irq_flags(usb_irq),
-					  usb_irq->name, &pda_psy_usb);
+					  usb_irq->name, pda_psy_usb);
 			if (ret) {
 				dev_err(dev, "request usb irq failed\n");
 				goto usb_irq_failed;
@@ -392,21 +398,21 @@ static int pda_power_probe(struct platform_device *pdev)
 #if IS_ENABLED(CONFIG_USB_PHY)
 otg_reg_notifier_failed:
 	if (pdata->is_usb_online && usb_irq)
-		free_irq(usb_irq->start, &pda_psy_usb);
+		free_irq(usb_irq->start, pda_psy_usb);
 #endif
 usb_irq_failed:
 	if (pdata->is_usb_online)
-		power_supply_unregister(&pda_psy_usb);
+		power_supply_unregister(pda_psy_usb);
 usb_supply_failed:
 	if (pdata->is_ac_online && ac_irq)
-		free_irq(ac_irq->start, &pda_psy_ac);
+		free_irq(ac_irq->start, pda_psy_ac);
 #if IS_ENABLED(CONFIG_USB_PHY)
 	if (!IS_ERR_OR_NULL(transceiver))
 		usb_put_phy(transceiver);
 #endif
 ac_irq_failed:
 	if (pdata->is_ac_online)
-		power_supply_unregister(&pda_psy_ac);
+		power_supply_unregister(pda_psy_ac);
 ac_supply_failed:
 	if (ac_draw) {
 		regulator_put(ac_draw);
@@ -422,9 +428,9 @@ wrongid:
 static int pda_power_remove(struct platform_device *pdev)
 {
 	if (pdata->is_usb_online && usb_irq)
-		free_irq(usb_irq->start, &pda_psy_usb);
+		free_irq(usb_irq->start, pda_psy_usb);
 	if (pdata->is_ac_online && ac_irq)
-		free_irq(ac_irq->start, &pda_psy_ac);
+		free_irq(ac_irq->start, pda_psy_ac);
 
 	if (polling)
 		del_timer_sync(&polling_timer);
@@ -432,9 +438,9 @@ static int pda_power_remove(struct platform_device *pdev)
 	del_timer_sync(&supply_timer);
 
 	if (pdata->is_usb_online)
-		power_supply_unregister(&pda_psy_usb);
+		power_supply_unregister(pda_psy_usb);
 	if (pdata->is_ac_online)
-		power_supply_unregister(&pda_psy_ac);
+		power_supply_unregister(pda_psy_ac);
 #if IS_ENABLED(CONFIG_USB_PHY)
 	if (!IS_ERR_OR_NULL(transceiver))
 		usb_put_phy(transceiver);
diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index d2e88e473238..cc0893ffbf7e 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -216,7 +216,7 @@ static int pm2xxx_charger_ovv_mngt(struct pm2xxx_charger *pm2, int val)
 {
 	dev_err(pm2->dev, "Overvoltage detected\n");
 	pm2->flags.ovv = true;
-	power_supply_changed(&pm2->ac_chg.psy);
+	power_supply_changed(pm2->ac_chg.psy);
 
 	/* Schedule a new HW failure check */
 	queue_delayed_work(pm2->charger_wq, &pm2->check_hw_failure_work, 0);
@@ -229,7 +229,7 @@ static int pm2xxx_charger_wd_exp_mngt(struct pm2xxx_charger *pm2, int val)
 	dev_dbg(pm2->dev , "20 minutes watchdog expired\n");
 
 	pm2->ac.wd_expired = true;
-	power_supply_changed(&pm2->ac_chg.psy);
+	power_supply_changed(pm2->ac_chg.psy);
 
 	return 0;
 }
@@ -573,7 +573,7 @@ static int pm2xxx_charger_update_charger_current(struct ux500_charger *charger,
 	struct pm2xxx_charger *pm2;
 	u8 val;
 
-	if (charger->psy.type == POWER_SUPPLY_TYPE_MAINS)
+	if (charger->psy->desc->type == POWER_SUPPLY_TYPE_MAINS)
 		pm2 = to_pm2xxx_charger_ac_device_info(charger);
 	else
 		return -ENXIO;
@@ -816,7 +816,7 @@ static int pm2xxx_charger_ac_en(struct ux500_charger *charger,
 
 		dev_dbg(pm2->dev, "PM2301: " "Disabled AC charging\n");
 	}
-	power_supply_changed(&pm2->ac_chg.psy);
+	power_supply_changed(pm2->ac_chg.psy);
 
 error_occured:
 	return ret;
@@ -827,7 +827,7 @@ static int pm2xxx_charger_watchdog_kick(struct ux500_charger *charger)
 	int ret;
 	struct pm2xxx_charger *pm2;
 
-	if (charger->psy.type == POWER_SUPPLY_TYPE_MAINS)
+	if (charger->psy->desc->type == POWER_SUPPLY_TYPE_MAINS)
 		pm2 = to_pm2xxx_charger_ac_device_info(charger);
 	else
 		return -ENXIO;
@@ -845,8 +845,8 @@ static void pm2xxx_charger_ac_work(struct work_struct *work)
 		struct pm2xxx_charger, ac_work);
 
 
-	power_supply_changed(&pm2->ac_chg.psy);
-	sysfs_notify(&pm2->ac_chg.psy.dev->kobj, NULL, "present");
+	power_supply_changed(pm2->ac_chg.psy);
+	sysfs_notify(&pm2->ac_chg.psy->dev.kobj, NULL, "present");
 };
 
 static void pm2xxx_charger_check_hw_failure_work(struct work_struct *work)
@@ -862,7 +862,7 @@ static void pm2xxx_charger_check_hw_failure_work(struct work_struct *work)
 		if (!(reg_value & (PM2XXX_INT4_S_ITVPWR1OVV |
 					PM2XXX_INT4_S_ITVPWR2OVV))) {
 			pm2->flags.ovv = false;
-			power_supply_changed(&pm2->ac_chg.psy);
+			power_supply_changed(pm2->ac_chg.psy);
 		}
 	}
 
@@ -895,7 +895,7 @@ static void pm2xxx_charger_check_main_thermal_prot_work(
 				| PM2XXX_INT5_S_ITTHERMALSHUTDOWNFALL))
 		pm2->flags.main_thermal_prot = false;
 
-	power_supply_changed(&pm2->ac_chg.psy);
+	power_supply_changed(pm2->ac_chg.psy);
 }
 
 static struct pm2xxx_interrupts pm2xxx_int = {
@@ -1043,11 +1043,11 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 
 	/* AC supply */
 	/* power_supply base class */
-	pm2->ac_chg.psy.name = pm2->pdata->label;
-	pm2->ac_chg.psy.type = POWER_SUPPLY_TYPE_MAINS;
-	pm2->ac_chg.psy.properties = pm2xxx_charger_ac_props;
-	pm2->ac_chg.psy.num_properties = ARRAY_SIZE(pm2xxx_charger_ac_props);
-	pm2->ac_chg.psy.get_property = pm2xxx_charger_ac_get_property;
+	pm2->ac_chg_desc.name = pm2->pdata->label;
+	pm2->ac_chg_desc.type = POWER_SUPPLY_TYPE_MAINS;
+	pm2->ac_chg_desc.properties = pm2xxx_charger_ac_props;
+	pm2->ac_chg_desc.num_properties = ARRAY_SIZE(pm2xxx_charger_ac_props);
+	pm2->ac_chg_desc.get_property = pm2xxx_charger_ac_get_property;
 
 	psy_cfg.supplied_to = pm2->pdata->supplied_to;
 	psy_cfg.num_supplicants = pm2->pdata->num_supplicants;
@@ -1095,9 +1095,11 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 	}
 
 	/* Register AC charger class */
-	ret = power_supply_register(pm2->dev, &pm2->ac_chg.psy, &psy_cfg);
-	if (ret) {
+	pm2->ac_chg.psy = power_supply_register(pm2->dev, &pm2->ac_chg_desc,
+						&psy_cfg);
+	if (IS_ERR(pm2->ac_chg.psy)) {
 		dev_err(pm2->dev, "failed to register AC charger\n");
+		ret = PTR_ERR(pm2->ac_chg.psy);
 		goto free_regulator;
 	}
 
@@ -1169,8 +1171,8 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 		ab8500_override_turn_on_stat(~AB8500_POW_KEY_1_ON,
 					     AB8500_MAIN_CH_DET);
 		pm2->ac_conn = true;
-		power_supply_changed(&pm2->ac_chg.psy);
-		sysfs_notify(&pm2->ac_chg.psy.dev->kobj, NULL, "present");
+		power_supply_changed(pm2->ac_chg.psy);
+		sysfs_notify(&pm2->ac_chg.psy->dev.kobj, NULL, "present");
 	}
 
 	return 0;
@@ -1185,7 +1187,7 @@ unregister_pm2xxx_interrupt:
 	free_irq(gpio_to_irq(pm2->pdata->gpio_irq_number), pm2);
 unregister_pm2xxx_charger:
 	/* unregister power supply */
-	power_supply_unregister(&pm2->ac_chg.psy);
+	power_supply_unregister(pm2->ac_chg.psy);
 free_regulator:
 	/* disable the regulator */
 	regulator_put(pm2->regu);
@@ -1220,7 +1222,7 @@ static int pm2xxx_wall_charger_remove(struct i2c_client *i2c_client)
 	/* disable the regulator */
 	regulator_put(pm2->regu);
 
-	power_supply_unregister(&pm2->ac_chg.psy);
+	power_supply_unregister(pm2->ac_chg.psy);
 
 	if (gpio_is_valid(pm2->lpn_pin))
 		gpio_free(pm2->lpn_pin);
diff --git a/drivers/power/pm2301_charger.h b/drivers/power/pm2301_charger.h
index 8ce3cc0195df..24181cf9717b 100644
--- a/drivers/power/pm2301_charger.h
+++ b/drivers/power/pm2301_charger.h
@@ -486,6 +486,7 @@ struct pm2xxx_charger {
 	struct work_struct check_main_thermal_prot_work;
 	struct delayed_work check_hw_failure_work;
 	struct ux500_charger ac_chg;
+	struct power_supply_desc ac_chg_desc;
 	struct pm2xxx_charger_event_flags flags;
 };
 
diff --git a/drivers/power/pmu_battery.c b/drivers/power/pmu_battery.c
index fb026f19aa4a..9c8d5253812c 100644
--- a/drivers/power/pmu_battery.c
+++ b/drivers/power/pmu_battery.c
@@ -17,13 +17,14 @@
 #include <linux/slab.h>
 
 static struct pmu_battery_dev {
-	struct power_supply bat;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
 	struct pmu_battery_info *pbi;
 	char name[16];
 	int propval;
 } *pbats[PMU_MAX_BATTERIES];
 
-#define to_pmu_battery_dev(x) container_of(x, struct pmu_battery_dev, bat)
+#define to_pmu_battery_dev(x) power_supply_get_drvdata(x)
 
 /*********************************************************************
  *		Power
@@ -49,7 +50,7 @@ static enum power_supply_property pmu_ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-static struct power_supply pmu_ac = {
+static const struct power_supply_desc pmu_ac_desc = {
 	.name = "pmu-ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
 	.properties = pmu_ac_props,
@@ -57,6 +58,8 @@ static struct power_supply pmu_ac = {
 	.get_property = pmu_get_ac_prop,
 };
 
+static struct power_supply *pmu_ac;
+
 /*********************************************************************
  *		Battery properties
  *********************************************************************/
@@ -142,7 +145,7 @@ static struct platform_device *bat_pdev;
 
 static int __init pmu_bat_init(void)
 {
-	int ret;
+	int ret = 0;
 	int i;
 
 	bat_pdev = platform_device_register_simple("pmu-battery",
@@ -152,25 +155,32 @@ static int __init pmu_bat_init(void)
 		goto pdev_register_failed;
 	}
 
-	ret = power_supply_register(&bat_pdev->dev, &pmu_ac, NULL);
-	if (ret)
+	pmu_ac = power_supply_register(&bat_pdev->dev, &pmu_ac_desc, NULL);
+	if (IS_ERR(pmu_ac)) {
+		ret = PTR_ERR(pmu_ac);
 		goto ac_register_failed;
+	}
 
 	for (i = 0; i < pmu_battery_count; i++) {
+		struct power_supply_config psy_cfg = {};
 		struct pmu_battery_dev *pbat = kzalloc(sizeof(*pbat),
 						       GFP_KERNEL);
 		if (!pbat)
 			break;
 
 		sprintf(pbat->name, "PMU_battery_%d", i);
-		pbat->bat.name = pbat->name;
-		pbat->bat.properties = pmu_bat_props;
-		pbat->bat.num_properties = ARRAY_SIZE(pmu_bat_props);
-		pbat->bat.get_property = pmu_bat_get_property;
+		pbat->bat_desc.name = pbat->name;
+		pbat->bat_desc.properties = pmu_bat_props;
+		pbat->bat_desc.num_properties = ARRAY_SIZE(pmu_bat_props);
+		pbat->bat_desc.get_property = pmu_bat_get_property;
 		pbat->pbi = &pmu_batteries[i];
+		psy_cfg.drv_data = pbat;
 
-		ret = power_supply_register(&bat_pdev->dev, &pbat->bat, NULL);
-		if (ret) {
+		pbat->bat = power_supply_register(&bat_pdev->dev,
+						  &pbat->bat_desc,
+						  &psy_cfg);
+		if (IS_ERR(pbat->bat)) {
+			ret = PTR_ERR(pbat->bat);
 			kfree(pbat);
 			goto battery_register_failed;
 		}
@@ -183,10 +193,10 @@ battery_register_failed:
 	while (i--) {
 		if (!pbats[i])
 			continue;
-		power_supply_unregister(&pbats[i]->bat);
+		power_supply_unregister(pbats[i]->bat);
 		kfree(pbats[i]);
 	}
-	power_supply_unregister(&pmu_ac);
+	power_supply_unregister(pmu_ac);
 ac_register_failed:
 	platform_device_unregister(bat_pdev);
 pdev_register_failed:
@@ -201,10 +211,10 @@ static void __exit pmu_bat_exit(void)
 	for (i = 0; i < PMU_MAX_BATTERIES; i++) {
 		if (!pbats[i])
 			continue;
-		power_supply_unregister(&pbats[i]->bat);
+		power_supply_unregister(pbats[i]->bat);
 		kfree(pbats[i]);
 	}
-	power_supply_unregister(&pmu_ac);
+	power_supply_unregister(pmu_ac);
 	platform_device_unregister(bat_pdev);
 }
 
diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 0521681b3674..7f437f66076c 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -40,16 +40,16 @@ static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 
 	/* Support both supplied_to and supplied_from modes */
 	if (supply->supplied_from) {
-		if (!supplier->name)
+		if (!supplier->desc->name)
 			return false;
 		for (i = 0; i < supply->num_supplies; i++)
-			if (!strcmp(supplier->name, supply->supplied_from[i]))
+			if (!strcmp(supplier->desc->name, supply->supplied_from[i]))
 				return true;
 	} else {
-		if (!supply->name)
+		if (!supply->desc->name)
 			return false;
 		for (i = 0; i < supplier->num_supplicants; i++)
-			if (!strcmp(supplier->supplied_to[i], supply->name))
+			if (!strcmp(supplier->supplied_to[i], supply->desc->name))
 				return true;
 	}
 
@@ -62,8 +62,8 @@ static int __power_supply_changed_work(struct device *dev, void *data)
 	struct power_supply *pst = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(psy, pst)) {
-		if (pst->external_power_changed)
-			pst->external_power_changed(pst);
+		if (pst->desc->external_power_changed)
+			pst->desc->external_power_changed(pst);
 	}
 
 	return 0;
@@ -75,7 +75,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	struct power_supply *psy = container_of(work, struct power_supply,
 						changed_work);
 
-	dev_dbg(psy->dev, "%s\n", __func__);
+	dev_dbg(&psy->dev, "%s\n", __func__);
 
 	spin_lock_irqsave(&psy->changed_lock, flags);
 	/*
@@ -93,7 +93,7 @@ static void power_supply_changed_work(struct work_struct *work)
 		power_supply_update_leds(psy);
 		atomic_notifier_call_chain(&power_supply_notifier,
 				PSY_EVENT_PROP_CHANGED, psy);
-		kobject_uevent(&psy->dev->kobj, KOBJ_CHANGE);
+		kobject_uevent(&psy->dev.kobj, KOBJ_CHANGE);
 		spin_lock_irqsave(&psy->changed_lock, flags);
 	}
 
@@ -103,7 +103,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	 * to true.
 	 */
 	if (likely(!psy->changed))
-		pm_relax(psy->dev);
+		pm_relax(&psy->dev);
 	spin_unlock_irqrestore(&psy->changed_lock, flags);
 }
 
@@ -111,11 +111,11 @@ void power_supply_changed(struct power_supply *psy)
 {
 	unsigned long flags;
 
-	dev_dbg(psy->dev, "%s\n", __func__);
+	dev_dbg(&psy->dev, "%s\n", __func__);
 
 	spin_lock_irqsave(&psy->changed_lock, flags);
 	psy->changed = true;
-	pm_stay_awake(psy->dev);
+	pm_stay_awake(&psy->dev);
 	spin_unlock_irqrestore(&psy->changed_lock, flags);
 	schedule_work(&psy->changed_work);
 }
@@ -138,9 +138,9 @@ static int __power_supply_populate_supplied_from(struct device *dev,
 			break;
 
 		if (np == epsy->of_node) {
-			dev_info(psy->dev, "%s: Found supply : %s\n",
-				psy->name, epsy->name);
-			psy->supplied_from[i-1] = (char *)epsy->name;
+			dev_info(&psy->dev, "%s: Found supply : %s\n",
+				psy->desc->name, epsy->desc->name);
+			psy->supplied_from[i-1] = (char *)epsy->desc->name;
 			psy->num_supplies++;
 			of_node_put(np);
 			break;
@@ -158,7 +158,7 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 	error = class_for_each_device(power_supply_class, NULL, psy,
 				      __power_supply_populate_supplied_from);
 
-	dev_dbg(psy->dev, "%s %d\n", __func__, error);
+	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
 
 	return error;
 }
@@ -220,7 +220,7 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		of_node_put(np);
 
 		if (ret) {
-			dev_dbg(psy->dev, "Failed to find supply!\n");
+			dev_dbg(&psy->dev, "Failed to find supply!\n");
 			return ret;
 		}
 	} while (np);
@@ -230,17 +230,18 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return 0;
 
 	/* All supplies found, allocate char ** array for filling */
-	psy->supplied_from = devm_kzalloc(psy->dev, sizeof(psy->supplied_from),
+	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from) {
-		dev_err(psy->dev, "Couldn't allocate memory for supply list\n");
+		dev_err(&psy->dev, "Couldn't allocate memory for supply list\n");
 		return -ENOMEM;
 	}
 
-	*psy->supplied_from = devm_kzalloc(psy->dev, sizeof(char *) * (cnt - 1),
+	*psy->supplied_from = devm_kzalloc(&psy->dev,
+					   sizeof(char *) * (cnt - 1),
 					   GFP_KERNEL);
 	if (!*psy->supplied_from) {
-		dev_err(psy->dev, "Couldn't allocate memory for supply list\n");
+		dev_err(&psy->dev, "Couldn't allocate memory for supply list\n");
 		return -ENOMEM;
 	}
 
@@ -260,7 +261,8 @@ static int __power_supply_am_i_supplied(struct device *dev, void *data)
 	struct power_supply *epsy = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(epsy, psy))
-		if (!epsy->get_property(epsy, POWER_SUPPLY_PROP_ONLINE, &ret))
+		if (!epsy->desc->get_property(epsy, POWER_SUPPLY_PROP_ONLINE,
+					&ret))
 			return ret.intval;
 
 	return 0;
@@ -273,7 +275,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	error = class_for_each_device(power_supply_class, NULL, psy,
 				      __power_supply_am_i_supplied);
 
-	dev_dbg(psy->dev, "%s %d\n", __func__, error);
+	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
 
 	return error;
 }
@@ -286,8 +288,9 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
 	unsigned int *count = data;
 
 	(*count)++;
-	if (psy->type != POWER_SUPPLY_TYPE_BATTERY)
-		if (!psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &ret))
+	if (psy->desc->type != POWER_SUPPLY_TYPE_BATTERY)
+		if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+					&ret))
 			return ret.intval;
 
 	return 0;
@@ -315,9 +318,9 @@ EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
 int power_supply_set_battery_charged(struct power_supply *psy)
 {
 	if (atomic_read(&psy->use_cnt) >= 0 &&
-			psy->type == POWER_SUPPLY_TYPE_BATTERY &&
-			psy->set_charged) {
-		psy->set_charged(psy);
+			psy->desc->type == POWER_SUPPLY_TYPE_BATTERY &&
+			psy->desc->set_charged) {
+		psy->desc->set_charged(psy);
 		return 0;
 	}
 
@@ -330,7 +333,7 @@ static int power_supply_match_device_by_name(struct device *dev, const void *dat
 	const char *name = data;
 	struct power_supply *psy = dev_get_drvdata(dev);
 
-	return strcmp(psy->name, name) == 0;
+	return strcmp(psy->desc->name, name) == 0;
 }
 
 struct power_supply *power_supply_get_by_name(const char *name)
@@ -375,7 +378,7 @@ int power_supply_get_property(struct power_supply *psy,
 	if (atomic_read(&psy->use_cnt) <= 0)
 		return -ENODEV;
 
-	return psy->get_property(psy, psp, val);
+	return psy->desc->get_property(psy, psp, val);
 }
 EXPORT_SYMBOL_GPL(power_supply_get_property);
 
@@ -383,42 +386,45 @@ int power_supply_set_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 || !psy->set_property)
+	if (atomic_read(&psy->use_cnt) <= 0 || !psy->desc->set_property)
 		return -ENODEV;
 
-	return psy->set_property(psy, psp, val);
+	return psy->desc->set_property(psy, psp, val);
 }
 EXPORT_SYMBOL_GPL(power_supply_set_property);
 
 int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 || !psy->property_is_writeable)
+	if (atomic_read(&psy->use_cnt) <= 0 ||
+			!psy->desc->property_is_writeable)
 		return -ENODEV;
 
-	return psy->property_is_writeable(psy, psp);
+	return psy->desc->property_is_writeable(psy, psp);
 }
 EXPORT_SYMBOL_GPL(power_supply_property_is_writeable);
 
 void power_supply_external_power_changed(struct power_supply *psy)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 || !psy->external_power_changed)
+	if (atomic_read(&psy->use_cnt) <= 0 ||
+			!psy->desc->external_power_changed)
 		return;
 
-	psy->external_power_changed(psy);
+	psy->desc->external_power_changed(psy);
 }
 EXPORT_SYMBOL_GPL(power_supply_external_power_changed);
 
 int power_supply_powers(struct power_supply *psy, struct device *dev)
 {
-	return sysfs_create_link(&psy->dev->kobj, &dev->kobj, "powers");
+	return sysfs_create_link(&psy->dev.kobj, &dev->kobj, "powers");
 }
 EXPORT_SYMBOL_GPL(power_supply_powers);
 
 static void power_supply_dev_release(struct device *dev)
 {
+	struct power_supply *psy = container_of(dev, struct power_supply, dev);
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
-	kfree(dev);
+	kfree(psy);
 }
 
 int power_supply_reg_notifier(struct notifier_block *nb)
@@ -443,7 +449,7 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 
 	WARN_ON(tzd == NULL);
 	psy = tzd->devdata;
-	ret = psy->get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
+	ret = psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
 
 	/* Convert tenths of degree Celsius to milli degree Celsius. */
 	if (!ret)
@@ -460,14 +466,14 @@ static int psy_register_thermal(struct power_supply *psy)
 {
 	int i;
 
-	if (psy->no_thermal)
+	if (psy->desc->no_thermal)
 		return 0;
 
 	/* Register battery zone device psy reports temperature */
-	for (i = 0; i < psy->num_properties; i++) {
-		if (psy->properties[i] == POWER_SUPPLY_PROP_TEMP) {
-			psy->tzd = thermal_zone_device_register(psy->name, 0, 0,
-					psy, &psy_tzd_ops, NULL, 0, 0);
+	for (i = 0; i < psy->desc->num_properties; i++) {
+		if (psy->desc->properties[i] == POWER_SUPPLY_PROP_TEMP) {
+			psy->tzd = thermal_zone_device_register(psy->desc->name,
+					0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
 			return PTR_ERR_OR_ZERO(psy->tzd);
 		}
 	}
@@ -490,7 +496,7 @@ static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
 	int ret;
 
 	psy = tcd->devdata;
-	ret = psy->get_property(psy,
+	ret = psy->desc->get_property(psy,
 		POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX, &val);
 	if (!ret)
 		*state = val.intval;
@@ -506,7 +512,7 @@ static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *tcd,
 	int ret;
 
 	psy = tcd->devdata;
-	ret = psy->get_property(psy,
+	ret = psy->desc->get_property(psy,
 		POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
 	if (!ret)
 		*state = val.intval;
@@ -523,7 +529,7 @@ static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
 
 	psy = tcd->devdata;
 	val.intval = state;
-	ret = psy->set_property(psy,
+	ret = psy->desc->set_property(psy,
 		POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
 
 	return ret;
@@ -540,11 +546,11 @@ static int psy_register_cooler(struct power_supply *psy)
 	int i;
 
 	/* Register for cooling device if psy can control charging */
-	for (i = 0; i < psy->num_properties; i++) {
-		if (psy->properties[i] ==
+	for (i = 0; i < psy->desc->num_properties; i++) {
+		if (psy->desc->properties[i] ==
 				POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT) {
 			psy->tcd = thermal_cooling_device_register(
-							(char *)psy->name,
+							(char *)psy->desc->name,
 							psy, &psy_tcd_ops);
 			return PTR_ERR_OR_ZERO(psy->tcd);
 		}
@@ -578,17 +584,21 @@ static void psy_unregister_cooler(struct power_supply *psy)
 }
 #endif
 
-static int __power_supply_register(struct device *parent,
-				   struct power_supply *psy,
+static struct power_supply *__must_check
+__power_supply_register(struct device *parent,
+				   const struct power_supply_desc *desc,
 				   const struct power_supply_config *cfg,
 				   bool ws)
 {
 	struct device *dev;
+	struct power_supply *psy;
 	int rc;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
+	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
+	if (!psy)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &psy->dev;
 
 	device_initialize(dev);
 
@@ -597,7 +607,7 @@ static int __power_supply_register(struct device *parent,
 	dev->parent = parent;
 	dev->release = power_supply_dev_release;
 	dev_set_drvdata(dev, psy);
-	psy->dev = dev;
+	psy->desc = desc;
 	atomic_inc(&psy->use_cnt);
 	if (cfg) {
 		psy->drv_data = cfg->drv_data;
@@ -606,7 +616,7 @@ static int __power_supply_register(struct device *parent,
 		psy->num_supplicants = cfg->num_supplicants;
 	}
 
-	rc = dev_set_name(dev, "%s", psy->name);
+	rc = dev_set_name(dev, "%s", desc->name);
 	if (rc)
 		goto dev_set_name_failed;
 
@@ -641,7 +651,7 @@ static int __power_supply_register(struct device *parent,
 
 	power_supply_changed(psy);
 
-	return 0;
+	return psy;
 
 create_triggers_failed:
 	psy_unregister_cooler(psy);
@@ -654,33 +664,69 @@ wakeup_init_failed:
 check_supplies_failed:
 dev_set_name_failed:
 	put_device(dev);
-	return rc;
+	return ERR_PTR(rc);
 }
 
-int power_supply_register(struct device *parent, struct power_supply *psy,
+/**
+ * power_supply_register() - Register new power supply
+ * @parent:	Device to be a parent of power supply's device
+ * @desc:	Description of power supply, must be valid through whole
+ *		lifetime of this power supply
+ * @cfg:	Run-time specific configuration accessed during registering,
+ *		may be NULL
+ *
+ * Return: A pointer to newly allocated power_supply on success
+ * or ERR_PTR otherwise.
+ * Use power_supply_unregister() on returned power_supply pointer to release
+ * resources.
+ */
+struct power_supply *__must_check power_supply_register(struct device *parent,
+		const struct power_supply_desc *desc,
 		const struct power_supply_config *cfg)
 {
-	return __power_supply_register(parent, psy, cfg, true);
+	return __power_supply_register(parent, desc, cfg, true);
 }
 EXPORT_SYMBOL_GPL(power_supply_register);
 
-int power_supply_register_no_ws(struct device *parent, struct power_supply *psy,
+/**
+ * power_supply_register() - Register new non-waking-source power supply
+ * @parent:	Device to be a parent of power supply's device
+ * @desc:	Description of power supply, must be valid through whole
+ *		lifetime of this power supply
+ * @cfg:	Run-time specific configuration accessed during registering,
+ *		may be NULL
+ *
+ * Return: A pointer to newly allocated power_supply on success
+ * or ERR_PTR otherwise.
+ * Use power_supply_unregister() on returned power_supply pointer to release
+ * resources.
+ */
+struct power_supply *__must_check
+power_supply_register_no_ws(struct device *parent,
+		const struct power_supply_desc *desc,
 		const struct power_supply_config *cfg)
 {
-	return __power_supply_register(parent, psy, cfg, false);
+	return __power_supply_register(parent, desc, cfg, false);
 }
 EXPORT_SYMBOL_GPL(power_supply_register_no_ws);
 
+/**
+ * power_supply_unregister() - Remove this power supply from system
+ * @psy:	Pointer to power supply to unregister
+ *
+ * Remove this power supply from the system. The resources of power supply
+ * will be freed here or on last power_supply_put() call.
+ */
 void power_supply_unregister(struct power_supply *psy)
 {
 	WARN_ON(atomic_dec_return(&psy->use_cnt));
 	cancel_work_sync(&psy->changed_work);
-	sysfs_remove_link(&psy->dev->kobj, "powers");
+	sysfs_remove_link(&psy->dev.kobj, "powers");
 	power_supply_remove_triggers(psy);
 	psy_unregister_cooler(psy);
 	psy_unregister_thermal(psy);
-	device_init_wakeup(psy->dev, false);
-	device_unregister(psy->dev);
+	device_init_wakeup(&psy->dev, false);
+	device_unregister(&psy->dev);
 }
 EXPORT_SYMBOL_GPL(power_supply_unregister);
 
diff --git a/drivers/power/power_supply_leds.c b/drivers/power/power_supply_leds.c
index effa093c37b0..2d41a43fc81a 100644
--- a/drivers/power/power_supply_leds.c
+++ b/drivers/power/power_supply_leds.c
@@ -25,10 +25,10 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 	unsigned long delay_on = 0;
 	unsigned long delay_off = 0;
 
-	if (psy->get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
+	if (psy->desc->get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
 		return;
 
-	dev_dbg(psy->dev, "%s %d\n", __func__, status.intval);
+	dev_dbg(&psy->dev, "%s %d\n", __func__, status.intval);
 
 	switch (status.intval) {
 	case POWER_SUPPLY_STATUS_FULL:
@@ -58,21 +58,21 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 static int power_supply_create_bat_triggers(struct power_supply *psy)
 {
 	psy->charging_full_trig_name = kasprintf(GFP_KERNEL,
-					"%s-charging-or-full", psy->name);
+					"%s-charging-or-full", psy->desc->name);
 	if (!psy->charging_full_trig_name)
 		goto charging_full_failed;
 
 	psy->charging_trig_name = kasprintf(GFP_KERNEL,
-					"%s-charging", psy->name);
+					"%s-charging", psy->desc->name);
 	if (!psy->charging_trig_name)
 		goto charging_failed;
 
-	psy->full_trig_name = kasprintf(GFP_KERNEL, "%s-full", psy->name);
+	psy->full_trig_name = kasprintf(GFP_KERNEL, "%s-full", psy->desc->name);
 	if (!psy->full_trig_name)
 		goto full_failed;
 
 	psy->charging_blink_full_solid_trig_name = kasprintf(GFP_KERNEL,
-		"%s-charging-blink-full-solid", psy->name);
+		"%s-charging-blink-full-solid", psy->desc->name);
 	if (!psy->charging_blink_full_solid_trig_name)
 		goto charging_blink_full_solid_failed;
 
@@ -115,10 +115,10 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 {
 	union power_supply_propval online;
 
-	if (psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &online))
+	if (psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &online))
 		return;
 
-	dev_dbg(psy->dev, "%s %d\n", __func__, online.intval);
+	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
 
 	if (online.intval)
 		led_trigger_event(psy->online_trig, LED_FULL);
@@ -128,7 +128,8 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 
 static int power_supply_create_gen_triggers(struct power_supply *psy)
 {
-	psy->online_trig_name = kasprintf(GFP_KERNEL, "%s-online", psy->name);
+	psy->online_trig_name = kasprintf(GFP_KERNEL, "%s-online",
+					  psy->desc->name);
 	if (!psy->online_trig_name)
 		return -ENOMEM;
 
@@ -147,7 +148,7 @@ static void power_supply_remove_gen_triggers(struct power_supply *psy)
 
 void power_supply_update_leds(struct power_supply *psy)
 {
-	if (psy->type == POWER_SUPPLY_TYPE_BATTERY)
+	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
 		power_supply_update_bat_leds(psy);
 	else
 		power_supply_update_gen_leds(psy);
@@ -155,14 +156,14 @@ void power_supply_update_leds(struct power_supply *psy)
 
 int power_supply_create_triggers(struct power_supply *psy)
 {
-	if (psy->type == POWER_SUPPLY_TYPE_BATTERY)
+	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
 		return power_supply_create_bat_triggers(psy);
 	return power_supply_create_gen_triggers(psy);
 }
 
 void power_supply_remove_triggers(struct power_supply *psy)
 {
-	if (psy->type == POWER_SUPPLY_TYPE_BATTERY)
+	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
 		power_supply_remove_bat_triggers(psy);
 	else
 		power_supply_remove_gen_triggers(psy);
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index f817aab80813..9134e3d2d95e 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -74,7 +74,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 	union power_supply_propval value;
 
 	if (off == POWER_SUPPLY_PROP_TYPE) {
-		value.intval = psy->type;
+		value.intval = psy->desc->type;
 	} else {
 		ret = power_supply_get_property(psy, off, &value);
 
@@ -125,7 +125,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 
 	value.intval = long_val;
 
-	ret = power_supply_set_property(psy, off, &value);
+	ret = psy->desc->set_property(psy, off, &value);
 	if (ret < 0)
 		return ret;
 
@@ -218,11 +218,11 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
-	for (i = 0; i < psy->num_properties; i++) {
-		int property = psy->properties[i];
+	for (i = 0; i < psy->desc->num_properties; i++) {
+		int property = psy->desc->properties[i];
 
 		if (property == attrno) {
-			if (psy->property_is_writeable &&
+			if (psy->desc->property_is_writeable &&
 			    power_supply_property_is_writeable(psy, property) > 0)
 				mode |= S_IWUSR;
 
@@ -279,14 +279,14 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 	dev_dbg(dev, "uevent\n");
 
-	if (!psy || !psy->dev) {
+	if (!psy || !psy->desc) {
 		dev_dbg(dev, "No power supply yet\n");
 		return ret;
 	}
 
-	dev_dbg(dev, "POWER_SUPPLY_NAME=%s\n", psy->name);
+	dev_dbg(dev, "POWER_SUPPLY_NAME=%s\n", psy->desc->name);
 
-	ret = add_uevent_var(env, "POWER_SUPPLY_NAME=%s", psy->name);
+	ret = add_uevent_var(env, "POWER_SUPPLY_NAME=%s", psy->desc->name);
 	if (ret)
 		return ret;
 
@@ -294,11 +294,11 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (!prop_buf)
 		return -ENOMEM;
 
-	for (j = 0; j < psy->num_properties; j++) {
+	for (j = 0; j < psy->desc->num_properties; j++) {
 		struct device_attribute *attr;
 		char *line;
 
-		attr = &power_supply_attrs[psy->properties[j]];
+		attr = &power_supply_attrs[psy->desc->properties[j]];
 
 		ret = power_supply_show_property(dev, attr, prop_buf);
 		if (ret == -ENODEV || ret == -ENODATA) {
diff --git a/drivers/power/rt5033_battery.c b/drivers/power/rt5033_battery.c
index fa0da8fd289c..68a49f0fd92f 100644
--- a/drivers/power/rt5033_battery.c
+++ b/drivers/power/rt5033_battery.c
@@ -72,8 +72,7 @@ static int rt5033_battery_get_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		union power_supply_propval *val)
 {
-	struct rt5033_battery *battery = container_of(psy,
-				struct rt5033_battery, psy);
+	struct rt5033_battery *battery = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -108,10 +107,19 @@ static struct regmap_config rt5033_battery_regmap_config = {
 	.max_register	= RT5033_FUEL_REG_END,
 };
 
+static const struct power_supply_desc rt5033_battery_desc = {
+	.name		= "rt5033-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= rt5033_battery_get_property,
+	.properties	= rt5033_battery_props,
+	.num_properties	= ARRAY_SIZE(rt5033_battery_props),
+};
+
 static int rt5033_battery_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct power_supply_config psy_cfg = {};
 	struct rt5033_battery *battery;
 	u32 ret;
 
@@ -131,16 +139,13 @@ static int rt5033_battery_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, battery);
+	psy_cfg.drv_data = battery;
 
-	battery->psy.name		= "rt5033-battery";
-	battery->psy.type		= POWER_SUPPLY_TYPE_BATTERY;
-	battery->psy.get_property	= rt5033_battery_get_property;
-	battery->psy.properties		= rt5033_battery_props;
-	battery->psy.num_properties	= ARRAY_SIZE(rt5033_battery_props);
-
-	ret = power_supply_register(&client->dev, &battery->psy, NULL);
-	if (ret) {
+	battery->psy = power_supply_register(&client->dev,
+					     &rt5033_battery_desc, &psy_cfg);
+	if (IS_ERR(battery->psy)) {
 		dev_err(&client->dev, "Failed to register power supply\n");
+		ret = PTR_ERR(battery->psy);
 		return ret;
 	}
 
@@ -151,7 +156,7 @@ static int rt5033_battery_remove(struct i2c_client *client)
 {
 	struct rt5033_battery *battery = i2c_get_clientdata(client);
 
-	power_supply_unregister(&battery->psy);
+	power_supply_unregister(battery->psy);
 
 	return 0;
 }
diff --git a/drivers/power/rx51_battery.c b/drivers/power/rx51_battery.c
index 804f60c7b715..ac6206951d58 100644
--- a/drivers/power/rx51_battery.c
+++ b/drivers/power/rx51_battery.c
@@ -29,7 +29,8 @@
 
 struct rx51_device_info {
 	struct device *dev;
-	struct power_supply bat;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
 	struct iio_channel *channel_temp;
 	struct iio_channel *channel_bsi;
 	struct iio_channel *channel_vbat;
@@ -161,8 +162,7 @@ static int rx51_battery_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct rx51_device_info *di = container_of((psy),
-				struct rx51_device_info, bat);
+	struct rx51_device_info *di = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
@@ -204,6 +204,7 @@ static enum power_supply_property rx51_battery_props[] = {
 
 static int rx51_battery_probe(struct platform_device *pdev)
 {
+	struct power_supply_config psy_cfg = {};
 	struct rx51_device_info *di;
 	int ret;
 
@@ -214,11 +215,13 @@ static int rx51_battery_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, di);
 
 	di->dev = &pdev->dev;
-	di->bat.name = dev_name(&pdev->dev);
-	di->bat.type = POWER_SUPPLY_TYPE_BATTERY;
-	di->bat.properties = rx51_battery_props;
-	di->bat.num_properties = ARRAY_SIZE(rx51_battery_props);
-	di->bat.get_property = rx51_battery_get_property;
+	di->bat_desc.name = dev_name(&pdev->dev);
+	di->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	di->bat_desc.properties = rx51_battery_props;
+	di->bat_desc.num_properties = ARRAY_SIZE(rx51_battery_props);
+	di->bat_desc.get_property = rx51_battery_get_property;
+
+	psy_cfg.drv_data = di;
 
 	di->channel_temp = iio_channel_get(di->dev, "temp");
 	if (IS_ERR(di->channel_temp)) {
@@ -238,9 +241,11 @@ static int rx51_battery_probe(struct platform_device *pdev)
 		goto error_channel_bsi;
 	}
 
-	ret = power_supply_register(di->dev, &di->bat, NULL);
-	if (ret)
+	di->bat = power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
+	if (IS_ERR(di->bat)) {
+		ret = PTR_ERR(di->bat);
 		goto error_channel_vbat;
+	}
 
 	return 0;
 
@@ -259,7 +264,7 @@ static int rx51_battery_remove(struct platform_device *pdev)
 {
 	struct rx51_device_info *di = platform_get_drvdata(pdev);
 
-	power_supply_unregister(&di->bat);
+	power_supply_unregister(di->bat);
 
 	iio_channel_release(di->channel_vbat);
 	iio_channel_release(di->channel_bsi);
diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/s3c_adc_battery.c
index b6ff213373dd..0ffe5cd3abf6 100644
--- a/drivers/power/s3c_adc_battery.c
+++ b/drivers/power/s3c_adc_battery.c
@@ -28,7 +28,7 @@
 #define JITTER_DELAY			500 /* ms */
 
 struct s3c_adc_bat {
-	struct power_supply		psy;
+	struct power_supply		*psy;
 	struct s3c_adc_client		*client;
 	struct s3c_adc_bat_pdata	*pdata;
 	int				volt_value;
@@ -73,10 +73,10 @@ static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct s3c_adc_bat *bat = container_of(psy, struct s3c_adc_bat, psy);
+	struct s3c_adc_bat *bat = power_supply_get_drvdata(psy);
 
 	if (!bat) {
-		dev_err(psy->dev, "%s: no battery infos ?!\n", __func__);
+		dev_err(&psy->dev, "%s: no battery infos ?!\n", __func__);
 		return -EINVAL;
 	}
 
@@ -105,17 +105,17 @@ static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
 	}
 }
 
-static struct s3c_adc_bat backup_bat = {
-	.psy = {
-		.name		= "backup-battery",
-		.type		= POWER_SUPPLY_TYPE_BATTERY,
-		.properties	= s3c_adc_backup_bat_props,
-		.num_properties = ARRAY_SIZE(s3c_adc_backup_bat_props),
-		.get_property	= s3c_adc_backup_bat_get_property,
-		.use_for_apm	= 1,
-	},
+static const struct power_supply_desc backup_bat_desc = {
+	.name		= "backup-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= s3c_adc_backup_bat_props,
+	.num_properties = ARRAY_SIZE(s3c_adc_backup_bat_props),
+	.get_property	= s3c_adc_backup_bat_get_property,
+	.use_for_apm	= 1,
 };
 
+static struct s3c_adc_bat backup_bat;
+
 static enum power_supply_property s3c_adc_main_bat_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
@@ -141,7 +141,7 @@ static int s3c_adc_bat_get_property(struct power_supply *psy,
 				    enum power_supply_property psp,
 				    union power_supply_propval *val)
 {
-	struct s3c_adc_bat *bat = container_of(psy, struct s3c_adc_bat, psy);
+	struct s3c_adc_bat *bat = power_supply_get_drvdata(psy);
 
 	int new_level;
 	int full_volt;
@@ -149,7 +149,7 @@ static int s3c_adc_bat_get_property(struct power_supply *psy,
 	unsigned int lut_size;
 
 	if (!bat) {
-		dev_err(psy->dev, "no battery infos ?!\n");
+		dev_err(&psy->dev, "no battery infos ?!\n");
 		return -EINVAL;
 	}
 
@@ -232,18 +232,18 @@ static int s3c_adc_bat_get_property(struct power_supply *psy,
 	}
 }
 
-static struct s3c_adc_bat main_bat = {
-	.psy = {
-		.name			= "main-battery",
-		.type			= POWER_SUPPLY_TYPE_BATTERY,
-		.properties		= s3c_adc_main_bat_props,
-		.num_properties		= ARRAY_SIZE(s3c_adc_main_bat_props),
-		.get_property		= s3c_adc_bat_get_property,
-		.external_power_changed = s3c_adc_bat_ext_power_changed,
-		.use_for_apm		= 1,
-	},
+static const struct power_supply_desc main_bat_desc = {
+	.name			= "main-battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= s3c_adc_main_bat_props,
+	.num_properties		= ARRAY_SIZE(s3c_adc_main_bat_props),
+	.get_property		= s3c_adc_bat_get_property,
+	.external_power_changed = s3c_adc_bat_ext_power_changed,
+	.use_for_apm		= 1,
 };
 
+static struct s3c_adc_bat main_bat;
+
 static void s3c_adc_bat_work(struct work_struct *work)
 {
 	struct s3c_adc_bat *bat = &main_bat;
@@ -251,7 +251,7 @@ static void s3c_adc_bat_work(struct work_struct *work)
 	int is_plugged;
 	static int was_plugged;
 
-	is_plugged = power_supply_am_i_supplied(&bat->psy);
+	is_plugged = power_supply_am_i_supplied(bat->psy);
 	bat->cable_plugged = is_plugged;
 	if (is_plugged != was_plugged) {
 		was_plugged = is_plugged;
@@ -279,7 +279,7 @@ static void s3c_adc_bat_work(struct work_struct *work)
 		}
 	}
 
-	power_supply_changed(&bat->psy);
+	power_supply_changed(bat->psy);
 }
 
 static irqreturn_t s3c_adc_bat_charged(int irq, void *dev_id)
@@ -310,16 +310,25 @@ static int s3c_adc_bat_probe(struct platform_device *pdev)
 	main_bat.cable_plugged = 0;
 	main_bat.status = POWER_SUPPLY_STATUS_DISCHARGING;
 
-	ret = power_supply_register(&pdev->dev, &main_bat.psy, NULL);
-	if (ret)
+	main_bat.psy = power_supply_register(&pdev->dev, &main_bat_desc, NULL);
+	if (IS_ERR(main_bat.psy)) {
+		ret = PTR_ERR(main_bat.psy);
 		goto err_reg_main;
+	}
 	if (pdata->backup_volt_mult) {
+		const struct power_supply_config psy_cfg
+						= { .drv_data = &backup_bat, };
+
 		backup_bat.client = client;
 		backup_bat.pdata = pdev->dev.platform_data;
 		backup_bat.volt_value = -1;
-		ret = power_supply_register(&pdev->dev, &backup_bat.psy, NULL);
-		if (ret)
+		backup_bat.psy = power_supply_register(&pdev->dev,
+						       &backup_bat_desc,
+						       &psy_cfg);
+		if (IS_ERR(backup_bat.psy)) {
+			ret = PTR_ERR(backup_bat.psy);
 			goto err_reg_backup;
+		}
 	}
 
 	INIT_DELAYED_WORK(&bat_work, s3c_adc_bat_work);
@@ -360,9 +369,9 @@ err_irq:
 		gpio_free(pdata->gpio_charge_finished);
 err_gpio:
 	if (pdata->backup_volt_mult)
-		power_supply_unregister(&backup_bat.psy);
+		power_supply_unregister(backup_bat.psy);
 err_reg_backup:
-	power_supply_unregister(&main_bat.psy);
+	power_supply_unregister(main_bat.psy);
 err_reg_main:
 	return ret;
 }
@@ -372,9 +381,9 @@ static int s3c_adc_bat_remove(struct platform_device *pdev)
 	struct s3c_adc_client *client = platform_get_drvdata(pdev);
 	struct s3c_adc_bat_pdata *pdata = pdev->dev.platform_data;
 
-	power_supply_unregister(&main_bat.psy);
+	power_supply_unregister(main_bat.psy);
 	if (pdata->backup_volt_mult)
-		power_supply_unregister(&backup_bat.psy);
+		power_supply_unregister(backup_bat.psy);
 
 	s3c_adc_release(client);
 
diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index 879f1448fc4a..de1178659d4b 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -156,7 +156,7 @@ static enum power_supply_property sbs_properties[] = {
 
 struct sbs_info {
 	struct i2c_client		*client;
-	struct power_supply		power_supply;
+	struct power_supply		*power_supply;
 	struct sbs_platform_data	*pdata;
 	bool				is_present;
 	bool				gpio_detect;
@@ -391,7 +391,7 @@ static int sbs_get_battery_property(struct i2c_client *client,
 			chip->last_state = val->intval;
 		else if (chip->last_state != val->intval) {
 			cancel_delayed_work_sync(&chip->work);
-			power_supply_changed(&chip->power_supply);
+			power_supply_changed(chip->power_supply);
 			chip->poll_time = 0;
 		}
 	} else {
@@ -556,8 +556,7 @@ static int sbs_get_property(struct power_supply *psy,
 	union power_supply_propval *val)
 {
 	int ret = 0;
-	struct sbs_info *chip = container_of(psy,
-				struct sbs_info, power_supply);
+	struct sbs_info *chip = power_supply_get_drvdata(psy);
 	struct i2c_client *client = chip->client;
 
 	switch (psp) {
@@ -638,7 +637,7 @@ static int sbs_get_property(struct power_supply *psy,
 	if (!chip->gpio_detect &&
 		chip->is_present != (ret >= 0)) {
 		chip->is_present = (ret >= 0);
-		power_supply_changed(&chip->power_supply);
+		power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -671,9 +670,7 @@ static irqreturn_t sbs_irq(int irq, void *devid)
 
 static void sbs_external_power_changed(struct power_supply *psy)
 {
-	struct sbs_info *chip;
-
-	chip = container_of(psy, struct sbs_info, power_supply);
+	struct sbs_info *chip = power_supply_get_drvdata(psy);
 
 	if (chip->ignore_changes > 0) {
 		chip->ignore_changes--;
@@ -712,7 +709,7 @@ static void sbs_delayed_work(struct work_struct *work)
 
 	if (chip->last_state != ret) {
 		chip->poll_time = 0;
-		power_supply_changed(&chip->power_supply);
+		power_supply_changed(chip->power_supply);
 		return;
 	}
 	if (chip->poll_time > 0) {
@@ -796,43 +793,48 @@ static struct sbs_platform_data *sbs_of_populate_pdata(
 }
 #endif
 
+static const struct power_supply_desc sbs_default_desc = {
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = sbs_properties,
+	.num_properties = ARRAY_SIZE(sbs_properties),
+	.get_property = sbs_get_property,
+	.external_power_changed = sbs_external_power_changed,
+};
+
 static int sbs_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	struct sbs_info *chip;
+	struct power_supply_desc *sbs_desc;
 	struct sbs_platform_data *pdata = client->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
 	int rc;
 	int irq;
-	char *name;
 
-	name = kasprintf(GFP_KERNEL, "sbs-%s", dev_name(&client->dev));
-	if (!name) {
-		dev_err(&client->dev, "Failed to allocate device name\n");
+	sbs_desc = devm_kmemdup(&client->dev, &sbs_default_desc,
+			sizeof(*sbs_desc), GFP_KERNEL);
+	if (!sbs_desc)
+		return -ENOMEM;
+
+	sbs_desc->name = devm_kasprintf(&client->dev, GFP_KERNEL, "sbs-%s",
+			dev_name(&client->dev));
+	if (!sbs_desc->name)
 		return -ENOMEM;
-	}
 
 	chip = kzalloc(sizeof(struct sbs_info), GFP_KERNEL);
-	if (!chip) {
-		rc = -ENOMEM;
-		goto exit_free_name;
-	}
+	if (!chip)
+		return -ENOMEM;
 
 	chip->client = client;
 	chip->enable_detection = false;
 	chip->gpio_detect = false;
-	chip->power_supply.name = name;
-	chip->power_supply.type = POWER_SUPPLY_TYPE_BATTERY;
-	chip->power_supply.properties = sbs_properties;
-	chip->power_supply.num_properties = ARRAY_SIZE(sbs_properties);
-	chip->power_supply.get_property = sbs_get_property;
 	psy_cfg.of_node = client->dev.of_node;
+	psy_cfg.drv_data = chip;
 	/* ignore first notification of external change, it is generated
 	 * from the power_supply_register call back
 	 */
 	chip->ignore_changes = 1;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
-	chip->power_supply.external_power_changed = sbs_external_power_changed;
 
 	pdata = sbs_of_populate_pdata(client);
 
@@ -871,7 +873,7 @@ static int sbs_probe(struct i2c_client *client,
 
 	rc = request_irq(irq, sbs_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-		dev_name(&client->dev), &chip->power_supply);
+		dev_name(&client->dev), chip->power_supply);
 	if (rc) {
 		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
 		gpio_free(pdata->battery_detect);
@@ -893,11 +895,12 @@ skip_gpio:
 		goto exit_psupply;
 	}
 
-	rc = power_supply_register(&client->dev, &chip->power_supply,
-			&psy_cfg);
-	if (rc) {
+	chip->power_supply = power_supply_register(&client->dev, sbs_desc,
+						   &psy_cfg);
+	if (IS_ERR(chip->power_supply)) {
 		dev_err(&client->dev,
 			"%s: Failed to register power supply\n", __func__);
+		rc = PTR_ERR(chip->power_supply);
 		goto exit_psupply;
 	}
 
@@ -912,15 +915,12 @@ skip_gpio:
 
 exit_psupply:
 	if (chip->irq)
-		free_irq(chip->irq, &chip->power_supply);
+		free_irq(chip->irq, chip->power_supply);
 	if (chip->gpio_detect)
 		gpio_free(pdata->battery_detect);
 
 	kfree(chip);
 
-exit_free_name:
-	kfree(name);
-
 	return rc;
 }
 
@@ -929,15 +929,14 @@ static int sbs_remove(struct i2c_client *client)
 	struct sbs_info *chip = i2c_get_clientdata(client);
 
 	if (chip->irq)
-		free_irq(chip->irq, &chip->power_supply);
+		free_irq(chip->irq, chip->power_supply);
 	if (chip->gpio_detect)
 		gpio_free(chip->pdata->battery_detect);
 
-	power_supply_unregister(&chip->power_supply);
+	power_supply_unregister(chip->power_supply);
 
 	cancel_delayed_work_sync(&chip->work);
 
-	kfree(chip->power_supply.name);
 	kfree(chip);
 	chip = NULL;
 
diff --git a/drivers/power/smb347-charger.c b/drivers/power/smb347-charger.c
index 5999e1b85983..ff4b275d2cf4 100644
--- a/drivers/power/smb347-charger.c
+++ b/drivers/power/smb347-charger.c
@@ -139,9 +139,9 @@ struct smb347_charger {
 	struct mutex		lock;
 	struct device		*dev;
 	struct regmap		*regmap;
-	struct power_supply	mains;
-	struct power_supply	usb;
-	struct power_supply	battery;
+	struct power_supply	*mains;
+	struct power_supply	*usb;
+	struct power_supply	*battery;
 	bool			mains_online;
 	bool			usb_online;
 	bool			charging_enabled;
@@ -741,7 +741,7 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	 */
 	if (stat_c & STAT_C_CHARGER_ERROR) {
 		dev_err(smb->dev, "charging stopped due to charger error\n");
-		power_supply_changed(&smb->battery);
+		power_supply_changed(smb->battery);
 		handled = true;
 	}
 
@@ -752,7 +752,7 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	 */
 	if (irqstat_c & (IRQSTAT_C_TERMINATION_IRQ | IRQSTAT_C_TAPER_IRQ)) {
 		if (irqstat_c & IRQSTAT_C_TERMINATION_STAT)
-			power_supply_changed(&smb->battery);
+			power_supply_changed(smb->battery);
 		dev_dbg(smb->dev, "going to HW maintenance mode\n");
 		handled = true;
 	}
@@ -766,7 +766,7 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 
 		if (irqstat_d & IRQSTAT_D_CHARGE_TIMEOUT_STAT)
 			dev_warn(smb->dev, "charging stopped due to timeout\n");
-		power_supply_changed(&smb->battery);
+		power_supply_changed(smb->battery);
 		handled = true;
 	}
 
@@ -778,9 +778,9 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 		if (smb347_update_ps_status(smb) > 0) {
 			smb347_start_stop_charging(smb);
 			if (smb->pdata->use_mains)
-				power_supply_changed(&smb->mains);
+				power_supply_changed(smb->mains);
 			if (smb->pdata->use_usb)
-				power_supply_changed(&smb->usb);
+				power_supply_changed(smb->usb);
 		}
 		handled = true;
 	}
@@ -934,8 +934,7 @@ static int smb347_mains_get_property(struct power_supply *psy,
 				     enum power_supply_property prop,
 				     union power_supply_propval *val)
 {
-	struct smb347_charger *smb =
-		container_of(psy, struct smb347_charger, mains);
+	struct smb347_charger *smb = power_supply_get_drvdata(psy);
 	int ret;
 
 	switch (prop) {
@@ -976,8 +975,7 @@ static int smb347_usb_get_property(struct power_supply *psy,
 				   enum power_supply_property prop,
 				   union power_supply_propval *val)
 {
-	struct smb347_charger *smb =
-		container_of(psy, struct smb347_charger, usb);
+	struct smb347_charger *smb = power_supply_get_drvdata(psy);
 	int ret;
 
 	switch (prop) {
@@ -1063,8 +1061,7 @@ static int smb347_battery_get_property(struct power_supply *psy,
 				       enum power_supply_property prop,
 				       union power_supply_propval *val)
 {
-	struct smb347_charger *smb =
-			container_of(psy, struct smb347_charger, battery);
+	struct smb347_charger *smb = power_supply_get_drvdata(psy);
 	const struct smb347_charger_platform_data *pdata = smb->pdata;
 	int ret;
 
@@ -1188,12 +1185,36 @@ static const struct regmap_config smb347_regmap = {
 	.readable_reg	= smb347_readable_reg,
 };
 
+static const struct power_supply_desc smb347_mains_desc = {
+	.name		= "smb347-mains",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.get_property	= smb347_mains_get_property,
+	.properties	= smb347_mains_properties,
+	.num_properties	= ARRAY_SIZE(smb347_mains_properties),
+};
+
+static const struct power_supply_desc smb347_usb_desc = {
+	.name		= "smb347-usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.get_property	= smb347_usb_get_property,
+	.properties	= smb347_usb_properties,
+	.num_properties	= ARRAY_SIZE(smb347_usb_properties),
+};
+
+static const struct power_supply_desc smb347_battery_desc = {
+	.name		= "smb347-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property	= smb347_battery_get_property,
+	.properties	= smb347_battery_properties,
+	.num_properties	= ARRAY_SIZE(smb347_battery_properties),
+};
+
 static int smb347_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	static char *battery[] = { "smb347-battery" };
 	const struct smb347_charger_platform_data *pdata;
-	struct power_supply_config psy_cfg = {}; /* Only for mains and usb */
+	struct power_supply_config mains_usb_cfg = {}, battery_cfg = {};
 	struct device *dev = &client->dev;
 	struct smb347_charger *smb;
 	int ret;
@@ -1223,47 +1244,35 @@ static int smb347_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	psy_cfg.supplied_to = battery;
-	psy_cfg.num_supplicants = ARRAY_SIZE(battery);
+	mains_usb_cfg.supplied_to = battery;
+	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
+	mains_usb_cfg.drv_data = smb;
 	if (smb->pdata->use_mains) {
-		smb->mains.name = "smb347-mains";
-		smb->mains.type = POWER_SUPPLY_TYPE_MAINS;
-		smb->mains.get_property = smb347_mains_get_property;
-		smb->mains.properties = smb347_mains_properties;
-		smb->mains.num_properties = ARRAY_SIZE(smb347_mains_properties);
-		ret = power_supply_register(dev, &smb->mains, &psy_cfg);
-		if (ret < 0)
-			return ret;
+		smb->mains = power_supply_register(dev, &smb347_mains_desc,
+						   &mains_usb_cfg);
+		if (IS_ERR(smb->mains))
+			return PTR_ERR(smb->mains);
 	}
 
 	if (smb->pdata->use_usb) {
-		smb->usb.name = "smb347-usb";
-		smb->usb.type = POWER_SUPPLY_TYPE_USB;
-		smb->usb.get_property = smb347_usb_get_property;
-		smb->usb.properties = smb347_usb_properties;
-		smb->usb.num_properties = ARRAY_SIZE(smb347_usb_properties);
-		ret = power_supply_register(dev, &smb->usb, &psy_cfg);
-		if (ret < 0) {
+		smb->usb = power_supply_register(dev, &smb347_usb_desc,
+						 &mains_usb_cfg);
+		if (IS_ERR(smb->usb)) {
 			if (smb->pdata->use_mains)
-				power_supply_unregister(&smb->mains);
-			return ret;
+				power_supply_unregister(smb->mains);
+			return PTR_ERR(smb->usb);
 		}
 	}
 
-	smb->battery.name = "smb347-battery";
-	smb->battery.type = POWER_SUPPLY_TYPE_BATTERY;
-	smb->battery.get_property = smb347_battery_get_property;
-	smb->battery.properties = smb347_battery_properties;
-	smb->battery.num_properties = ARRAY_SIZE(smb347_battery_properties);
-
-
-	ret = power_supply_register(dev, &smb->battery, NULL);
-	if (ret < 0) {
+	battery_cfg.drv_data = smb;
+	smb->battery = power_supply_register(dev, &smb347_battery_desc,
+					     &battery_cfg);
+	if (IS_ERR(smb->battery)) {
 		if (smb->pdata->use_usb)
-			power_supply_unregister(&smb->usb);
+			power_supply_unregister(smb->usb);
 		if (smb->pdata->use_mains)
-			power_supply_unregister(&smb->mains);
-		return ret;
+			power_supply_unregister(smb->mains);
+		return PTR_ERR(smb->battery);
 	}
 
 	/*
@@ -1293,11 +1302,11 @@ static int smb347_remove(struct i2c_client *client)
 		gpio_free(smb->pdata->irq_gpio);
 	}
 
-	power_supply_unregister(&smb->battery);
+	power_supply_unregister(smb->battery);
 	if (smb->pdata->use_usb)
-		power_supply_unregister(&smb->usb);
+		power_supply_unregister(smb->usb);
 	if (smb->pdata->use_mains)
-		power_supply_unregister(&smb->mains);
+		power_supply_unregister(smb->mains);
 	return 0;
 }
 
diff --git a/drivers/power/test_power.c b/drivers/power/test_power.c
index f6c92d1d7811..f986e0cca7ac 100644
--- a/drivers/power/test_power.c
+++ b/drivers/power/test_power.c
@@ -153,7 +153,9 @@ static char *test_power_ac_supplied_to[] = {
 	"test_battery",
 };
 
-static struct power_supply test_power_supplies[] = {
+static struct power_supply *test_power_supplies[TEST_POWER_NUM];
+
+static const struct power_supply_desc test_power_desc[] = {
 	[TEST_AC] = {
 		.name = "test_ac",
 		.type = POWER_SUPPLY_TYPE_MAINS,
@@ -200,11 +202,13 @@ static int __init test_power_init(void)
 	BUILD_BUG_ON(TEST_POWER_NUM != ARRAY_SIZE(test_power_configs));
 
 	for (i = 0; i < ARRAY_SIZE(test_power_supplies); i++) {
-		ret = power_supply_register(NULL, &test_power_supplies[i],
+		test_power_supplies[i] = power_supply_register(NULL,
+						&test_power_desc[i],
 						&test_power_configs[i]);
-		if (ret) {
+		if (IS_ERR(test_power_supplies[i])) {
 			pr_err("%s: failed to register %s\n", __func__,
-				test_power_supplies[i].name);
+				test_power_desc[i].name);
+			ret = PTR_ERR(test_power_supplies[i]);
 			goto failed;
 		}
 	}
@@ -213,7 +217,7 @@ static int __init test_power_init(void)
 	return 0;
 failed:
 	while (--i >= 0)
-		power_supply_unregister(&test_power_supplies[i]);
+		power_supply_unregister(test_power_supplies[i]);
 	return ret;
 }
 module_init(test_power_init);
@@ -227,13 +231,13 @@ static void __exit test_power_exit(void)
 	usb_online = 0;
 	battery_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	for (i = 0; i < ARRAY_SIZE(test_power_supplies); i++)
-		power_supply_changed(&test_power_supplies[i]);
+		power_supply_changed(test_power_supplies[i]);
 	pr_info("%s: 'changed' event sent, sleeping for 10 seconds...\n",
 		__func__);
 	ssleep(10);
 
 	for (i = 0; i < ARRAY_SIZE(test_power_supplies); i++)
-		power_supply_unregister(&test_power_supplies[i]);
+		power_supply_unregister(test_power_supplies[i]);
 
 	module_initialized = false;
 }
@@ -331,7 +335,7 @@ static inline void signal_power_supply_changed(struct power_supply *psy)
 static int param_set_ac_online(const char *key, const struct kernel_param *kp)
 {
 	ac_online = map_get_value(map_ac_online, key, ac_online);
-	signal_power_supply_changed(&test_power_supplies[TEST_AC]);
+	signal_power_supply_changed(test_power_supplies[TEST_AC]);
 	return 0;
 }
 
@@ -344,7 +348,7 @@ static int param_get_ac_online(char *buffer, const struct kernel_param *kp)
 static int param_set_usb_online(const char *key, const struct kernel_param *kp)
 {
 	usb_online = map_get_value(map_ac_online, key, usb_online);
-	signal_power_supply_changed(&test_power_supplies[TEST_USB]);
+	signal_power_supply_changed(test_power_supplies[TEST_USB]);
 	return 0;
 }
 
@@ -358,7 +362,7 @@ static int param_set_battery_status(const char *key,
 					const struct kernel_param *kp)
 {
 	battery_status = map_get_value(map_status, key, battery_status);
-	signal_power_supply_changed(&test_power_supplies[TEST_BATTERY]);
+	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
 	return 0;
 }
 
@@ -372,7 +376,7 @@ static int param_set_battery_health(const char *key,
 					const struct kernel_param *kp)
 {
 	battery_health = map_get_value(map_health, key, battery_health);
-	signal_power_supply_changed(&test_power_supplies[TEST_BATTERY]);
+	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
 	return 0;
 }
 
@@ -386,7 +390,7 @@ static int param_set_battery_present(const char *key,
 					const struct kernel_param *kp)
 {
 	battery_present = map_get_value(map_present, key, battery_present);
-	signal_power_supply_changed(&test_power_supplies[TEST_AC]);
+	signal_power_supply_changed(test_power_supplies[TEST_AC]);
 	return 0;
 }
 
@@ -402,7 +406,7 @@ static int param_set_battery_technology(const char *key,
 {
 	battery_technology = map_get_value(map_technology, key,
 						battery_technology);
-	signal_power_supply_changed(&test_power_supplies[TEST_BATTERY]);
+	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
 	return 0;
 }
 
@@ -423,7 +427,7 @@ static int param_set_battery_capacity(const char *key,
 		return -EINVAL;
 
 	battery_capacity = tmp;
-	signal_power_supply_changed(&test_power_supplies[TEST_BATTERY]);
+	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
 	return 0;
 }
 
@@ -438,7 +442,7 @@ static int param_set_battery_voltage(const char *key,
 		return -EINVAL;
 
 	battery_voltage = tmp;
-	signal_power_supply_changed(&test_power_supplies[TEST_BATTERY]);
+	signal_power_supply_changed(test_power_supplies[TEST_BATTERY]);
 	return 0;
 }
 
diff --git a/drivers/power/tosa_battery.c b/drivers/power/tosa_battery.c
index 895e4b4dfcf6..6e88c1b37945 100644
--- a/drivers/power/tosa_battery.c
+++ b/drivers/power/tosa_battery.c
@@ -26,7 +26,7 @@ static struct work_struct bat_work;
 
 struct tosa_bat {
 	int status;
-	struct power_supply psy;
+	struct power_supply *psy;
 	int full_chrg;
 
 	struct mutex work_lock; /* protects data */
@@ -61,7 +61,7 @@ static unsigned long tosa_read_bat(struct tosa_bat *bat)
 	mutex_lock(&bat_lock);
 	gpio_set_value(bat->gpio_bat, 1);
 	msleep(5);
-	value = wm97xx_read_aux_adc(dev_get_drvdata(bat->psy.dev->parent),
+	value = wm97xx_read_aux_adc(dev_get_drvdata(bat->psy->dev.parent),
 			bat->adc_bat);
 	gpio_set_value(bat->gpio_bat, 0);
 	mutex_unlock(&bat_lock);
@@ -81,7 +81,7 @@ static unsigned long tosa_read_temp(struct tosa_bat *bat)
 	mutex_lock(&bat_lock);
 	gpio_set_value(bat->gpio_temp, 1);
 	msleep(5);
-	value = wm97xx_read_aux_adc(dev_get_drvdata(bat->psy.dev->parent),
+	value = wm97xx_read_aux_adc(dev_get_drvdata(bat->psy->dev.parent),
 			bat->adc_temp);
 	gpio_set_value(bat->gpio_temp, 0);
 	mutex_unlock(&bat_lock);
@@ -96,7 +96,7 @@ static int tosa_bat_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	int ret = 0;
-	struct tosa_bat *bat = container_of(psy, struct tosa_bat, psy);
+	struct tosa_bat *bat = power_supply_get_drvdata(psy);
 
 	if (bat->is_present && !bat->is_present(bat)
 			&& psp != POWER_SUPPLY_PROP_PRESENT) {
@@ -158,14 +158,14 @@ static irqreturn_t tosa_bat_gpio_isr(int irq, void *data)
 static void tosa_bat_update(struct tosa_bat *bat)
 {
 	int old;
-	struct power_supply *psy = &bat->psy;
+	struct power_supply *psy = bat->psy;
 
 	mutex_lock(&bat->work_lock);
 
 	old = bat->status;
 
 	if (bat->is_present && !bat->is_present(bat)) {
-		printk(KERN_NOTICE "%s not present\n", psy->name);
+		printk(KERN_NOTICE "%s not present\n", psy->desc->name);
 		bat->status = POWER_SUPPLY_STATUS_UNKNOWN;
 		bat->full_chrg = -1;
 	} else if (power_supply_am_i_supplied(psy)) {
@@ -222,18 +222,38 @@ static enum power_supply_property tosa_bat_bu_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 };
 
+static const struct power_supply_desc tosa_bat_main_desc = {
+	.name		= "main-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= tosa_bat_main_props,
+	.num_properties	= ARRAY_SIZE(tosa_bat_main_props),
+	.get_property	= tosa_bat_get_property,
+	.external_power_changed = tosa_bat_external_power_changed,
+	.use_for_apm	= 1,
+};
+
+static const struct power_supply_desc tosa_bat_jacket_desc = {
+	.name		= "jacket-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= tosa_bat_main_props,
+	.num_properties	= ARRAY_SIZE(tosa_bat_main_props),
+	.get_property	= tosa_bat_get_property,
+	.external_power_changed = tosa_bat_external_power_changed,
+};
+
+static const struct power_supply_desc tosa_bat_bu_desc = {
+	.name		= "backup-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= tosa_bat_bu_props,
+	.num_properties	= ARRAY_SIZE(tosa_bat_bu_props),
+	.get_property	= tosa_bat_get_property,
+	.external_power_changed = tosa_bat_external_power_changed,
+};
+
 static struct tosa_bat tosa_bat_main = {
 	.status = POWER_SUPPLY_STATUS_DISCHARGING,
 	.full_chrg = -1,
-	.psy = {
-		.name		= "main-battery",
-		.type		= POWER_SUPPLY_TYPE_BATTERY,
-		.properties	= tosa_bat_main_props,
-		.num_properties	= ARRAY_SIZE(tosa_bat_main_props),
-		.get_property	= tosa_bat_get_property,
-		.external_power_changed = tosa_bat_external_power_changed,
-		.use_for_apm	= 1,
-	},
+	.psy = NULL,
 
 	.gpio_full = TOSA_GPIO_BAT0_CRG,
 	.gpio_charge_off = TOSA_GPIO_CHARGE_OFF,
@@ -254,14 +274,7 @@ static struct tosa_bat tosa_bat_main = {
 static struct tosa_bat tosa_bat_jacket = {
 	.status = POWER_SUPPLY_STATUS_DISCHARGING,
 	.full_chrg = -1,
-	.psy = {
-		.name		= "jacket-battery",
-		.type		= POWER_SUPPLY_TYPE_BATTERY,
-		.properties	= tosa_bat_main_props,
-		.num_properties	= ARRAY_SIZE(tosa_bat_main_props),
-		.get_property	= tosa_bat_get_property,
-		.external_power_changed = tosa_bat_external_power_changed,
-	},
+	.psy = NULL,
 
 	.is_present = tosa_jacket_bat_is_present,
 	.gpio_full = TOSA_GPIO_BAT1_CRG,
@@ -283,15 +296,7 @@ static struct tosa_bat tosa_bat_jacket = {
 static struct tosa_bat tosa_bat_bu = {
 	.status = POWER_SUPPLY_STATUS_UNKNOWN,
 	.full_chrg = -1,
-
-	.psy = {
-		.name		= "backup-battery",
-		.type		= POWER_SUPPLY_TYPE_BATTERY,
-		.properties	= tosa_bat_bu_props,
-		.num_properties	= ARRAY_SIZE(tosa_bat_bu_props),
-		.get_property	= tosa_bat_get_property,
-		.external_power_changed = tosa_bat_external_power_changed,
-	},
+	.psy = NULL,
 
 	.gpio_full = -1,
 	.gpio_charge_off = -1,
@@ -345,6 +350,9 @@ static int tosa_bat_resume(struct platform_device *dev)
 static int tosa_bat_probe(struct platform_device *dev)
 {
 	int ret;
+	struct power_supply_config main_psy_cfg = {},
+				   jacket_psy_cfg = {},
+				   bu_psy_cfg = {};
 
 	if (!machine_is_tosa())
 		return -ENODEV;
@@ -358,15 +366,31 @@ static int tosa_bat_probe(struct platform_device *dev)
 
 	INIT_WORK(&bat_work, tosa_bat_work);
 
-	ret = power_supply_register(&dev->dev, &tosa_bat_main.psy, NULL);
-	if (ret)
+	main_psy_cfg.drv_data = &tosa_bat_main;
+	tosa_bat_main.psy = power_supply_register(&dev->dev,
+						  &tosa_bat_main_desc,
+						  &main_psy_cfg);
+	if (IS_ERR(tosa_bat_main.psy)) {
+		ret = PTR_ERR(tosa_bat_main.psy);
 		goto err_psy_reg_main;
-	ret = power_supply_register(&dev->dev, &tosa_bat_jacket.psy, NULL);
-	if (ret)
+	}
+
+	jacket_psy_cfg.drv_data = &tosa_bat_jacket;
+	tosa_bat_jacket.psy = power_supply_register(&dev->dev,
+						    &tosa_bat_jacket_desc,
+						    &jacket_psy_cfg);
+	if (IS_ERR(tosa_bat_jacket.psy)) {
+		ret = PTR_ERR(tosa_bat_jacket.psy);
 		goto err_psy_reg_jacket;
-	ret = power_supply_register(&dev->dev, &tosa_bat_bu.psy, NULL);
-	if (ret)
+	}
+
+	bu_psy_cfg.drv_data = &tosa_bat_bu;
+	tosa_bat_bu.psy = power_supply_register(&dev->dev, &tosa_bat_bu_desc,
+						&bu_psy_cfg);
+	if (IS_ERR(tosa_bat_bu.psy)) {
+		ret = PTR_ERR(tosa_bat_bu.psy);
 		goto err_psy_reg_bu;
+	}
 
 	ret = request_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG),
 				tosa_bat_gpio_isr,
@@ -395,11 +419,11 @@ static int tosa_bat_probe(struct platform_device *dev)
 err_req_jacket:
 	free_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG), &tosa_bat_main);
 err_req_main:
-	power_supply_unregister(&tosa_bat_bu.psy);
+	power_supply_unregister(tosa_bat_bu.psy);
 err_psy_reg_bu:
-	power_supply_unregister(&tosa_bat_jacket.psy);
+	power_supply_unregister(tosa_bat_jacket.psy);
 err_psy_reg_jacket:
-	power_supply_unregister(&tosa_bat_main.psy);
+	power_supply_unregister(tosa_bat_main.psy);
 err_psy_reg_main:
 
 	/* see comment in tosa_bat_remove */
@@ -415,9 +439,9 @@ static int tosa_bat_remove(struct platform_device *dev)
 	free_irq(gpio_to_irq(TOSA_GPIO_BAT1_CRG), &tosa_bat_jacket);
 	free_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG), &tosa_bat_main);
 
-	power_supply_unregister(&tosa_bat_bu.psy);
-	power_supply_unregister(&tosa_bat_jacket.psy);
-	power_supply_unregister(&tosa_bat_main.psy);
+	power_supply_unregister(tosa_bat_bu.psy);
+	power_supply_unregister(tosa_bat_jacket.psy);
+	power_supply_unregister(tosa_bat_main.psy);
 
 	/*
 	 * Now cancel the bat_work.  We won't get any more schedules,
diff --git a/drivers/power/tps65090-charger.c b/drivers/power/tps65090-charger.c
index 9872c901bd70..dcf9a3ca53d5 100644
--- a/drivers/power/tps65090-charger.c
+++ b/drivers/power/tps65090-charger.c
@@ -43,7 +43,7 @@ struct tps65090_charger {
 	int	irq;
 	struct task_struct	*poll_task;
 	bool			passive_mode;
-	struct power_supply	ac;
+	struct power_supply	*ac;
 	struct tps65090_platform_data *pdata;
 };
 
@@ -135,8 +135,7 @@ static int tps65090_ac_get_property(struct power_supply *psy,
 			enum power_supply_property psp,
 			union power_supply_propval *val)
 {
-	struct tps65090_charger *charger = container_of(psy,
-					struct tps65090_charger, ac);
+	struct tps65090_charger *charger = power_supply_get_drvdata(psy);
 
 	if (psp == POWER_SUPPLY_PROP_ONLINE) {
 		val->intval = charger->ac_online;
@@ -190,7 +189,7 @@ static irqreturn_t tps65090_charger_isr(int irq, void *dev_id)
 	}
 
 	if (charger->prev_ac_online != charger->ac_online)
-		power_supply_changed(&charger->ac);
+		power_supply_changed(charger->ac);
 
 	return IRQ_HANDLED;
 }
@@ -229,6 +228,14 @@ static int tps65090_charger_poll_task(void *data)
 	return 0;
 }
 
+static const struct power_supply_desc tps65090_charger_desc = {
+	.name			= "tps65090-ac",
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+	.get_property		= tps65090_ac_get_property,
+	.properties		= tps65090_ac_props,
+	.num_properties		= ARRAY_SIZE(tps65090_ac_props),
+};
+
 static int tps65090_charger_probe(struct platform_device *pdev)
 {
 	struct tps65090_charger *cdata;
@@ -260,20 +267,16 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	cdata->dev			= &pdev->dev;
 	cdata->pdata			= pdata;
 
-	cdata->ac.name			= "tps65090-ac";
-	cdata->ac.type			= POWER_SUPPLY_TYPE_MAINS;
-	cdata->ac.get_property		= tps65090_ac_get_property;
-	cdata->ac.properties		= tps65090_ac_props;
-	cdata->ac.num_properties	= ARRAY_SIZE(tps65090_ac_props);
-
 	psy_cfg.supplied_to		= pdata->supplied_to;
 	psy_cfg.num_supplicants		= pdata->num_supplicants;
 	psy_cfg.of_node			= pdev->dev.of_node;
+	psy_cfg.drv_data		= cdata;
 
-	ret = power_supply_register(&pdev->dev, &cdata->ac, &psy_cfg);
-	if (ret) {
+	cdata->ac = power_supply_register(&pdev->dev, &tps65090_charger_desc,
+			&psy_cfg);
+	if (IS_ERR(cdata->ac)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
-		return ret;
+		return PTR_ERR(cdata->ac);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -303,7 +306,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 			goto fail_unregister_supply;
 		}
 		cdata->ac_online = 1;
-		power_supply_changed(&cdata->ac);
+		power_supply_changed(cdata->ac);
 	}
 
 	if (irq != -ENXIO) {
@@ -330,7 +333,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	return 0;
 
 fail_unregister_supply:
-	power_supply_unregister(&cdata->ac);
+	power_supply_unregister(cdata->ac);
 
 	return ret;
 }
@@ -341,7 +344,7 @@ static int tps65090_charger_remove(struct platform_device *pdev)
 
 	if (cdata->irq == -ENXIO)
 		kthread_stop(cdata->poll_task);
-	power_supply_unregister(&cdata->ac);
+	power_supply_unregister(cdata->ac);
 
 	return 0;
 }
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 156f30e64a75..02a522cb7753 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -87,8 +87,8 @@ MODULE_PARM_DESC(allow_usb, "Allow USB charge drawing default current");
 
 struct twl4030_bci {
 	struct device		*dev;
-	struct power_supply	ac;
-	struct power_supply	usb;
+	struct power_supply	*ac;
+	struct power_supply	*usb;
 	struct usb_phy		*transceiver;
 	struct notifier_block	usb_nb;
 	struct work_struct	work;
@@ -318,8 +318,8 @@ static irqreturn_t twl4030_charger_interrupt(int irq, void *arg)
 	struct twl4030_bci *bci = arg;
 
 	dev_dbg(bci->dev, "CHG_PRES irq\n");
-	power_supply_changed(&bci->ac);
-	power_supply_changed(&bci->usb);
+	power_supply_changed(bci->ac);
+	power_supply_changed(bci->usb);
 
 	return IRQ_HANDLED;
 }
@@ -347,8 +347,8 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 
 	if (irqs1 & (TWL4030_ICHGLOW | TWL4030_ICHGEOC)) {
 		/* charger state change, inform the core */
-		power_supply_changed(&bci->ac);
-		power_supply_changed(&bci->usb);
+		power_supply_changed(bci->ac);
+		power_supply_changed(bci->usb);
 	}
 
 	/* various monitoring events, for now we just log them here */
@@ -463,7 +463,7 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 				    enum power_supply_property psp,
 				    union power_supply_propval *val)
 {
-	struct twl4030_bci *bci = dev_get_drvdata(psy->dev->parent);
+	struct twl4030_bci *bci = dev_get_drvdata(psy->dev.parent);
 	int is_charging;
 	int state;
 	int ret;
@@ -472,7 +472,7 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 	if (state < 0)
 		return state;
 
-	if (psy->type == POWER_SUPPLY_TYPE_USB)
+	if (psy->desc->type == POWER_SUPPLY_TYPE_USB)
 		is_charging = state & TWL4030_MSTATEC_USB;
 	else
 		is_charging = state & TWL4030_MSTATEC_AC;
@@ -488,7 +488,7 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 		/* charging must be active for meaningful result */
 		if (!is_charging)
 			return -ENODATA;
-		if (psy->type == POWER_SUPPLY_TYPE_USB) {
+		if (psy->desc->type == POWER_SUPPLY_TYPE_USB) {
 			ret = twl4030bci_read_adc_val(TWL4030_BCIVBUS);
 			if (ret < 0)
 				return ret;
@@ -558,6 +558,22 @@ twl4030_bci_parse_dt(struct device *dev)
 }
 #endif
 
+static const struct power_supply_desc twl4030_bci_ac_desc = {
+	.name		= "twl4030_ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= twl4030_charger_props,
+	.num_properties	= ARRAY_SIZE(twl4030_charger_props),
+	.get_property	= twl4030_bci_get_property,
+};
+
+static const struct power_supply_desc twl4030_bci_usb_desc = {
+	.name		= "twl4030_usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= twl4030_charger_props,
+	.num_properties	= ARRAY_SIZE(twl4030_charger_props),
+	.get_property	= twl4030_bci_get_property,
+};
+
 static int __init twl4030_bci_probe(struct platform_device *pdev)
 {
 	struct twl4030_bci *bci;
@@ -584,28 +600,21 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, bci);
-	bci->ac.name = "twl4030_ac";
-	bci->ac.type = POWER_SUPPLY_TYPE_MAINS;
-	bci->ac.properties = twl4030_charger_props;
-	bci->ac.num_properties = ARRAY_SIZE(twl4030_charger_props);
-	bci->ac.get_property = twl4030_bci_get_property;
 
-	ret = power_supply_register(&pdev->dev, &bci->ac, NULL);
-	if (ret) {
+	bci->ac = power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
+					NULL);
+	if (IS_ERR(bci->ac)) {
+		ret = PTR_ERR(bci->ac);
 		dev_err(&pdev->dev, "failed to register ac: %d\n", ret);
 		goto fail_register_ac;
 	}
 
-	bci->usb.name = "twl4030_usb";
-	bci->usb.type = POWER_SUPPLY_TYPE_USB;
-	bci->usb.properties = twl4030_charger_props;
-	bci->usb.num_properties = ARRAY_SIZE(twl4030_charger_props);
-	bci->usb.get_property = twl4030_bci_get_property;
-
 	bci->usb_reg = regulator_get(bci->dev, "bci3v1");
 
-	ret = power_supply_register(&pdev->dev, &bci->usb, NULL);
-	if (ret) {
+	bci->usb = power_supply_register(&pdev->dev, &twl4030_bci_usb_desc,
+					 NULL);
+	if (IS_ERR(bci->usb)) {
+		ret = PTR_ERR(bci->usb);
 		dev_err(&pdev->dev, "failed to register usb: %d\n", ret);
 		goto fail_register_usb;
 	}
@@ -670,9 +679,9 @@ fail_unmask_interrupts:
 fail_bci_irq:
 	free_irq(bci->irq_chg, bci);
 fail_chg_irq:
-	power_supply_unregister(&bci->usb);
+	power_supply_unregister(bci->usb);
 fail_register_usb:
-	power_supply_unregister(&bci->ac);
+	power_supply_unregister(bci->ac);
 fail_register_ac:
 fail_no_battery:
 	kfree(bci);
@@ -700,8 +709,8 @@ static int __exit twl4030_bci_remove(struct platform_device *pdev)
 	}
 	free_irq(bci->irq_bci, bci);
 	free_irq(bci->irq_chg, bci);
-	power_supply_unregister(&bci->usb);
-	power_supply_unregister(&bci->ac);
+	power_supply_unregister(bci->usb);
+	power_supply_unregister(bci->ac);
 	kfree(bci);
 
 	return 0;
diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index d065460c1cb3..36d3a0e229fa 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -21,7 +21,7 @@
 #include <linux/power/twl4030_madc_battery.h>
 
 struct twl4030_madc_battery {
-	struct power_supply psy;
+	struct power_supply *psy;
 	struct twl4030_madc_bat_platform_data *pdata;
 };
 
@@ -113,8 +113,7 @@ static int twl4030_madc_bat_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct twl4030_madc_battery *bat = container_of(psy,
-					struct twl4030_madc_battery, psy);
+	struct twl4030_madc_battery *bat = power_supply_get_drvdata(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -176,12 +175,19 @@ static int twl4030_madc_bat_get_property(struct power_supply *psy,
 
 static void twl4030_madc_bat_ext_changed(struct power_supply *psy)
 {
-	struct twl4030_madc_battery *bat = container_of(psy,
-					struct twl4030_madc_battery, psy);
-
-	power_supply_changed(&bat->psy);
+	power_supply_changed(psy);
 }
 
+static const struct power_supply_desc twl4030_madc_bat_desc = {
+	.name			= "twl4030_battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= twl4030_madc_bat_props,
+	.num_properties		= ARRAY_SIZE(twl4030_madc_bat_props),
+	.get_property		= twl4030_madc_bat_get_property,
+	.external_power_changed	= twl4030_madc_bat_ext_changed,
+
+};
+
 static int twl4030_cmp(const void *a, const void *b)
 {
 	return ((struct twl4030_madc_bat_calibration *)b)->voltage -
@@ -192,21 +198,13 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 {
 	struct twl4030_madc_battery *twl4030_madc_bat;
 	struct twl4030_madc_bat_platform_data *pdata = pdev->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	int ret = 0;
 
 	twl4030_madc_bat = kzalloc(sizeof(*twl4030_madc_bat), GFP_KERNEL);
 	if (!twl4030_madc_bat)
 		return -ENOMEM;
 
-	twl4030_madc_bat->psy.name = "twl4030_battery";
-	twl4030_madc_bat->psy.type = POWER_SUPPLY_TYPE_BATTERY;
-	twl4030_madc_bat->psy.properties = twl4030_madc_bat_props;
-	twl4030_madc_bat->psy.num_properties =
-					ARRAY_SIZE(twl4030_madc_bat_props);
-	twl4030_madc_bat->psy.get_property = twl4030_madc_bat_get_property;
-	twl4030_madc_bat->psy.external_power_changed =
-					twl4030_madc_bat_ext_changed;
-
 	/* sort charging and discharging calibration data */
 	sort(pdata->charging, pdata->charging_size,
 		sizeof(struct twl4030_madc_bat_calibration),
@@ -217,9 +215,14 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 
 	twl4030_madc_bat->pdata = pdata;
 	platform_set_drvdata(pdev, twl4030_madc_bat);
-	ret = power_supply_register(&pdev->dev, &twl4030_madc_bat->psy, NULL);
-	if (ret < 0)
+	psy_cfg.drv_data = twl4030_madc_bat;
+	twl4030_madc_bat->psy = power_supply_register(&pdev->dev,
+						      &twl4030_madc_bat_desc,
+						      &psy_cfg);
+	if (IS_ERR(twl4030_madc_bat->psy)) {
+		ret = PTR_ERR(twl4030_madc_bat->psy);
 		kfree(twl4030_madc_bat);
+	}
 
 	return ret;
 }
@@ -228,7 +231,7 @@ static int twl4030_madc_battery_remove(struct platform_device *pdev)
 {
 	struct twl4030_madc_battery *bat = platform_get_drvdata(pdev);
 
-	power_supply_unregister(&bat->psy);
+	power_supply_unregister(bat->psy);
 	kfree(bat);
 
 	return 0;
diff --git a/drivers/power/wm831x_backup.c b/drivers/power/wm831x_backup.c
index 60ae871148b0..2e33109ca8c7 100644
--- a/drivers/power/wm831x_backup.c
+++ b/drivers/power/wm831x_backup.c
@@ -21,7 +21,8 @@
 
 struct wm831x_backup {
 	struct wm831x *wm831x;
-	struct power_supply backup;
+	struct power_supply *backup;
+	struct power_supply_desc backup_desc;
 	char name[20];
 };
 
@@ -115,7 +116,7 @@ static int wm831x_backup_get_prop(struct power_supply *psy,
 				  enum power_supply_property psp,
 				  union power_supply_propval *val)
 {
-	struct wm831x_backup *devdata = dev_get_drvdata(psy->dev->parent);
+	struct wm831x_backup *devdata = dev_get_drvdata(psy->dev.parent);
 	struct wm831x *wm831x = devdata->wm831x;
 	int ret = 0;
 
@@ -166,8 +167,6 @@ static int wm831x_backup_probe(struct platform_device *pdev)
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_pdata *wm831x_pdata = wm831x->dev->platform_data;
 	struct wm831x_backup *devdata;
-	struct power_supply *backup;
-	int ret;
 
 	devdata = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_backup),
 				GFP_KERNEL);
@@ -177,8 +176,6 @@ static int wm831x_backup_probe(struct platform_device *pdev)
 	devdata->wm831x = wm831x;
 	platform_set_drvdata(pdev, devdata);
 
-	backup = &devdata->backup;
-
 	/* We ignore configuration failures since we can still read
 	 * back the status without enabling the charger (which may
 	 * already be enabled anyway).
@@ -192,21 +189,22 @@ static int wm831x_backup_probe(struct platform_device *pdev)
 		snprintf(devdata->name, sizeof(devdata->name),
 			 "wm831x-backup");
 
-	backup->name = devdata->name;
-	backup->type = POWER_SUPPLY_TYPE_BATTERY;
-	backup->properties = wm831x_backup_props;
-	backup->num_properties = ARRAY_SIZE(wm831x_backup_props);
-	backup->get_property = wm831x_backup_get_prop;
-	ret = power_supply_register(&pdev->dev, backup, NULL);
+	devdata->backup_desc.name = devdata->name;
+	devdata->backup_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	devdata->backup_desc.properties = wm831x_backup_props;
+	devdata->backup_desc.num_properties = ARRAY_SIZE(wm831x_backup_props);
+	devdata->backup_desc.get_property = wm831x_backup_get_prop;
+	devdata->backup = power_supply_register(&pdev->dev,
+						&devdata->backup_desc, NULL);
 
-	return ret;
+	return PTR_ERR_OR_ZERO(devdata->backup);
 }
 
 static int wm831x_backup_remove(struct platform_device *pdev)
 {
 	struct wm831x_backup *devdata = platform_get_drvdata(pdev);
 
-	power_supply_unregister(&devdata->backup);
+	power_supply_unregister(devdata->backup);
 
 	return 0;
 }
diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_power.c
index a132aae6225d..0161bdabd5a3 100644
--- a/drivers/power/wm831x_power.c
+++ b/drivers/power/wm831x_power.c
@@ -21,9 +21,12 @@
 
 struct wm831x_power {
 	struct wm831x *wm831x;
-	struct power_supply wall;
-	struct power_supply usb;
-	struct power_supply battery;
+	struct power_supply *wall;
+	struct power_supply *usb;
+	struct power_supply *battery;
+	struct power_supply_desc wall_desc;
+	struct power_supply_desc usb_desc;
+	struct power_supply_desc battery_desc;
 	char wall_name[20];
 	char usb_name[20];
 	char battery_name[20];
@@ -67,7 +70,7 @@ static int wm831x_wall_get_prop(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev->parent);
+	struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev.parent);
 	struct wm831x *wm831x = wm831x_power->wm831x;
 	int ret = 0;
 
@@ -98,7 +101,7 @@ static int wm831x_usb_get_prop(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
 {
-	struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev->parent);
+	struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev.parent);
 	struct wm831x *wm831x = wm831x_power->wm831x;
 	int ret = 0;
 
@@ -393,7 +396,7 @@ static int wm831x_bat_get_prop(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
 {
-	struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev->parent);
+	struct wm831x_power *wm831x_power = dev_get_drvdata(psy->dev.parent);
 	struct wm831x *wm831x = wm831x_power->wm831x;
 	int ret = 0;
 
@@ -451,7 +454,7 @@ static irqreturn_t wm831x_bat_irq(int irq, void *data)
 	/* The battery charger is autonomous so we don't need to do
 	 * anything except kick user space */
 	if (wm831x_power->have_battery)
-		power_supply_changed(&wm831x_power->battery);
+		power_supply_changed(wm831x_power->battery);
 
 	return IRQ_HANDLED;
 }
@@ -482,9 +485,9 @@ static irqreturn_t wm831x_pwr_src_irq(int irq, void *data)
 
 	/* Just notify for everything - little harm in overnotifying. */
 	if (wm831x_power->have_battery)
-		power_supply_changed(&wm831x_power->battery);
-	power_supply_changed(&wm831x_power->usb);
-	power_supply_changed(&wm831x_power->wall);
+		power_supply_changed(wm831x_power->battery);
+	power_supply_changed(wm831x_power->usb);
+	power_supply_changed(wm831x_power->wall);
 
 	return IRQ_HANDLED;
 }
@@ -494,9 +497,6 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_pdata *wm831x_pdata = wm831x->dev->platform_data;
 	struct wm831x_power *power;
-	struct power_supply *usb;
-	struct power_supply *battery;
-	struct power_supply *wall;
 	int ret, irq, i;
 
 	power = kzalloc(sizeof(struct wm831x_power), GFP_KERNEL);
@@ -506,10 +506,6 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	power->wm831x = wm831x;
 	platform_set_drvdata(pdev, power);
 
-	usb = &power->usb;
-	battery = &power->battery;
-	wall = &power->wall;
-
 	if (wm831x_pdata && wm831x_pdata->wm831x_num) {
 		snprintf(power->wall_name, sizeof(power->wall_name),
 			 "wm831x-wall.%d", wm831x_pdata->wm831x_num);
@@ -531,23 +527,28 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	 */
 	wm831x_config_battery(wm831x);
 
-	wall->name = power->wall_name;
-	wall->type = POWER_SUPPLY_TYPE_MAINS;
-	wall->properties = wm831x_wall_props;
-	wall->num_properties = ARRAY_SIZE(wm831x_wall_props);
-	wall->get_property = wm831x_wall_get_prop;
-	ret = power_supply_register(&pdev->dev, wall, NULL);
-	if (ret)
+	power->wall_desc.name = power->wall_name;
+	power->wall_desc.type = POWER_SUPPLY_TYPE_MAINS;
+	power->wall_desc.properties = wm831x_wall_props;
+	power->wall_desc.num_properties = ARRAY_SIZE(wm831x_wall_props);
+	power->wall_desc.get_property = wm831x_wall_get_prop;
+	power->wall = power_supply_register(&pdev->dev, &power->wall_desc,
+					    NULL);
+	if (IS_ERR(power->wall)) {
+		ret = PTR_ERR(power->wall);
 		goto err_kmalloc;
+	}
 
-	usb->name = power->usb_name,
-	usb->type = POWER_SUPPLY_TYPE_USB;
-	usb->properties = wm831x_usb_props;
-	usb->num_properties = ARRAY_SIZE(wm831x_usb_props);
-	usb->get_property = wm831x_usb_get_prop;
-	ret = power_supply_register(&pdev->dev, usb, NULL);
-	if (ret)
+	power->usb_desc.name = power->usb_name,
+	power->usb_desc.type = POWER_SUPPLY_TYPE_USB;
+	power->usb_desc.properties = wm831x_usb_props;
+	power->usb_desc.num_properties = ARRAY_SIZE(wm831x_usb_props);
+	power->usb_desc.get_property = wm831x_usb_get_prop;
+	power->usb = power_supply_register(&pdev->dev, &power->usb_desc, NULL);
+	if (IS_ERR(power->usb)) {
+		ret = PTR_ERR(power->usb);
 		goto err_wall;
+	}
 
 	ret = wm831x_reg_read(wm831x, WM831X_CHARGER_CONTROL_1);
 	if (ret < 0)
@@ -555,14 +556,18 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	power->have_battery = ret & WM831X_CHG_ENA;
 
 	if (power->have_battery) {
-		    battery->name = power->battery_name;
-		    battery->properties = wm831x_bat_props;
-		    battery->num_properties = ARRAY_SIZE(wm831x_bat_props);
-		    battery->get_property = wm831x_bat_get_prop;
-		    battery->use_for_apm = 1;
-		    ret = power_supply_register(&pdev->dev, battery, NULL);
-		    if (ret)
-			    goto err_usb;
+		power->battery_desc.name = power->battery_name;
+		power->battery_desc.properties = wm831x_bat_props;
+		power->battery_desc.num_properties = ARRAY_SIZE(wm831x_bat_props);
+		power->battery_desc.get_property = wm831x_bat_get_prop;
+		power->battery_desc.use_for_apm = 1;
+		power->battery = power_supply_register(&pdev->dev,
+						       &power->battery_desc,
+						       NULL);
+		if (IS_ERR(power->battery)) {
+			ret = PTR_ERR(power->battery);
+			goto err_usb;
+		}
 	}
 
 	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
@@ -615,11 +620,11 @@ err_syslo:
 	free_irq(irq, power);
 err_battery:
 	if (power->have_battery)
-		power_supply_unregister(battery);
+		power_supply_unregister(power->battery);
 err_usb:
-	power_supply_unregister(usb);
+	power_supply_unregister(power->usb);
 err_wall:
-	power_supply_unregister(wall);
+	power_supply_unregister(power->wall);
 err_kmalloc:
 	kfree(power);
 	return ret;
@@ -645,9 +650,9 @@ static int wm831x_power_remove(struct platform_device *pdev)
 	free_irq(irq, wm831x_power);
 
 	if (wm831x_power->have_battery)
-		power_supply_unregister(&wm831x_power->battery);
-	power_supply_unregister(&wm831x_power->wall);
-	power_supply_unregister(&wm831x_power->usb);
+		power_supply_unregister(wm831x_power->battery);
+	power_supply_unregister(wm831x_power->wall);
+	power_supply_unregister(wm831x_power->usb);
 	kfree(wm831x_power);
 	return 0;
 }
diff --git a/drivers/power/wm8350_power.c b/drivers/power/wm8350_power.c
index 261ceca561d5..5c5880664e09 100644
--- a/drivers/power/wm8350_power.c
+++ b/drivers/power/wm8350_power.c
@@ -196,14 +196,14 @@ static irqreturn_t wm8350_charger_handler(int irq, void *data)
 		break;
 	case WM8350_IRQ_CHG_TO:
 		dev_err(wm8350->dev, "charger timeout\n");
-		power_supply_changed(&power->battery);
+		power_supply_changed(power->battery);
 		break;
 
 	case WM8350_IRQ_CHG_BAT_HOT:
 	case WM8350_IRQ_CHG_BAT_COLD:
 	case WM8350_IRQ_CHG_START:
 	case WM8350_IRQ_CHG_END:
-		power_supply_changed(&power->battery);
+		power_supply_changed(power->battery);
 		break;
 
 	case WM8350_IRQ_CHG_FAST_RDY:
@@ -231,9 +231,9 @@ static irqreturn_t wm8350_charger_handler(int irq, void *data)
 	case WM8350_IRQ_EXT_WALL_FB:
 		wm8350_charger_config(wm8350, policy);
 	case WM8350_IRQ_EXT_BAT_FB:   /* Fall through */
-		power_supply_changed(&power->battery);
-		power_supply_changed(&power->usb);
-		power_supply_changed(&power->ac);
+		power_supply_changed(power->battery);
+		power_supply_changed(power->usb);
+		power_supply_changed(power->ac);
 		break;
 
 	default:
@@ -250,7 +250,7 @@ static int wm8350_ac_get_prop(struct power_supply *psy,
 			      enum power_supply_property psp,
 			      union power_supply_propval *val)
 {
-	struct wm8350 *wm8350 = dev_get_drvdata(psy->dev->parent);
+	struct wm8350 *wm8350 = dev_get_drvdata(psy->dev.parent);
 	int ret = 0;
 
 	switch (psp) {
@@ -280,7 +280,7 @@ static int wm8350_usb_get_prop(struct power_supply *psy,
 			       enum power_supply_property psp,
 			       union power_supply_propval *val)
 {
-	struct wm8350 *wm8350 = dev_get_drvdata(psy->dev->parent);
+	struct wm8350 *wm8350 = dev_get_drvdata(psy->dev.parent);
 	int ret = 0;
 
 	switch (psp) {
@@ -346,7 +346,7 @@ static int wm8350_bat_get_property(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   union power_supply_propval *val)
 {
-	struct wm8350 *wm8350 = dev_get_drvdata(psy->dev->parent);
+	struct wm8350 *wm8350 = dev_get_drvdata(psy->dev.parent);
 	int ret = 0;
 
 	switch (psp) {
@@ -382,6 +382,30 @@ static enum power_supply_property wm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 };
 
+static const struct power_supply_desc wm8350_ac_desc = {
+	.name		= "wm8350-ac",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= wm8350_ac_props,
+	.num_properties	= ARRAY_SIZE(wm8350_ac_props),
+	.get_property	= wm8350_ac_get_prop,
+};
+
+static const struct power_supply_desc wm8350_battery_desc = {
+	.name		= "wm8350-battery",
+	.properties	= wm8350_bat_props,
+	.num_properties	= ARRAY_SIZE(wm8350_bat_props),
+	.get_property	= wm8350_bat_get_property,
+	.use_for_apm	= 1,
+};
+
+static const struct power_supply_desc wm8350_usb_desc = {
+	.name		= "wm8350-usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= wm8350_usb_props,
+	.num_properties	= ARRAY_SIZE(wm8350_usb_props),
+	.get_property	= wm8350_usb_get_prop,
+};
+
 /*********************************************************************
  *		Initialisation
  *********************************************************************/
@@ -447,37 +471,24 @@ static int wm8350_power_probe(struct platform_device *pdev)
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
 	struct wm8350_power *power = &wm8350->power;
 	struct wm8350_charger_policy *policy = power->policy;
-	struct power_supply *usb = &power->usb;
-	struct power_supply *battery = &power->battery;
-	struct power_supply *ac = &power->ac;
 	int ret;
 
-	ac->name = "wm8350-ac";
-	ac->type = POWER_SUPPLY_TYPE_MAINS;
-	ac->properties = wm8350_ac_props;
-	ac->num_properties = ARRAY_SIZE(wm8350_ac_props);
-	ac->get_property = wm8350_ac_get_prop;
-	ret = power_supply_register(&pdev->dev, ac, NULL);
-	if (ret)
-		return ret;
-
-	battery->name = "wm8350-battery";
-	battery->properties = wm8350_bat_props;
-	battery->num_properties = ARRAY_SIZE(wm8350_bat_props);
-	battery->get_property = wm8350_bat_get_property;
-	battery->use_for_apm = 1;
-	ret = power_supply_register(&pdev->dev, battery, NULL);
-	if (ret)
+	power->ac = power_supply_register(&pdev->dev, &wm8350_ac_desc, NULL);
+	if (IS_ERR(power->ac))
+		return PTR_ERR(power->ac);
+
+	power->battery = power_supply_register(&pdev->dev, &wm8350_battery_desc,
+					       NULL);
+	if (IS_ERR(power->battery)) {
+		ret = PTR_ERR(power->battery);
 		goto battery_failed;
+	}
 
-	usb->name = "wm8350-usb",
-	usb->type = POWER_SUPPLY_TYPE_USB;
-	usb->properties = wm8350_usb_props;
-	usb->num_properties = ARRAY_SIZE(wm8350_usb_props);
-	usb->get_property = wm8350_usb_get_prop;
-	ret = power_supply_register(&pdev->dev, usb, NULL);
-	if (ret)
+	power->usb = power_supply_register(&pdev->dev, &wm8350_usb_desc, NULL);
+	if (IS_ERR(power->usb)) {
+		ret = PTR_ERR(power->usb);
 		goto usb_failed;
+	}
 
 	ret = device_create_file(&pdev->dev, &dev_attr_charger_state);
 	if (ret < 0)
@@ -494,9 +505,9 @@ static int wm8350_power_probe(struct platform_device *pdev)
 	return ret;
 
 usb_failed:
-	power_supply_unregister(battery);
+	power_supply_unregister(power->battery);
 battery_failed:
-	power_supply_unregister(ac);
+	power_supply_unregister(power->ac);
 
 	return ret;
 }
@@ -508,9 +519,9 @@ static int wm8350_power_remove(struct platform_device *pdev)
 
 	free_charger_irq(wm8350);
 	device_remove_file(&pdev->dev, &dev_attr_charger_state);
-	power_supply_unregister(&power->battery);
-	power_supply_unregister(&power->ac);
-	power_supply_unregister(&power->usb);
+	power_supply_unregister(power->battery);
+	power_supply_unregister(power->ac);
+	power_supply_unregister(power->usb);
 	return 0;
 }
 
diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/wm97xx_battery.c
index e81e917bd9d0..c2f09ed35050 100644
--- a/drivers/power/wm97xx_battery.c
+++ b/drivers/power/wm97xx_battery.c
@@ -32,20 +32,20 @@ static enum power_supply_property *prop;
 
 static unsigned long wm97xx_read_bat(struct power_supply *bat_ps)
 {
-	struct wm97xx_pdata *wmdata = bat_ps->dev->parent->platform_data;
+	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
 	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
 
-	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev->parent),
+	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev.parent),
 					pdata->batt_aux) * pdata->batt_mult /
 					pdata->batt_div;
 }
 
 static unsigned long wm97xx_read_temp(struct power_supply *bat_ps)
 {
-	struct wm97xx_pdata *wmdata = bat_ps->dev->parent->platform_data;
+	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
 	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
 
-	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev->parent),
+	return wm97xx_read_aux_adc(dev_get_drvdata(bat_ps->dev.parent),
 					pdata->temp_aux) * pdata->temp_mult /
 					pdata->temp_div;
 }
@@ -54,7 +54,7 @@ static int wm97xx_bat_get_property(struct power_supply *bat_ps,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	struct wm97xx_pdata *wmdata = bat_ps->dev->parent->platform_data;
+	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
 	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
 
 	switch (psp) {
@@ -105,7 +105,7 @@ static void wm97xx_bat_external_power_changed(struct power_supply *bat_ps)
 static void wm97xx_bat_update(struct power_supply *bat_ps)
 {
 	int old_status = bat_status;
-	struct wm97xx_pdata *wmdata = bat_ps->dev->parent->platform_data;
+	struct wm97xx_pdata *wmdata = bat_ps->dev.parent->platform_data;
 	struct wm97xx_batt_pdata *pdata = wmdata->batt_pdata;
 
 	mutex_lock(&work_lock);
@@ -117,7 +117,7 @@ static void wm97xx_bat_update(struct power_supply *bat_ps)
 			POWER_SUPPLY_STATUS_UNKNOWN;
 
 	if (old_status != bat_status) {
-		pr_debug("%s: %i -> %i\n", bat_ps->name, old_status,
+		pr_debug("%s: %i -> %i\n", bat_ps->desc->name, old_status,
 					bat_status);
 		power_supply_changed(bat_ps);
 	}
@@ -125,7 +125,8 @@ static void wm97xx_bat_update(struct power_supply *bat_ps)
 	mutex_unlock(&work_lock);
 }
 
-static struct power_supply bat_ps = {
+static struct power_supply *bat_psy;
+static struct power_supply_desc bat_psy_desc = {
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.get_property		= wm97xx_bat_get_property,
 	.external_power_changed = wm97xx_bat_external_power_changed,
@@ -134,7 +135,7 @@ static struct power_supply bat_ps = {
 
 static void wm97xx_bat_work(struct work_struct *work)
 {
-	wm97xx_bat_update(&bat_ps);
+	wm97xx_bat_update(bat_psy);
 }
 
 static irqreturn_t wm97xx_chrg_irq(int irq, void *data)
@@ -237,18 +238,20 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 		dev_info(&dev->dev, "Please consider setting proper battery "
 				"name in platform definition file, falling "
 				"back to name \"wm97xx-batt\"\n");
-		bat_ps.name = "wm97xx-batt";
+		bat_psy_desc.name = "wm97xx-batt";
 	} else
-		bat_ps.name = pdata->batt_name;
+		bat_psy_desc.name = pdata->batt_name;
 
-	bat_ps.properties = prop;
-	bat_ps.num_properties = props;
+	bat_psy_desc.properties = prop;
+	bat_psy_desc.num_properties = props;
 
-	ret = power_supply_register(&dev->dev, &bat_ps, NULL);
-	if (!ret)
+	bat_psy = power_supply_register(&dev->dev, &bat_psy_desc, NULL);
+	if (!IS_ERR(bat_psy)) {
 		schedule_work(&bat_work);
-	else
+	} else {
+		ret = PTR_ERR(bat_psy);
 		goto err4;
+	}
 
 	return 0;
 err4:
@@ -273,7 +276,7 @@ static int wm97xx_bat_remove(struct platform_device *dev)
 		gpio_free(pdata->charge_gpio);
 	}
 	cancel_work_sync(&bat_work);
-	power_supply_unregister(&bat_ps);
+	power_supply_unregister(bat_psy);
 	kfree(prop);
 	return 0;
 }
diff --git a/drivers/power/z2_battery.c b/drivers/power/z2_battery.c
index df22364212dd..b201e3facf73 100644
--- a/drivers/power/z2_battery.c
+++ b/drivers/power/z2_battery.c
@@ -21,12 +21,13 @@
 #define	Z2_DEFAULT_NAME	"Z2"
 
 struct z2_charger {
-	struct z2_battery_info	*info;
-	int			bat_status;
-	struct i2c_client	*client;
-	struct power_supply	batt_ps;
-	struct mutex		work_lock;
-	struct work_struct	bat_work;
+	struct z2_battery_info		*info;
+	int				bat_status;
+	struct i2c_client		*client;
+	struct power_supply		*batt_ps;
+	struct power_supply_desc	batt_ps_desc;
+	struct mutex			work_lock;
+	struct work_struct		bat_work;
 };
 
 static unsigned long z2_read_bat(struct z2_charger *charger)
@@ -44,8 +45,7 @@ static int z2_batt_get_property(struct power_supply *batt_ps,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	struct z2_charger *charger = container_of(batt_ps, struct z2_charger,
-						batt_ps);
+	struct z2_charger *charger = power_supply_get_drvdata(batt_ps);
 	struct z2_battery_info *info = charger->info;
 
 	switch (psp) {
@@ -85,8 +85,8 @@ static int z2_batt_get_property(struct power_supply *batt_ps,
 
 static void z2_batt_ext_power_changed(struct power_supply *batt_ps)
 {
-	struct z2_charger *charger = container_of(batt_ps, struct z2_charger,
-						batt_ps);
+	struct z2_charger *charger = power_supply_get_drvdata(batt_ps);
+
 	schedule_work(&charger->bat_work);
 }
 
@@ -106,9 +106,10 @@ static void z2_batt_update(struct z2_charger *charger)
 		POWER_SUPPLY_STATUS_UNKNOWN;
 
 	if (old_status != charger->bat_status) {
-		pr_debug("%s: %i -> %i\n", charger->batt_ps.name, old_status,
-			charger->bat_status);
-		power_supply_changed(&charger->batt_ps);
+		pr_debug("%s: %i -> %i\n", charger->batt_ps->desc->name,
+				old_status,
+				charger->bat_status);
+		power_supply_changed(charger->batt_ps);
 	}
 
 	mutex_unlock(&charger->work_lock);
@@ -166,16 +167,17 @@ static int z2_batt_ps_init(struct z2_charger *charger, int props)
 				"Please consider setting proper battery "
 				"name in platform definition file, falling "
 				"back to name \" Z2_DEFAULT_NAME \"\n");
-		charger->batt_ps.name = Z2_DEFAULT_NAME;
+		charger->batt_ps_desc.name = Z2_DEFAULT_NAME;
 	} else
-		charger->batt_ps.name = info->batt_name;
+		charger->batt_ps_desc.name = info->batt_name;
 
-	charger->batt_ps.properties		= prop;
-	charger->batt_ps.num_properties		= props;
-	charger->batt_ps.type			= POWER_SUPPLY_TYPE_BATTERY;
-	charger->batt_ps.get_property		= z2_batt_get_property;
-	charger->batt_ps.external_power_changed	= z2_batt_ext_power_changed;
-	charger->batt_ps.use_for_apm		= 1;
+	charger->batt_ps_desc.properties	= prop;
+	charger->batt_ps_desc.num_properties	= props;
+	charger->batt_ps_desc.type		= POWER_SUPPLY_TYPE_BATTERY;
+	charger->batt_ps_desc.get_property	= z2_batt_get_property;
+	charger->batt_ps_desc.external_power_changed =
+						z2_batt_ext_power_changed;
+	charger->batt_ps_desc.use_for_apm	= 1;
 
 	return 0;
 }
@@ -187,6 +189,7 @@ static int z2_batt_probe(struct i2c_client *client,
 	int props = 1;	/* POWER_SUPPLY_PROP_PRESENT */
 	struct z2_charger *charger;
 	struct z2_battery_info *info = client->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 
 	if (info == NULL) {
 		dev_err(&client->dev,
@@ -203,6 +206,7 @@ static int z2_batt_probe(struct i2c_client *client,
 	charger->info = info;
 	charger->client = client;
 	i2c_set_clientdata(client, charger);
+	psy_cfg.drv_data = charger;
 
 	mutex_init(&charger->work_lock);
 
@@ -230,16 +234,20 @@ static int z2_batt_probe(struct i2c_client *client,
 
 	INIT_WORK(&charger->bat_work, z2_batt_work);
 
-	ret = power_supply_register(&client->dev, &charger->batt_ps, NULL);
-	if (ret)
+	charger->batt_ps = power_supply_register(&client->dev,
+						 &charger->batt_ps_desc,
+						 &psy_cfg);
+	if (IS_ERR(charger->batt_ps)) {
+		ret = PTR_ERR(charger->batt_ps);
 		goto err4;
+	}
 
 	schedule_work(&charger->bat_work);
 
 	return 0;
 
 err4:
-	kfree(charger->batt_ps.properties);
+	kfree(charger->batt_ps_desc.properties);
 err3:
 	if (info->charge_gpio >= 0 && gpio_is_valid(info->charge_gpio))
 		free_irq(gpio_to_irq(info->charge_gpio), charger);
@@ -257,9 +265,9 @@ static int z2_batt_remove(struct i2c_client *client)
 	struct z2_battery_info *info = charger->info;
 
 	cancel_work_sync(&charger->bat_work);
-	power_supply_unregister(&charger->batt_ps);
+	power_supply_unregister(charger->batt_ps);
 
-	kfree(charger->batt_ps.properties);
+	kfree(charger->batt_ps_desc.properties);
 	if (info->charge_gpio >= 0 && gpio_is_valid(info->charge_gpio)) {
 		free_irq(gpio_to_irq(info->charge_gpio), charger);
 		gpio_free(info->charge_gpio);
diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index 4bfa84672818..30b66c3c9b73 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -82,8 +82,8 @@ struct bat_response {
 	};
 };
 
-static struct power_supply nvec_bat_psy;
-static struct power_supply nvec_psy;
+static struct power_supply *nvec_bat_psy;
+static struct power_supply *nvec_psy;
 
 static int nvec_power_notifier(struct notifier_block *nb,
 			       unsigned long event_type, void *data)
@@ -98,7 +98,7 @@ static int nvec_power_notifier(struct notifier_block *nb,
 	if (res->sub_type == 0) {
 		if (power->on != res->plu) {
 			power->on = res->plu;
-			power_supply_changed(&nvec_psy);
+			power_supply_changed(nvec_psy);
 		}
 		return NOTIFY_STOP;
 	}
@@ -167,7 +167,7 @@ static int nvec_power_bat_notifier(struct notifier_block *nb,
 		}
 		power->bat_cap = res->plc[1];
 		if (status_changed)
-			power_supply_changed(&nvec_bat_psy);
+			power_supply_changed(nvec_bat_psy);
 		break;
 	case VOLTAGE:
 		power->bat_voltage_now = res->plu * 1000;
@@ -225,7 +225,7 @@ static int nvec_power_get_property(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   union power_supply_propval *val)
 {
-	struct nvec_power *power = dev_get_drvdata(psy->dev->parent);
+	struct nvec_power *power = dev_get_drvdata(psy->dev.parent);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -241,7 +241,7 @@ static int nvec_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
 {
-	struct nvec_power *power = dev_get_drvdata(psy->dev->parent);
+	struct nvec_power *power = dev_get_drvdata(psy->dev.parent);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -323,7 +323,7 @@ static char *nvec_power_supplied_to[] = {
 	"battery",
 };
 
-static struct power_supply nvec_bat_psy = {
+static const struct power_supply_desc nvec_bat_psy_desc = {
 	.name = "battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
 	.properties = nvec_battery_props,
@@ -331,7 +331,7 @@ static struct power_supply nvec_bat_psy = {
 	.get_property = nvec_battery_get_property,
 };
 
-static struct power_supply nvec_psy = {
+static const struct power_supply_desc nvec_psy_desc = {
 	.name = "ac",
 	.type = POWER_SUPPLY_TYPE_MAINS,
 	.properties = nvec_power_props,
@@ -371,7 +371,8 @@ static void nvec_power_poll(struct work_struct *work)
 
 static int nvec_power_probe(struct platform_device *pdev)
 {
-	struct power_supply *psy;
+	struct power_supply **psy;
+	const struct power_supply_desc *psy_desc;
 	struct nvec_power *power;
 	struct nvec_chip *nvec = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
@@ -386,6 +387,7 @@ static int nvec_power_probe(struct platform_device *pdev)
 	switch (pdev->id) {
 	case AC:
 		psy = &nvec_psy;
+		psy_desc = &nvec_psy_desc;
 		psy_cfg.supplied_to = nvec_power_supplied_to;
 		psy_cfg.num_supplicants = ARRAY_SIZE(nvec_power_supplied_to);
 
@@ -396,6 +398,7 @@ static int nvec_power_probe(struct platform_device *pdev)
 		break;
 	case BAT:
 		psy = &nvec_bat_psy;
+		psy_desc = &nvec_bat_psy_desc;
 
 		power->notifier.notifier_call = nvec_power_bat_notifier;
 		break;
@@ -408,7 +411,9 @@ static int nvec_power_probe(struct platform_device *pdev)
 	if (pdev->id == BAT)
 		get_bat_mfg_data(power);
 
-	return power_supply_register(&pdev->dev, psy, &psy_cfg);
+	*psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(*psy);
 }
 
 static int nvec_power_remove(struct platform_device *pdev)
@@ -419,10 +424,10 @@ static int nvec_power_remove(struct platform_device *pdev)
 	nvec_unregister_notifier(power->nvec, &power->notifier);
 	switch (pdev->id) {
 	case AC:
-		power_supply_unregister(&nvec_psy);
+		power_supply_unregister(nvec_psy);
 		break;
 	case BAT:
-		power_supply_unregister(&nvec_bat_psy);
+		power_supply_unregister(nvec_bat_psy);
 	}
 
 	return 0;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index efc7787a41a8..f94cf28e4b7c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -514,10 +514,10 @@ struct hid_device {							/* device report descriptor */
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
 	 * Power supply information for HID devices which report
-	 * battery strength. power_supply is registered iff
-	 * battery.name is non-NULL.
+	 * battery strength. power_supply was successfully registered if
+	 * battery is non-NULL.
 	 */
-	struct power_supply battery;
+	struct power_supply *battery;
 	__s32 battery_min;
 	__s32 battery_max;
 	__s32 battery_report_type;
diff --git a/include/linux/mfd/abx500/ux500_chargalg.h b/include/linux/mfd/abx500/ux500_chargalg.h
index 234c99143bf7..67703f23e7ba 100644
--- a/include/linux/mfd/abx500/ux500_chargalg.h
+++ b/include/linux/mfd/abx500/ux500_chargalg.h
@@ -9,8 +9,13 @@
 
 #include <linux/power_supply.h>
 
-#define psy_to_ux500_charger(x) container_of((x), \
-		struct ux500_charger, psy)
+/*
+ * Valid only for supplies of type:
+ * - POWER_SUPPLY_TYPE_MAINS,
+ * - POWER_SUPPLY_TYPE_USB,
+ * because only them store as drv_data pointer to struct ux500_charger.
+ */
+#define psy_to_ux500_charger(x) power_supply_get_drvdata(psy)
 
 /* Forward declaration */
 struct ux500_charger;
@@ -35,7 +40,7 @@ struct ux500_charger_ops {
  * @power_path		USB power path support
  */
 struct ux500_charger {
-	struct power_supply psy;
+	struct power_supply *psy;
 	struct ux500_charger_ops ops;
 	int max_out_volt;
 	int max_out_curr;
diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
index 010cff49a98e..6cff5cf458d2 100644
--- a/include/linux/mfd/rt5033.h
+++ b/include/linux/mfd/rt5033.h
@@ -39,7 +39,7 @@ struct rt5033_battery {
 	struct i2c_client	*client;
 	struct rt5033_dev	*rt5033;
 	struct regmap		*regmap;
-	struct power_supply	psy;
+	struct power_supply	*psy;
 };
 
 /* RT5033 charger platform data */
diff --git a/include/linux/mfd/wm8350/supply.h b/include/linux/mfd/wm8350/supply.h
index 2b9479310bbd..8dc93673e34a 100644
--- a/include/linux/mfd/wm8350/supply.h
+++ b/include/linux/mfd/wm8350/supply.h
@@ -123,9 +123,9 @@ struct wm8350_charger_policy {
 
 struct wm8350_power {
 	struct platform_device *pdev;
-	struct power_supply battery;
-	struct power_supply usb;
-	struct power_supply ac;
+	struct power_supply *battery;
+	struct power_supply *usb;
+	struct power_supply *ac;
 	struct wm8350_charger_policy *policy;
 
 	int rev_g_coeff;
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 416ebeb6ee1e..eadf28cb2fc9 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -242,7 +242,8 @@ struct charger_manager {
 	int emergency_stop;
 
 	char psy_name_buf[PSY_NAME_MAX + 1];
-	struct power_supply charger_psy;
+	struct power_supply_desc charger_psy_desc;
+	struct power_supply *charger_psy;
 
 	u64 charging_start_time;
 	u64 charging_end_time;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 5d460995f38d..54ebac5e3fe3 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -13,6 +13,7 @@
 #ifndef __LINUX_POWER_SUPPLY_H__
 #define __LINUX_POWER_SUPPLY_H__
 
+#include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/leds.h>
 #include <linux/spinlock.h>
@@ -173,10 +174,10 @@ union power_supply_propval {
 	const char *strval;
 };
 
-struct device;
 struct device_node;
+struct power_supply;
 
-/* Power supply instance specific configuration */
+/* Run-time specific power supply configuration */
 struct power_supply_config {
 	struct device_node *of_node;
 	/* Driver private data */
@@ -186,19 +187,13 @@ struct power_supply_config {
 	size_t num_supplicants;
 };
 
-struct power_supply {
+/* Description of power supply */
+struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
 	enum power_supply_property *properties;
 	size_t num_properties;
 
-	char **supplied_to;
-	size_t num_supplicants;
-
-	char **supplied_from;
-	size_t num_supplies;
-	struct device_node *of_node;
-
 	/*
 	 * Functions for drivers implementing power supply class.
 	 * These shouldn't be called directly by other drivers for accessing
@@ -224,12 +219,23 @@ struct power_supply {
 	bool no_thermal;
 	/* For APM emulation, think legacy userspace. */
 	int use_for_apm;
+};
+
+struct power_supply {
+	const struct power_supply_desc *desc;
+
+	char **supplied_to;
+	size_t num_supplicants;
+
+	char **supplied_from;
+	size_t num_supplies;
+	struct device_node *of_node;
 
 	/* Driver private data */
 	void *drv_data;
 
 	/* private */
-	struct device *dev;
+	struct device dev;
 	struct work_struct changed_work;
 	spinlock_t changed_lock;
 	bool changed;
@@ -303,11 +309,14 @@ extern int power_supply_set_property(struct power_supply *psy,
 extern int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp);
 extern void power_supply_external_power_changed(struct power_supply *psy);
-extern int power_supply_register(struct device *parent,
-				 struct power_supply *psy,
+
+extern struct power_supply *__must_check
+power_supply_register(struct device *parent,
+				 const struct power_supply_desc *desc,
 				 const struct power_supply_config *cfg);
-extern int power_supply_register_no_ws(struct device *parent,
-				 struct power_supply *psy,
+extern struct power_supply *__must_check
+power_supply_register_no_ws(struct device *parent,
+				 const struct power_supply_desc *desc,
 				 const struct power_supply_config *cfg);
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
-- 
1.9.1

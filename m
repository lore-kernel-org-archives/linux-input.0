From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 7/7] thinkpad_acpi: use DEVICE_ATTR_* macros
Date: Fri, 20 Feb 2015 15:44:41 +0100
Message-ID: <1424443481.22910.19.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Use the DEVICE_ATTR_RW macro to reduce boiler plate and move the
attribute declaration to get rid of function signatures.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 72 ++++++++++--------------------------
 1 file changed, 20 insertions(+), 52 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 535095d..4b31492 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2668,9 +2668,7 @@ static ssize_t hotkey_enable_store(struct device *dev,
 	return count;
 }
 
-static struct device_attribute dev_attr_hotkey_enable =
-	__ATTR(hotkey_enable, S_IWUSR | S_IRUGO,
-		hotkey_enable_show, hotkey_enable_store);
+static DEVICE_ATTR_RW(hotkey_enable);
 
 /* sysfs hotkey mask --------------------------------------------------- */
 static ssize_t hotkey_mask_show(struct device *dev,
@@ -2706,9 +2704,7 @@ static ssize_t hotkey_mask_store(struct device *dev,
 	return (res) ? res : count;
 }
 
-static struct device_attribute dev_attr_hotkey_mask =
-	__ATTR(hotkey_mask, S_IWUSR | S_IRUGO,
-		hotkey_mask_show, hotkey_mask_store);
+static DEVICE_ATTR_RW(hotkey_mask);
 
 /* sysfs hotkey bios_enabled ------------------------------------------- */
 static ssize_t hotkey_bios_enabled_show(struct device *dev,
@@ -2718,8 +2714,7 @@ static ssize_t hotkey_bios_enabled_show(struct device *dev,
 	return sprintf(buf, "0\n");
 }
 
-static struct device_attribute dev_attr_hotkey_bios_enabled =
-	__ATTR(hotkey_bios_enabled, S_IRUGO, hotkey_bios_enabled_show, NULL);
+static DEVICE_ATTR_RO(hotkey_bios_enabled);
 
 /* sysfs hotkey bios_mask ---------------------------------------------- */
 static ssize_t hotkey_bios_mask_show(struct device *dev,
@@ -2731,8 +2726,7 @@ static ssize_t hotkey_bios_mask_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_orig_mask);
 }
 
-static struct device_attribute dev_attr_hotkey_bios_mask =
-	__ATTR(hotkey_bios_mask, S_IRUGO, hotkey_bios_mask_show, NULL);
+static DEVICE_ATTR_RO(hotkey_bios_mask);
 
 /* sysfs hotkey all_mask ----------------------------------------------- */
 static ssize_t hotkey_all_mask_show(struct device *dev,
@@ -2743,8 +2737,7 @@ static ssize_t hotkey_all_mask_show(struct device *dev,
 				hotkey_all_mask | hotkey_source_mask);
 }
 
-static struct device_attribute dev_attr_hotkey_all_mask =
-	__ATTR(hotkey_all_mask, S_IRUGO, hotkey_all_mask_show, NULL);
+static DEVICE_ATTR_RO(hotkey_all_mask);
 
 /* sysfs hotkey recommended_mask --------------------------------------- */
 static ssize_t hotkey_recommended_mask_show(struct device *dev,
@@ -2756,9 +2749,7 @@ static ssize_t hotkey_recommended_mask_show(struct device *dev,
 			& ~hotkey_reserved_mask);
 }
 
-static struct device_attribute dev_attr_hotkey_recommended_mask =
-	__ATTR(hotkey_recommended_mask, S_IRUGO,
-		hotkey_recommended_mask_show, NULL);
+static DEVICE_ATTR_RO(hotkey_recommended_mask);
 
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 
@@ -2813,9 +2804,7 @@ static ssize_t hotkey_source_mask_store(struct device *dev,
 	return (rc < 0) ? rc : count;
 }
 
-static struct device_attribute dev_attr_hotkey_source_mask =
-	__ATTR(hotkey_source_mask, S_IWUSR | S_IRUGO,
-		hotkey_source_mask_show, hotkey_source_mask_store);
+static DEVICE_ATTR_RW(hotkey_source_mask);
 
 /* sysfs hotkey hotkey_poll_freq --------------------------------------- */
 static ssize_t hotkey_poll_freq_show(struct device *dev,
@@ -2847,9 +2836,7 @@ static ssize_t hotkey_poll_freq_store(struct device *dev,
 	return count;
 }
 
-static struct device_attribute dev_attr_hotkey_poll_freq =
-	__ATTR(hotkey_poll_freq, S_IWUSR | S_IRUGO,
-		hotkey_poll_freq_show, hotkey_poll_freq_store);
+static DEVICE_ATTR_RW(hotkey_poll_freq);
 
 #endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
@@ -2870,8 +2857,7 @@ static ssize_t hotkey_radio_sw_show(struct device *dev,
 			(res == TPACPI_RFK_RADIO_OFF) ? 0 : 1);
 }
 
-static struct device_attribute dev_attr_hotkey_radio_sw =
-	__ATTR(hotkey_radio_sw, S_IRUGO, hotkey_radio_sw_show, NULL);
+static DEVICE_ATTR_RO(hotkey_radio_sw);
 
 static void hotkey_radio_sw_notify_change(void)
 {
@@ -2893,8 +2879,7 @@ static ssize_t hotkey_tablet_mode_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", !!s);
 }
 
-static struct device_attribute dev_attr_hotkey_tablet_mode =
-	__ATTR(hotkey_tablet_mode, S_IRUGO, hotkey_tablet_mode_show, NULL);
+static DEVICE_ATTR_RO(hotkey_tablet_mode);
 
 static void hotkey_tablet_mode_notify_change(void)
 {
@@ -2911,8 +2896,7 @@ static ssize_t hotkey_wakeup_reason_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_wakeup_reason);
 }
 
-static struct device_attribute dev_attr_hotkey_wakeup_reason =
-	__ATTR(wakeup_reason, S_IRUGO, hotkey_wakeup_reason_show, NULL);
+static DEVICE_ATTR_RO(hotkey_wakeup_reason);
 
 static void hotkey_wakeup_reason_notify_change(void)
 {
@@ -2928,9 +2912,7 @@ static ssize_t hotkey_wakeup_hotunplug_complete_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_autosleep_ack);
 }
 
-static struct device_attribute dev_attr_hotkey_wakeup_hotunplug_complete =
-	__ATTR(wakeup_hotunplug_complete, S_IRUGO,
-	       hotkey_wakeup_hotunplug_complete_show, NULL);
+static DEVICE_ATTR_RO(hotkey_wakeup_hotunplug_complete);
 
 static void hotkey_wakeup_hotunplug_complete_notify_change(void)
 {
@@ -4220,9 +4202,7 @@ static ssize_t bluetooth_enable_store(struct device *dev,
 				attr, buf, count);
 }
 
-static struct device_attribute dev_attr_bluetooth_enable =
-	__ATTR(bluetooth_enable, S_IWUSR | S_IRUGO,
-		bluetooth_enable_show, bluetooth_enable_store);
+static DEVICE_ATTR_RW(bluetooth_enable);
 
 /* --------------------------------------------------------------------- */
 
@@ -4410,9 +4390,7 @@ static ssize_t wan_enable_store(struct device *dev,
 			attr, buf, count);
 }
 
-static struct device_attribute dev_attr_wan_enable =
-	__ATTR(wwan_enable, S_IWUSR | S_IRUGO,
-		wan_enable_show, wan_enable_store);
+static DEVICE_ATTR_RW(wan_enable);
 
 /* --------------------------------------------------------------------- */
 
@@ -5189,8 +5167,7 @@ static ssize_t cmos_command_store(struct device *dev,
 	return (res) ? res : count;
 }
 
-static struct device_attribute dev_attr_cmos_command =
-	__ATTR(cmos_command, S_IWUSR, NULL, cmos_command_store);
+static DEVICE_ATTR_WO(cmos_command);
 
 /* --------------------------------------------------------------------- */
 
@@ -8158,9 +8135,7 @@ static ssize_t fan_pwm1_enable_store(struct device *dev,
 	return count;
 }
 
-static struct device_attribute dev_attr_fan_pwm1_enable =
-	__ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
-		fan_pwm1_enable_show, fan_pwm1_enable_store);
+static DEVICE_ATTR_RW(fan_pwm1_enable);
 
 /* sysfs fan pwm1 ------------------------------------------------------ */
 static ssize_t fan_pwm1_show(struct device *dev,
@@ -8220,9 +8195,7 @@ static ssize_t fan_pwm1_store(struct device *dev,
 	return (rc) ? rc : count;
 }
 
-static struct device_attribute dev_attr_fan_pwm1 =
-	__ATTR(pwm1, S_IWUSR | S_IRUGO,
-		fan_pwm1_show, fan_pwm1_store);
+static DEVICE_ATTR_RW(fan_pwm1);
 
 /* sysfs fan fan1_input ------------------------------------------------ */
 static ssize_t fan_fan1_input_show(struct device *dev,
@@ -8239,9 +8212,7 @@ static ssize_t fan_fan1_input_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
 }
 
-static struct device_attribute dev_attr_fan_fan1_input =
-	__ATTR(fan1_input, S_IRUGO,
-		fan_fan1_input_show, NULL);
+static DEVICE_ATTR_RO(fan_fan1_input);
 
 /* sysfs fan fan2_input ------------------------------------------------ */
 static ssize_t fan_fan2_input_show(struct device *dev,
@@ -8258,9 +8229,7 @@ static ssize_t fan_fan2_input_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%u\n", speed);
 }
 
-static struct device_attribute dev_attr_fan_fan2_input =
-	__ATTR(fan2_input, S_IRUGO,
-		fan_fan2_input_show, NULL);
+static DEVICE_ATTR_RO(fan_fan2_input);
 
 /* sysfs fan fan_watchdog (hwmon driver) ------------------------------- */
 static ssize_t fan_fan_watchdog_show(struct device_driver *drv,
@@ -8876,8 +8845,7 @@ static ssize_t thinkpad_acpi_pdev_name_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", TPACPI_NAME);
 }
 
-static struct device_attribute dev_attr_thinkpad_acpi_pdev_name =
-	__ATTR(name, S_IRUGO, thinkpad_acpi_pdev_name_show, NULL);
+static DEVICE_ATTR_RO(thinkpad_acpi_pdev_name);
 
 /* --------------------------------------------------------------------- */
 
-- 
2.1.0

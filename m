From: Dudley Du <dudlx@outlook.com>
Subject: [PATCH v7 02/13] input: cyapa: add cyapa driver power management interfaces support
Date: Fri, 19 Sep 2014 09:46:25 +0800
Message-ID: <BAY176-DS1023C6738AEA89A1BC85DBDB40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se
Cc: bleung@google.com, patrikf@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add suspend_scanrate_ms power management interfaces in device's
power group, so users or applications can control the power management
strategy of trackpad device as their requirements.
TEST=test on Chromebooks.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index db5e500..249768e 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -433,6 +433,82 @@ u16 cyapa_pwr_cmd_to_sleep_time(u8 pwr_mode)
 				   : (encoded_time - 5) * 20;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static ssize_t cyapa_show_suspend_scanrate(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cyapa *cyapa = dev_get_drvdata(dev);
+	u8 pwr_cmd = cyapa->suspend_power_mode;
+	u16 sleep_time;
+	int len;
+
+	mutex_lock(&cyapa->state_sync_lock);
+	pwr_cmd = cyapa->suspend_power_mode;
+	sleep_time = cyapa->suspend_sleep_time;
+	mutex_unlock(&cyapa->state_sync_lock);
+
+	if (pwr_cmd == PWR_MODE_BTN_ONLY)
+		len = scnprintf(buf, PAGE_SIZE, "%s\n", BTN_ONLY_MODE_NAME);
+	else if (pwr_cmd == PWR_MODE_OFF)
+		len = scnprintf(buf, PAGE_SIZE, "%s\n", OFF_MODE_NAME);
+	else {
+		if (cyapa->gen == CYAPA_GEN3)
+			sleep_time = cyapa_pwr_cmd_to_sleep_time(pwr_cmd);
+		len = scnprintf(buf, PAGE_SIZE, "%u\n", sleep_time);
+	}
+
+	return len;
+}
+
+static u16 cyapa_clamp_sleep_time(u16 sleep_time)
+{
+	if (sleep_time > 1000)
+		sleep_time = 1000;
+	return sleep_time;
+}
+
+static ssize_t cyapa_update_suspend_scanrate(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct cyapa *cyapa = dev_get_drvdata(dev);
+	u16 sleep_time;
+
+	mutex_lock(&cyapa->state_sync_lock);
+
+	if (sysfs_streq(buf, BTN_ONLY_MODE_NAME))
+		cyapa->suspend_power_mode = PWR_MODE_BTN_ONLY;
+	else if (sysfs_streq(buf, OFF_MODE_NAME))
+		cyapa->suspend_power_mode = PWR_MODE_OFF;
+	else if (!kstrtou16(buf, 10, &sleep_time)) {
+		cyapa->suspend_sleep_time = cyapa_clamp_sleep_time(sleep_time);
+		cyapa->suspend_power_mode =
+			cyapa_sleep_time_to_pwr_cmd(cyapa->suspend_sleep_time);
+	} else
+		count = 0;
+
+	mutex_unlock(&cyapa->state_sync_lock);
+	if (!count)
+		dev_err(dev, "invalid suspend scanrate ms parameters\n");
+	return count ? count : -EINVAL;
+}
+
+static DEVICE_ATTR(suspend_scanrate_ms, S_IRUGO|S_IWUSR,
+		   cyapa_show_suspend_scanrate,
+		   cyapa_update_suspend_scanrate);
+
+static struct attribute *cyapa_power_wakeup_entries[] = {
+	&dev_attr_suspend_scanrate_ms.attr,
+	NULL,
+};
+
+static const struct attribute_group cyapa_power_wakeup_group = {
+	.name = power_group_name,
+	.attrs = cyapa_power_wakeup_entries,
+};
+#endif /* CONFIG_PM_SLEEP */
+
 void cyapa_detect_async(void *data, async_cookie_t cookie)
 {
 	struct cyapa *cyapa = (struct cyapa *)data;
@@ -527,6 +603,12 @@ static int cyapa_probe(struct i2c_client *client,
 		goto err_uninit_tp_modules;
 	}
 
+#ifdef CONFIG_PM_SLEEP
+	if (device_can_wakeup(dev) &&
+	    sysfs_merge_group(&client->dev.kobj, &cyapa_power_wakeup_group))
+		dev_warn(dev, "error creating wakeup power entries.\n");
+#endif /* CONFIG_PM_SLEEP */
+
 	async_schedule(cyapa_detect_and_start, cyapa);
 	return 0;
 
@@ -549,6 +631,9 @@ static int cyapa_remove(struct i2c_client *client)
 	cyapa->removed = true;
 	mutex_unlock(&cyapa->state_sync_lock);
 
+#ifdef CONFIG_PM_SLEEP
+	sysfs_unmerge_group(&client->dev.kobj, &cyapa_power_wakeup_group);
+#endif
 	free_irq(cyapa->irq, cyapa);
 
 	input_unregister_device(cyapa->input);
-- 
1.9.1

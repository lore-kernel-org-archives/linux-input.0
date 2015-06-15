From: Dudley Du <dudl@cypress.com>
Subject: [PATCH v1 5/7] input: cyapa: add proximity and interrupt sysfs interfaces support
Date: Mon, 15 Jun 2015 17:01:35 +0800
Message-ID: <1434358897-24668-6-git-send-email-dudl@cypress.com>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.cypress.com ([157.95.67.100]:53547 "EHLO
	smtp1.cypress.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbbFOJKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 05:10:10 -0400
In-Reply-To: <1434358897-24668-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Add proximity and interrupt control interfaces in sysfs device node.
The proximity interface is used to disable/enable proximity function in
device. Through this interface, user can apply their own specific strategy
to use the proximity function compared to the default strategy.
For example, some products may need the proximity function, but some may
be not. And for a running system, the requirements for the proximity
function may be also different in the different usage state, so user/app
can fully own its specific strategy and change the proximity function
through this interface.
Currently, the default strategy of the proximity function is that the
proximity function will be always enabled when the trackpad device enters
into the active mode, ignore the previous setting of the proximity
function.
The interrupt interface is used to disable/enable interrupt from the
device. Through this interrupt interface, user can temporary
disable/enable the trackpad device to report data to host system, or
disable the event process that driven by the interrupt event from the
trackpad device, so it can help to avoid the unload/reload process of the
driver which will cause the additional processing to re-initialize the
trackpad device. It would be helpful in firmware debugging.
TEST=test on Chromebook.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c      | 101 +++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/cyapa.h      |   4 ++
 drivers/input/mouse/cyapa_gen3.c |   1 +
 drivers/input/mouse/cyapa_gen5.c |   2 +
 drivers/input/mouse/cyapa_gen6.c |  14 ++++++
 5 files changed, 122 insertions(+)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 9288948..4e69594 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -594,6 +594,7 @@ static int cyapa_initialize(struct cyapa *cyapa)
 
 	cyapa->state = CYAPA_STATE_NO_DEVICE;
 	cyapa->gen = CYAPA_GEN_UNKNOWN;
+	cyapa->interrupt = true;
 	mutex_init(&cyapa->state_sync_lock);
 
 	/*
@@ -1217,12 +1218,110 @@ static ssize_t cyapa_show_mode(struct device *dev,
 	return size;
 }
 
+static ssize_t cyapa_show_interrupt(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cyapa *cyapa = dev_get_drvdata(dev);
+	int size;
+	int error;
+
+	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	if (error)
+		return error;
+
+	size = scnprintf(buf, PAGE_SIZE, "%d\n", cyapa->interrupt ? 1 : 0);
+
+	mutex_unlock(&cyapa->state_sync_lock);
+	return size;
+}
+
+static ssize_t cyapa_interrupt_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct cyapa *cyapa = dev_get_drvdata(dev);
+	u16 value;
+	int error;
+
+	if (cyapa->gen < CYAPA_GEN6)
+		return -EOPNOTSUPP;
+
+	if (kstrtou16(buf, 10, &value)) {
+		dev_err(dev, "invalid interrupt set parameter\n");
+		return -EINVAL;
+	}
+
+	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	if (error)
+		return error;
+
+	if (cyapa->operational)
+		error = cyapa->ops->set_interrupt(cyapa,
+						  value ? true : false);
+	else
+		error = -EBUSY;  /* Still running in bootloader mode. */
+
+	mutex_unlock(&cyapa->state_sync_lock);
+	return error < 0 ? error : count;
+}
+
+static ssize_t cyapa_show_proximity(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cyapa *cyapa = dev_get_drvdata(dev);
+	int size;
+	int error;
+
+	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	if (error)
+		return error;
+
+	size = scnprintf(buf, PAGE_SIZE, "%d\n", cyapa->proximity ? 1 : 0);
+
+	mutex_unlock(&cyapa->state_sync_lock);
+	return size;
+}
+
+static ssize_t cyapa_proximity_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct cyapa *cyapa = dev_get_drvdata(dev);
+	u16 value;
+	int error;
+
+	if (cyapa->gen < CYAPA_GEN5)
+		return -EOPNOTSUPP;
+
+	if (kstrtou16(buf, 10, &value)) {
+		dev_err(dev, "invalid set value of proximity\n");
+		return -EINVAL;
+	}
+
+	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	if (error)
+		return error;
+
+	if (cyapa->operational)
+		error = cyapa->ops->set_proximity(cyapa,
+						  value ? true : false);
+	else
+		error = -EBUSY;  /* Still running in bootloader mode. */
+
+	mutex_unlock(&cyapa->state_sync_lock);
+	return error < 0 ? error : count;
+}
+
 static DEVICE_ATTR(firmware_version, S_IRUGO, cyapa_show_fm_ver, NULL);
 static DEVICE_ATTR(product_id, S_IRUGO, cyapa_show_product_id, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, cyapa_update_fw_store);
 static DEVICE_ATTR(baseline, S_IRUGO, cyapa_show_baseline, NULL);
 static DEVICE_ATTR(calibrate, S_IWUSR, NULL, cyapa_calibrate_store);
 static DEVICE_ATTR(mode, S_IRUGO, cyapa_show_mode, NULL);
+static DEVICE_ATTR(interrupt, S_IRUGO | S_IWUSR,
+		   cyapa_show_interrupt, cyapa_interrupt_store);
+static DEVICE_ATTR(proximity, S_IRUGO | S_IWUSR,
+		   cyapa_show_proximity, cyapa_proximity_store);
 
 static struct attribute *cyapa_sysfs_entries[] = {
 	&dev_attr_firmware_version.attr,
@@ -1231,6 +1330,8 @@ static struct attribute *cyapa_sysfs_entries[] = {
 	&dev_attr_baseline.attr,
 	&dev_attr_calibrate.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_interrupt.attr,
+	&dev_attr_proximity.attr,
 	NULL,
 };
 
diff --git a/drivers/input/mouse/cyapa.h b/drivers/input/mouse/cyapa.h
index a734ab8..ed79d3a 100644
--- a/drivers/input/mouse/cyapa.h
+++ b/drivers/input/mouse/cyapa.h
@@ -275,6 +275,7 @@ struct cyapa_dev_ops {
 
 	int (*set_power_mode)(struct cyapa *, u8, u16, bool);
 
+	int (*set_interrupt)(struct cyapa *, bool);
 	int (*set_proximity)(struct cyapa *, bool);
 };
 
@@ -365,6 +366,9 @@ struct cyapa {
 	 */
 	struct mutex state_sync_lock;
 
+	bool interrupt;
+	bool proximity;
+
 	const struct cyapa_dev_ops *ops;
 
 	union cyapa_cmd_states cmd_states;
diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index 1274b3f..3956dfb 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -1244,5 +1244,6 @@ const struct cyapa_dev_ops cyapa_gen3_ops = {
 	.sort_empty_output_data = cyapa_gen3_empty_output_data,
 	.set_power_mode = cyapa_gen3_set_power_mode,
 
+	.set_interrupt = cyapa_set_not_supported,
 	.set_proximity = cyapa_set_not_supported,
 };
diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index e311b1b..2bb8be6 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -1544,6 +1544,7 @@ int cyapa_pip_set_proximity(struct cyapa *cyapa, bool enable)
 		return error < 0 ? error : -EINVAL;
 	}
 
+	cyapa->proximity = enable;
 	return 0;
 }
 
@@ -2836,5 +2837,6 @@ const struct cyapa_dev_ops cyapa_gen5_ops = {
 	.sort_empty_output_data = cyapa_empty_pip_output_data,
 	.set_power_mode = cyapa_gen5_set_power_mode,
 
+	.set_interrupt = cyapa_set_not_supported,
 	.set_proximity = cyapa_pip_set_proximity,
 };
diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index f2287ed..16cc7ed 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -307,9 +307,22 @@ static int cyapa_gen6_config_dev_irq(struct cyapa *cyapa, u8 cmd_code)
 			)
 		return error < 0 ? error : -EINVAL;
 
+	if (cmd_code == GEN6_ENABLE_DEV_IRQ)
+		cyapa->interrupt = true;
+	else if (cmd_code == GEN6_DISABLE_DEV_IRQ)
+		cyapa->interrupt = false;
+
 	return 0;
 }
 
+static int cyapa_gen6_set_interrupt(struct cyapa *cyapa, bool enable)
+{
+	if (enable)
+		return cyapa_gen6_config_dev_irq(cyapa, GEN6_ENABLE_DEV_IRQ);
+	else
+		return cyapa_gen6_config_dev_irq(cyapa, GEN6_DISABLE_DEV_IRQ);
+}
+
 static int cyapa_gen6_set_proximity(struct cyapa *cyapa, bool enable)
 {
 	int error;
@@ -742,5 +755,6 @@ const struct cyapa_dev_ops cyapa_gen6_ops = {
 	.sort_empty_output_data = cyapa_empty_pip_output_data,
 	.set_power_mode = cyapa_gen6_set_power_mode,
 
+	.set_interrupt = cyapa_gen6_set_interrupt,
 	.set_proximity = cyapa_gen6_set_proximity,
 };
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------


From: Simon Wood <gitsend@mungewell.org>
Subject: [PATCH 1/5] HID:hid-logitech: Introduce dev_attr for combined pedals feature
Date: Fri,  9 Sep 2016 16:50:45 -0600
Message-ID: <1473461449-8060-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Introduce a dev_attr which can be used to combine the accelerator
and brake pedals into a single axis. This is useful for older games
which can not handle separate accelerator and brake.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  9 ++++
 drivers/hid/hid-lg4ff.c                            | 58 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
index db197a8..69fb890 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
@@ -50,3 +50,12 @@ Description:	Displays the real model of the wheel regardless of any
 		alternate mode the wheel might be switched to.
 		It is a read-only value.
 		This entry is not created for devices that have only one mode.
+
+What:		/sys/bus/hid/drivers/logitech/<dev>/combine_pedals
+Date:		Sep 2016
+KernelVersion:	4.9
+Contact:	Simon Wood <simon@mungewell.org>
+Description:	Controls whether a combined value of accelerator and brake is
+		reported on the Y axis of the controller. Useful for older games
+		which can do not work with separate accelerator/brake axis.
+		Off ('0') by default, enabled by setting '1'.
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index af3a8ec..ca31ce4 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -75,6 +75,7 @@ static void lg4ff_set_range_g25(struct hid_device *hid, u16 range);
 
 struct lg4ff_wheel_data {
 	const u32 product_id;
+	u16 combine;
 	u16 range;
 	const u16 min_range;
 	const u16 max_range;
@@ -345,6 +346,7 @@ static void lg4ff_init_wheel_data(struct lg4ff_wheel_data * const wdata, const s
 	{
 		struct lg4ff_wheel_data t_wdata =  { .product_id = wheel->product_id,
 						     .real_product_id = real_product_id,
+						     .combine = 0,
 						     .min_range = wheel->min_range,
 						     .max_range = wheel->max_range,
 						     .set_range = wheel->set_range,
@@ -885,6 +887,58 @@ static ssize_t lg4ff_alternate_modes_store(struct device *dev, struct device_att
 }
 static DEVICE_ATTR(alternate_modes, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, lg4ff_alternate_modes_show, lg4ff_alternate_modes_store);
 
+static ssize_t lg4ff_combine_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hid_device *hid = to_hid_device(dev);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	size_t count;
+
+	drv_data = hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return 0;
+	}
+
+	entry = drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return 0;
+	}
+
+	count = scnprintf(buf, PAGE_SIZE, "%u\n", entry->wdata.combine);
+	return count;
+}
+
+static ssize_t lg4ff_combine_store(struct device *dev, struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct hid_device *hid = to_hid_device(dev);
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+	u16 combine = simple_strtoul(buf, NULL, 10);
+
+	drv_data = hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return -EINVAL;
+	}
+
+	entry = drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return -EINVAL;
+	}
+
+	if (combine > 1)
+		combine = 1;
+
+	entry->wdata.combine = combine;
+	return count;
+}
+static DEVICE_ATTR(combine_pedals, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, lg4ff_combine_show, lg4ff_combine_store);
+
 /* Export the currently set range of the wheel */
 static ssize_t lg4ff_range_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
@@ -1259,6 +1313,9 @@ int lg4ff_init(struct hid_device *hid)
 	}
 
 	/* Create sysfs interface */
+	error = device_create_file(&hid->dev, &dev_attr_combine_pedals);
+	if (error)
+		hid_warn(hid, "Unable to create sysfs interface for \"combine\", errno %d\n", error);
 	error = device_create_file(&hid->dev, &dev_attr_range);
 	if (error)
 		hid_warn(hid, "Unable to create sysfs interface for \"range\", errno %d\n", error);
@@ -1358,6 +1415,7 @@ int lg4ff_deinit(struct hid_device *hid)
 		device_remove_file(&hid->dev, &dev_attr_alternate_modes);
 	}
 
+	device_remove_file(&hid->dev, &dev_attr_combine_pedals);
 	device_remove_file(&hid->dev, &dev_attr_range);
 #ifdef CONFIG_LEDS_CLASS
 	{
-- 
2.7.4

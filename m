From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 2/5] HID: use to_hid_device()
Date: Sun, 27 Dec 2015 17:25:21 +0800
Message-ID: <3c9a720e58ea32c5df098cbe744c6b5821a756a6.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
In-Reply-To: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, David Herrmann <dh.herrmann@googlemail.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use to_hid_device() instead of container_of().

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/hid/hid-core.c         | 16 ++++++++--------
 drivers/hid/hid-cp2112.c       |  8 ++++----
 drivers/hid/hid-gt683r.c       |  8 +++-----
 drivers/hid/hid-lenovo.c       | 36 ++++++++++++++++++------------------
 drivers/hid/hid-lg4ff.c        |  4 ++--
 drivers/hid/hid-multitouch.c   |  4 ++--
 drivers/hid/hid-ntrig.c        | 32 ++++++++++++++++----------------
 drivers/hid/hid-picolcd_leds.c |  4 ++--
 drivers/hid/hid-prodikeys.c    | 12 ++++++------
 drivers/hid/hid-sony.c         |  6 +++---
 drivers/hid/hid-steelseries.c  |  8 ++++----
 drivers/hid/hid-wiimote.h      |  3 +--
 drivers/hid/wacom_sys.c        | 16 ++++++++--------
 13 files changed, 77 insertions(+), 80 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ab8aa5..3abff97 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -625,7 +625,7 @@ static void hid_close_report(struct hid_device *device)
 
 static void hid_device_release(struct device *dev)
 {
-	struct hid_device *hid = container_of(dev, struct hid_device, dev);
+	struct hid_device *hid = to_hid_device(dev);
 
 	hid_close_report(hid);
 	kfree(hid->dev_rdesc);
@@ -1572,7 +1572,7 @@ read_report_descriptor(struct file *filp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 
 	if (off >= hdev->rsize)
 		return 0;
@@ -1589,7 +1589,7 @@ static ssize_t
 show_country(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 
 	return sprintf(buf, "%02x\n", hdev->country & 0xff);
 }
@@ -2134,7 +2134,7 @@ static const struct hid_device_id *hid_match_device(struct hid_device *hdev,
 static int hid_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct hid_driver *hdrv = container_of(drv, struct hid_driver, driver);
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 
 	return hid_match_device(hdev, hdrv) != NULL;
 }
@@ -2143,7 +2143,7 @@ static int hid_device_probe(struct device *dev)
 {
 	struct hid_driver *hdrv = container_of(dev->driver,
 			struct hid_driver, driver);
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	const struct hid_device_id *id;
 	int ret = 0;
 
@@ -2185,7 +2185,7 @@ unlock_driver_lock:
 
 static int hid_device_remove(struct device *dev)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct hid_driver *hdrv;
 	int ret = 0;
 
@@ -2217,7 +2217,7 @@ unlock_driver_lock:
 static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 			     char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 
 	return scnprintf(buf, PAGE_SIZE, "hid:b%04Xg%04Xv%08Xp%08X\n",
 			 hdev->bus, hdev->group, hdev->vendor, hdev->product);
@@ -2240,7 +2240,7 @@ __ATTRIBUTE_GROUPS(hid_dev);
 
 static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 
 	if (add_uevent_var(env, "HID_ID=%04X:%08X:%08X",
 			hdev->bus, hdev->vendor, hdev->product))
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index f47954e..9bb6676 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -807,7 +807,7 @@ static ssize_t name##_store(struct device *kdev, \
 			    struct device_attribute *attr, const char *buf, \
 			    size_t count) \
 { \
-	struct hid_device *hdev = container_of(kdev, struct hid_device, dev); \
+	struct hid_device *hdev = to_hid_device(kdev); \
 	struct cp2112_usb_config_report cfg; \
 	int ret = cp2112_get_usb_config(hdev, &cfg); \
 	if (ret) \
@@ -822,7 +822,7 @@ static ssize_t name##_store(struct device *kdev, \
 static ssize_t name##_show(struct device *kdev, \
 			   struct device_attribute *attr, char *buf) \
 { \
-	struct hid_device *hdev = container_of(kdev, struct hid_device, dev); \
+	struct hid_device *hdev = to_hid_device(kdev); \
 	struct cp2112_usb_config_report cfg; \
 	int ret = cp2112_get_usb_config(hdev, &cfg); \
 	if (ret) \
@@ -887,7 +887,7 @@ static ssize_t pstr_store(struct device *kdev,
 			  struct device_attribute *kattr, const char *buf,
 			  size_t count)
 {
-	struct hid_device *hdev = container_of(kdev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(kdev);
 	struct cp2112_pstring_attribute *attr =
 		container_of(kattr, struct cp2112_pstring_attribute, attr);
 	struct cp2112_string_report report;
@@ -918,7 +918,7 @@ static ssize_t pstr_store(struct device *kdev,
 static ssize_t pstr_show(struct device *kdev,
 			 struct device_attribute *kattr, char *buf)
 {
-	struct hid_device *hdev = container_of(kdev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(kdev);
 	struct cp2112_pstring_attribute *attr =
 		container_of(kattr, struct cp2112_pstring_attribute, attr);
 	struct cp2112_string_report report;
diff --git a/drivers/hid/hid-gt683r.c b/drivers/hid/hid-gt683r.c
index 0d6f135..a298fbd 100644
--- a/drivers/hid/hid-gt683r.c
+++ b/drivers/hid/hid-gt683r.c
@@ -70,7 +70,7 @@ static void gt683r_brightness_set(struct led_classdev *led_cdev,
 {
 	int i;
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct gt683r_led *led = hid_get_drvdata(hdev);
 
 	for (i = 0; i < GT683R_LED_COUNT; i++) {
@@ -89,8 +89,7 @@ static ssize_t mode_show(struct device *dev,
 				char *buf)
 {
 	u8 sysfs_mode;
-	struct hid_device *hdev = container_of(dev->parent,
-					struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev->parent);
 	struct gt683r_led *led = hid_get_drvdata(hdev);
 
 	if (led->mode == GT683R_LED_NORMAL)
@@ -108,8 +107,7 @@ static ssize_t mode_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	u8 sysfs_mode;
-	struct hid_device *hdev = container_of(dev->parent,
-					struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev->parent);
 	struct gt683r_led *led = hid_get_drvdata(hdev);
 
 
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 8979f1f..0125e35 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -220,7 +220,7 @@ static ssize_t attr_fn_lock_show_cptkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_cptkbd *cptkbd_data = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", cptkbd_data->fn_lock);
@@ -231,7 +231,7 @@ static ssize_t attr_fn_lock_store_cptkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_cptkbd *cptkbd_data = hid_get_drvdata(hdev);
 	int value;
 
@@ -250,7 +250,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_cptkbd *cptkbd_data = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n",
@@ -262,7 +262,7 @@ static ssize_t attr_sensitivity_store_cptkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_cptkbd *cptkbd_data = hid_get_drvdata(hdev);
 	int value;
 
@@ -387,7 +387,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
@@ -398,7 +398,7 @@ static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
@@ -417,7 +417,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
@@ -428,7 +428,7 @@ static ssize_t attr_dragging_store_tpkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
@@ -447,7 +447,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
@@ -458,7 +458,7 @@ static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
@@ -477,7 +477,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
@@ -488,7 +488,7 @@ static ssize_t attr_select_right_store_tpkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
@@ -507,7 +507,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n",
@@ -519,7 +519,7 @@ static ssize_t attr_sensitivity_store_tpkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
@@ -536,7 +536,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n",
@@ -548,7 +548,7 @@ static ssize_t attr_press_speed_store_tpkbd(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
@@ -609,7 +609,7 @@ static enum led_brightness lenovo_led_brightness_get_tpkbd(
 			struct led_classdev *led_cdev)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	int led_nr = 0;
 
@@ -625,7 +625,7 @@ static void lenovo_led_brightness_set_tpkbd(struct led_classdev *led_cdev,
 			enum led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata_tpkbd *data_pointer = hid_get_drvdata(hdev);
 	struct hid_report *report;
 	int led_nr = 0;
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 3e160ff..af3a8ec 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1018,7 +1018,7 @@ static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
 			enum led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hid = container_of(dev, struct hid_device, dev);
+	struct hid_device *hid = to_hid_device(dev);
 	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
 	struct lg4ff_device_entry *entry;
 	int i, state = 0;
@@ -1053,7 +1053,7 @@ static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
 static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hid = container_of(dev, struct hid_device, dev);
+	struct hid_device *hid = to_hid_device(dev);
 	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
 	struct lg4ff_device_entry *entry;
 	int i, value = 0;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4ee7716..296d499 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -272,7 +272,7 @@ static ssize_t mt_show_quirks(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct mt_device *td = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%u\n", td->mtclass.quirks);
@@ -282,7 +282,7 @@ static ssize_t mt_set_quirks(struct device *dev,
 			  struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct mt_device *td = hid_get_drvdata(hdev);
 
 	unsigned long val;
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 756d1ef..1b0084d 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -173,7 +173,7 @@ static ssize_t show_phys_width(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->sensor_physical_width);
@@ -185,7 +185,7 @@ static ssize_t show_phys_height(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->sensor_physical_height);
@@ -197,7 +197,7 @@ static ssize_t show_log_width(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->sensor_logical_width);
@@ -209,7 +209,7 @@ static ssize_t show_log_height(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->sensor_logical_height);
@@ -221,7 +221,7 @@ static ssize_t show_min_width(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->min_width *
@@ -233,7 +233,7 @@ static ssize_t set_min_width(struct device *dev,
 			     struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	unsigned long val;
@@ -256,7 +256,7 @@ static ssize_t show_min_height(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->min_height *
@@ -268,7 +268,7 @@ static ssize_t set_min_height(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	unsigned long val;
@@ -292,7 +292,7 @@ static ssize_t show_activate_slack(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->activate_slack);
@@ -302,7 +302,7 @@ static ssize_t set_activate_slack(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	unsigned long val;
@@ -325,7 +325,7 @@ static ssize_t show_activation_width(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->activation_width *
@@ -337,7 +337,7 @@ static ssize_t set_activation_width(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	unsigned long val;
@@ -361,7 +361,7 @@ static ssize_t show_activation_height(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", nd->activation_height *
@@ -373,7 +373,7 @@ static ssize_t set_activation_height(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	unsigned long val;
@@ -397,7 +397,7 @@ static ssize_t show_deactivate_slack(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	return sprintf(buf, "%d\n", -nd->deactivate_slack);
@@ -407,7 +407,7 @@ static ssize_t set_deactivate_slack(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct ntrig_data *nd = hid_get_drvdata(hdev);
 
 	unsigned long val;
diff --git a/drivers/hid/hid-picolcd_leds.c b/drivers/hid/hid-picolcd_leds.c
index e994f9c..a802b4f 100644
--- a/drivers/hid/hid-picolcd_leds.c
+++ b/drivers/hid/hid-picolcd_leds.c
@@ -66,7 +66,7 @@ static void picolcd_led_set_brightness(struct led_classdev *led_cdev,
 	int i, state = 0;
 
 	dev  = led_cdev->dev->parent;
-	hdev = container_of(dev, struct hid_device, dev);
+	hdev = to_hid_device(dev);
 	data = hid_get_drvdata(hdev);
 	if (!data)
 		return;
@@ -93,7 +93,7 @@ static enum led_brightness picolcd_led_get_brightness(struct led_classdev *led_c
 	int i, value = 0;
 
 	dev  = led_cdev->dev->parent;
-	hdev = container_of(dev, struct hid_device, dev);
+	hdev = to_hid_device(dev);
 	data = hid_get_drvdata(hdev);
 	for (i = 0; i < 8; i++)
 		if (led_cdev == data->led[i]) {
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 3a207c0..f095bf8 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -103,7 +103,7 @@ MODULE_PARM_DESC(enable, "Enable for the PC-MIDI virtual audio driver");
 static ssize_t show_channel(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	dbg_hid("pcmidi sysfs read channel=%u\n", pk->pm->midi_channel);
@@ -116,7 +116,7 @@ static ssize_t show_channel(struct device *dev,
 static ssize_t store_channel(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	unsigned channel = 0;
@@ -140,7 +140,7 @@ static struct device_attribute *sysfs_device_attr_channel = {
 static ssize_t show_sustain(struct device *dev,
  struct device_attribute *attr, char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	dbg_hid("pcmidi sysfs read sustain=%u\n", pk->pm->midi_sustain);
@@ -153,7 +153,7 @@ static ssize_t show_sustain(struct device *dev,
 static ssize_t store_sustain(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	unsigned sustain = 0;
@@ -179,7 +179,7 @@ static struct device_attribute *sysfs_device_attr_sustain = {
 static ssize_t show_octave(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	dbg_hid("pcmidi sysfs read octave=%d\n", pk->pm->midi_octave);
@@ -192,7 +192,7 @@ static ssize_t show_octave(struct device *dev,
 static ssize_t store_octave(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	int octave = 0;
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 876ea2b..9b8db0e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1551,7 +1551,7 @@ static void sony_led_set_brightness(struct led_classdev *led,
 				    enum led_brightness value)
 {
 	struct device *dev = led->dev->parent;
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *drv_data;
 
 	int n;
@@ -1593,7 +1593,7 @@ static void sony_led_set_brightness(struct led_classdev *led,
 static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 {
 	struct device *dev = led->dev->parent;
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *drv_data;
 
 	int n;
@@ -1616,7 +1616,7 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
 				unsigned long *delay_off)
 {
 	struct device *dev = led->dev->parent;
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct sony_sc *drv_data = hid_get_drvdata(hdev);
 	int n;
 	__u8 new_on, new_off;
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 3edd4ac..ec18768 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -141,7 +141,7 @@ static void steelseries_srws1_led_all_set_brightness(struct led_classdev *led_cd
 			enum led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hid = container_of(dev, struct hid_device, dev);
+	struct hid_device *hid = to_hid_device(dev);
 	struct steelseries_srws1_data *drv_data = hid_get_drvdata(hid);
 
 	if (!drv_data) {
@@ -160,7 +160,7 @@ static void steelseries_srws1_led_all_set_brightness(struct led_classdev *led_cd
 static enum led_brightness steelseries_srws1_led_all_get_brightness(struct led_classdev *led_cdev)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hid = container_of(dev, struct hid_device, dev);
+	struct hid_device *hid = to_hid_device(dev);
 	struct steelseries_srws1_data *drv_data;
 
 	drv_data = hid_get_drvdata(hid);
@@ -177,7 +177,7 @@ static void steelseries_srws1_led_set_brightness(struct led_classdev *led_cdev,
 			enum led_brightness value)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hid = container_of(dev, struct hid_device, dev);
+	struct hid_device *hid = to_hid_device(dev);
 	struct steelseries_srws1_data *drv_data = hid_get_drvdata(hid);
 	int i, state = 0;
 
@@ -205,7 +205,7 @@ static void steelseries_srws1_led_set_brightness(struct led_classdev *led_cdev,
 static enum led_brightness steelseries_srws1_led_get_brightness(struct led_classdev *led_cdev)
 {
 	struct device *dev = led_cdev->dev->parent;
-	struct hid_device *hid = container_of(dev, struct hid_device, dev);
+	struct hid_device *hid = to_hid_device(dev);
 	struct steelseries_srws1_data *drv_data;
 	int i, value = 0;
 
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 875694d..510ca77 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -256,8 +256,7 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_MAX
 };
 
-#define dev_to_wii(pdev) hid_get_drvdata(container_of(pdev, struct hid_device, \
-									dev))
+#define dev_to_wii(pdev) hid_get_drvdata(to_hid_device(pdev))
 
 void __wiimote_schedule(struct wiimote_data *wdata);
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index c7a3b79..d821b16 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -686,7 +686,7 @@ out:
 static ssize_t wacom_led_select_store(struct device *dev, int set_id,
 				      const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	unsigned int id;
 	int err;
@@ -714,7 +714,7 @@ static ssize_t wacom_led##SET_ID##_select_store(struct device *dev,	\
 static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
 	struct device_attribute *attr, char *buf)			\
 {									\
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);\
+	struct hid_device *hdev = to_hid_device(dev);\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
 	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
 			 wacom->led.select[SET_ID]);			\
@@ -750,7 +750,7 @@ static ssize_t wacom_luminance_store(struct wacom *wacom, u8 *dest,
 static ssize_t wacom_##name##_luminance_store(struct device *dev,	\
 	struct device_attribute *attr, const char *buf, size_t count)	\
 {									\
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);\
+	struct hid_device *hdev = to_hid_device(dev);\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
 									\
 	return wacom_luminance_store(wacom, &wacom->led.field,		\
@@ -773,7 +773,7 @@ DEVICE_LUMINANCE_ATTR(buttons, img_lum);
 static ssize_t wacom_button_image_store(struct device *dev, int button_id,
 					const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	int err;
 	unsigned len;
@@ -1097,7 +1097,7 @@ static ssize_t wacom_show_speed(struct device *dev,
 				struct device_attribute
 				*attr, char *buf)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%i\n", wacom->wacom_wac.bt_high_speed);
@@ -1107,7 +1107,7 @@ static ssize_t wacom_store_speed(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	u8 new_speed;
 
@@ -1131,7 +1131,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
 				      char *buf, int index)
 {
 	struct device *dev = container_of(kobj->parent, struct device, kobj);
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	u8 mode;
 
@@ -1242,7 +1242,7 @@ static ssize_t wacom_store_unpair_remote(struct kobject *kobj,
 {
 	unsigned char selector = 0;
 	struct device *dev = container_of(kobj->parent, struct device, kobj);
-	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	int err;
 
-- 
2.5.0

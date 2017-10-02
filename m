From: Fedora Kernel Team <kernel-team@fedoraproject.org>
Subject: [PATCH 4/4] HID: core: remove the absolute need of hid_have_special_driver[]
Date: Mon,  2 Oct 2017 22:18:50 +0200
Message-ID: <20171002201850.13175-5-kernel-team@fedoraproject.org>
References: <20171002201850.13175-1-kernel-team@fedoraproject.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171002201850.13175-1-kernel-team@fedoraproject.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Most HID devices behave properly when they are used with hid-generic.
Since kernel v4.12, we do not poll for input reports at plug in, so
hid-generic should behave properly with all HID devices.

There has been a long standing list of HID devices that have a special
driver. It used to be just a few, but with time, this list went too big,
and we can not ask users to know which HID special driver will pick up
their device.

We can teach hid-generic to be nice with others. If a device is not
explicitly marked with HID_QUIRK_HAVE_SPECIAL_DRIVER, we can allow
hid-generic to pick up the device as long as no other loaded HID driver
will match the device.

When the special driver appears, hid-generic can step back and let
the special driver handling the device. In case this special driver
is removed, this good old pal of hid-generic will rebind to the device.

This basically makes the list hid_have_special_driver[] useless. It
still allows to not see a hid-generic driver bound and removed during
boot, so we can keep it around.

This will also help other people to have a special HID driver without
the need of recompiling hid-core.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c    | 76 ++++++++++++++++++++++++++++++-----------------
 drivers/hid/hid-generic.c | 68 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/hid.h       | 10 +++++++
 3 files changed, 125 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 37127d2..e4608ff 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -830,31 +830,6 @@ static int hid_scan_report(struct hid_device *hid)
 		break;
 	}
 
-	/* fall back to generic driver in case specific driver doesn't exist */
-	switch (hid->group) {
-	case HID_GROUP_MULTITOUCH_WIN_8:
-		/* fall-through */
-	case HID_GROUP_MULTITOUCH:
-		if (!IS_ENABLED(CONFIG_HID_MULTITOUCH))
-			hid->group = HID_GROUP_GENERIC;
-		break;
-	case HID_GROUP_SENSOR_HUB:
-		if (!IS_ENABLED(CONFIG_HID_SENSOR_HUB))
-			hid->group = HID_GROUP_GENERIC;
-		break;
-	case HID_GROUP_RMI:
-		if (!IS_ENABLED(CONFIG_HID_RMI))
-			hid->group = HID_GROUP_GENERIC;
-		break;
-	case HID_GROUP_WACOM:
-		if (!IS_ENABLED(CONFIG_HID_WACOM))
-			hid->group = HID_GROUP_GENERIC;
-		break;
-	case HID_GROUP_LOGITECH_DJ_DEVICE:
-		if (!IS_ENABLED(CONFIG_HID_LOGITECH_DJ))
-			hid->group = HID_GROUP_GENERIC;
-		break;
-	}
 	vfree(parser);
 	return 0;
 }
@@ -1928,8 +1903,8 @@ static void hid_free_dynids(struct hid_driver *hdrv)
 	spin_unlock(&hdrv->dyn_lock);
 }
 
-static const struct hid_device_id *hid_match_device(struct hid_device *hdev,
-		struct hid_driver *hdrv)
+const struct hid_device_id *hid_match_device(struct hid_device *hdev,
+					     struct hid_driver *hdrv)
 {
 	struct hid_dynid *dynid;
 
@@ -1944,6 +1919,7 @@ static const struct hid_device_id *hid_match_device(struct hid_device *hdev,
 
 	return hid_match_id(hdev, hdrv->id_table);
 }
+EXPORT_SYMBOL_GPL(hid_match_device);
 
 static int hid_bus_match(struct device *dev, struct device_driver *drv)
 {
@@ -1973,6 +1949,23 @@ static int hid_device_probe(struct device *dev)
 			goto unlock;
 		}
 
+		if (hdrv->match) {
+			if (!hdrv->match(hdev, hid_ignore_special_drivers)) {
+				ret = -ENODEV;
+				goto unlock;
+			}
+		} else {
+			/*
+			 * hid-generic implements .match(), so if
+			 * hid_ignore_special_drivers is set, we can safely
+			 * return.
+			 */
+			if (hid_ignore_special_drivers) {
+				ret = -ENODEV;
+				goto unlock;
+			}
+		}
+
 		hdev->driver = hdrv;
 		if (hdrv->probe) {
 			ret = hdrv->probe(hdev, id);
@@ -2069,7 +2062,7 @@ static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-static struct bus_type hid_bus_type = {
+struct bus_type hid_bus_type = {
 	.name		= "hid",
 	.dev_groups	= hid_dev_groups,
 	.drv_groups	= hid_drv_groups,
@@ -2202,6 +2195,29 @@ void hid_destroy_device(struct hid_device *hdev)
 }
 EXPORT_SYMBOL_GPL(hid_destroy_device);
 
+
+static int __bus_add_driver(struct device_driver *drv, void *data)
+{
+	struct hid_driver *added_hdrv = data;
+	struct hid_driver *hdrv = to_hid_driver(drv);
+
+	if (hdrv->bus_add_driver)
+		hdrv->bus_add_driver(added_hdrv);
+
+	return 0;
+}
+
+static int __bus_removed_driver(struct device_driver *drv, void *data)
+{
+	struct hid_driver *removed_hdrv = data;
+	struct hid_driver *hdrv = to_hid_driver(drv);
+
+	if (hdrv->bus_removed_driver)
+		hdrv->bus_removed_driver(removed_hdrv);
+
+	return 0;
+}
+
 int __hid_register_driver(struct hid_driver *hdrv, struct module *owner,
 		const char *mod_name)
 {
@@ -2213,6 +2229,8 @@ int __hid_register_driver(struct hid_driver *hdrv, struct module *owner,
 	INIT_LIST_HEAD(&hdrv->dyn_list);
 	spin_lock_init(&hdrv->dyn_lock);
 
+	bus_for_each_drv(&hid_bus_type, NULL, hdrv, __bus_add_driver);
+
 	return driver_register(&hdrv->driver);
 }
 EXPORT_SYMBOL_GPL(__hid_register_driver);
@@ -2221,6 +2239,8 @@ void hid_unregister_driver(struct hid_driver *hdrv)
 {
 	driver_unregister(&hdrv->driver);
 	hid_free_dynids(hdrv);
+
+	bus_for_each_drv(&hid_bus_type, NULL, hdrv, __bus_removed_driver);
 }
 EXPORT_SYMBOL_GPL(hid_unregister_driver);
 
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index e288a4a..3c0a1bf 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -24,8 +24,71 @@
 
 #include <linux/hid.h>
 
+static struct hid_driver hid_generic;
+
+static int __unmap_hid_generic(struct device *dev, void *data)
+{
+	struct hid_driver *hdrv = data;
+	struct hid_device *hdev = to_hid_device(dev);
+
+	/* only unbind matching devices already bound to hid-generic */
+	if (hdev->driver != &hid_generic ||
+	    hid_match_device(hdev, hdrv) == NULL)
+		return 0;
+
+	if (dev->parent)	/* Needed for USB */
+		device_lock(dev->parent);
+	device_release_driver(dev);
+	if (dev->parent)
+		device_unlock(dev->parent);
+
+	return 0;
+}
+
+static void hid_generic_add_driver(struct hid_driver *hdrv)
+{
+	bus_for_each_dev(&hid_bus_type, NULL, hdrv, __unmap_hid_generic);
+}
+
+static void hid_generic_removed_driver(struct hid_driver *hdrv)
+{
+	int ret;
+
+	ret = driver_attach(&hid_generic.driver);
+}
+
+static int __check_hid_generic(struct device_driver *drv, void *data)
+{
+	struct hid_driver *hdrv = to_hid_driver(drv);
+	struct hid_device *hdev = data;
+
+	if (hdrv == &hid_generic)
+		return 0;
+
+	return hid_match_device(hdev, hdrv) != NULL;
+}
+
+static bool hid_generic_match(struct hid_device *hdev,
+			      bool ignore_special_driver)
+{
+	if (ignore_special_driver)
+		return true;
+
+	if (hdev->quirks & HID_QUIRK_HAVE_SPECIAL_DRIVER)
+		return false;
+
+	/*
+	 * If any other driver wants the device, leave the device to this other
+	 * driver.
+	 */
+	if (bus_for_each_drv(&hid_bus_type, NULL, hdev, __check_hid_generic))
+		return false;
+
+	return true;
+}
+
 static const struct hid_device_id hid_table[] = {
-	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_GENERIC, HID_ANY_ID, HID_ANY_ID) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hid_table);
@@ -33,6 +96,9 @@ MODULE_DEVICE_TABLE(hid, hid_table);
 static struct hid_driver hid_generic = {
 	.name = "hid-generic",
 	.id_table = hid_table,
+	.match = hid_generic_match,
+	.bus_add_driver = hid_generic_add_driver,
+	.bus_removed_driver = hid_generic_removed_driver,
 };
 module_hid_driver(hid_generic);
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 6ba8d21..8336774 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -671,6 +671,7 @@ struct hid_usage_id {
  * 	      to be called)
  * @dyn_list: list of dynamically added device ids
  * @dyn_lock: lock protecting @dyn_list
+ * @match: check if the given device is handled by this driver
  * @probe: new device inserted
  * @remove: device removed (NULL if not a hot-plug capable driver)
  * @report_table: on which reports to call raw_event (NULL means all)
@@ -683,6 +684,8 @@ struct hid_usage_id {
  * @input_mapped: invoked on input registering after mapping an usage
  * @input_configured: invoked just before the device is registered
  * @feature_mapping: invoked on feature registering
+ * @bus_add_driver: invoked when a HID driver is about to be added
+ * @bus_removed_driver: invoked when a HID driver has been removed
  * @suspend: invoked on suspend (NULL means nop)
  * @resume: invoked on resume if device was not reset (NULL means nop)
  * @reset_resume: invoked on resume if device was reset (NULL means nop)
@@ -711,6 +714,7 @@ struct hid_driver {
 	struct list_head dyn_list;
 	spinlock_t dyn_lock;
 
+	bool (*match)(struct hid_device *dev, bool ignore_special_driver);
 	int (*probe)(struct hid_device *dev, const struct hid_device_id *id);
 	void (*remove)(struct hid_device *dev);
 
@@ -736,6 +740,8 @@ struct hid_driver {
 	void (*feature_mapping)(struct hid_device *hdev,
 			struct hid_field *field,
 			struct hid_usage *usage);
+	void (*bus_add_driver)(struct hid_driver *driver);
+	void (*bus_removed_driver)(struct hid_driver *driver);
 #ifdef CONFIG_PM
 	int (*suspend)(struct hid_device *hdev, pm_message_t message);
 	int (*resume)(struct hid_device *hdev);
@@ -814,6 +820,8 @@ extern bool hid_ignore(struct hid_device *);
 extern int hid_add_device(struct hid_device *);
 extern void hid_destroy_device(struct hid_device *);
 
+extern struct bus_type hid_bus_type;
+
 extern int __must_check __hid_register_driver(struct hid_driver *,
 		struct module *, const char *mod_name);
 
@@ -864,6 +872,8 @@ bool hid_match_one_id(const struct hid_device *hdev,
 		      const struct hid_device_id *id);
 const struct hid_device_id *hid_match_id(const struct hid_device *hdev,
 					 const struct hid_device_id *id);
+const struct hid_device_id *hid_match_device(struct hid_device *hdev,
+					     struct hid_driver *hdrv);
 s32 hid_snto32(__u32 value, unsigned n);
 __u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
 		     unsigned offset, unsigned n);
-- 
2.9.5

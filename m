From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/11] HID: hid-core: convert to use DRIVER_ATTR_RO and drv_groups
Date: Fri,  9 Jun 2017 11:03:04 +0200
Message-ID: <20170609090314.13991-1-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In the quest to get rid of DRIVER_ATTR(), this patch converts the
hid-core code to use DRIVER_ATTR_RO() and also moves to use drv_groups
as creating individual sysfs files is not good (it races with userspace
notifications.)

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-core.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 37084b645785..9184033a0de6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2144,7 +2144,7 @@ struct hid_dynid {
  * Adds a new dynamic hid device ID to this driver,
  * and causes the driver to probe for all devices again.
  */
-static ssize_t store_new_id(struct device_driver *drv, const char *buf,
+static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 		size_t count)
 {
 	struct hid_driver *hdrv = to_hid_driver(drv);
@@ -2176,7 +2176,13 @@ static ssize_t store_new_id(struct device_driver *drv, const char *buf,
 
 	return ret ? : count;
 }
-static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
+static DRIVER_ATTR_WO(new_id);
+
+static struct attribute *hid_drv_attrs[] = {
+	&driver_attr_new_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(hid_drv);
 
 static void hid_free_dynids(struct hid_driver *hdrv)
 {
@@ -2340,6 +2346,7 @@ static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
 static struct bus_type hid_bus_type = {
 	.name		= "hid",
 	.dev_groups	= hid_dev_groups,
+	.drv_groups	= hid_drv_groups,
 	.match		= hid_bus_match,
 	.probe		= hid_device_probe,
 	.remove		= hid_device_remove,
@@ -2779,8 +2786,6 @@ EXPORT_SYMBOL_GPL(hid_destroy_device);
 int __hid_register_driver(struct hid_driver *hdrv, struct module *owner,
 		const char *mod_name)
 {
-	int ret;
-
 	hdrv->driver.name = hdrv->name;
 	hdrv->driver.bus = &hid_bus_type;
 	hdrv->driver.owner = owner;
@@ -2789,21 +2794,12 @@ int __hid_register_driver(struct hid_driver *hdrv, struct module *owner,
 	INIT_LIST_HEAD(&hdrv->dyn_list);
 	spin_lock_init(&hdrv->dyn_lock);
 
-	ret = driver_register(&hdrv->driver);
-	if (ret)
-		return ret;
-
-	ret = driver_create_file(&hdrv->driver, &driver_attr_new_id);
-	if (ret)
-		driver_unregister(&hdrv->driver);
-
-	return ret;
+	return driver_register(&hdrv->driver);
 }
 EXPORT_SYMBOL_GPL(__hid_register_driver);
 
 void hid_unregister_driver(struct hid_driver *hdrv)
 {
-	driver_remove_file(&hdrv->driver, &driver_attr_new_id);
 	driver_unregister(&hdrv->driver);
 	hid_free_dynids(hdrv);
 }
-- 
2.13.1

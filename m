From: <gregkh@linuxfoundation.org>
Subject: patch "HID: hid-core: convert to use DRIVER_ATTR_RO and drv_groups" added to driver-core-testing
Date: Mon, 12 Jun 2017 16:15:18 +0200
Message-ID: <149727691898209@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbdFLOPa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Jun 2017 10:15:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org, benjamin.tissoires@redhat.com, jikos@kernel.org, linux-input@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    HID: hid-core: convert to use DRIVER_ATTR_RO and drv_groups

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


>From c281032530e723c81c8a230fff215c5ea1792c13 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 9 Jun 2017 11:03:04 +0200
Subject: HID: hid-core: convert to use DRIVER_ATTR_RO and drv_groups

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



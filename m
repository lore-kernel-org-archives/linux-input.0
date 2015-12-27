From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 5/5] HID: use kobj_to_dev()
Date: Sun, 27 Dec 2015 17:25:24 +0800
Message-ID: <3f5bc0be31c5bf18eafeacad87fad71a2e76c291.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
In-Reply-To: <aa8060c2f9e42359a9b1fc402f8d48ce9045e840.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com> <3c9a720e58ea32c5df098cbe744c6b5821a756a6.1451206516.git.geliangtang@163.com> <1f3f9887783a36170a5972e6819c7841db95d888.1451206516.git.geliangtang@163.com> <aa8060c2f9e42359a9b1fc402f8d48ce9045e840.1451206516.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use kobj_to_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/hid/hid-core.c            |  2 +-
 drivers/hid/hid-roccat-arvo.c     |  6 ++----
 drivers/hid/hid-roccat-common.c   |  6 ++----
 drivers/hid/hid-roccat-isku.c     |  6 ++----
 drivers/hid/hid-roccat-kone.c     | 12 ++++--------
 drivers/hid/hid-roccat-koneplus.c | 12 ++++--------
 drivers/hid/hid-roccat-kovaplus.c | 12 ++++--------
 drivers/hid/hid-roccat-lua.c      |  4 ++--
 drivers/hid/hid-roccat-pyra.c     | 15 +++++----------
 drivers/hid/wacom_sys.c           |  4 ++--
 10 files changed, 28 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ecf614b..afbf39d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1571,7 +1571,7 @@ read_report_descriptor(struct file *filp, struct kobject *kobj,
 		struct bin_attribute *attr,
 		char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct hid_device *hdev = to_hid_device(dev);
 
 	if (off >= hdev->rsize)
diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 1948208..329c5d1 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -191,8 +191,7 @@ static ssize_t arvo_sysfs_write(struct file *fp,
 		struct kobject *kobj, void const *buf,
 		loff_t off, size_t count, size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct arvo_device *arvo = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -211,8 +210,7 @@ static ssize_t arvo_sysfs_read(struct file *fp,
 		struct kobject *kobj, void *buf, loff_t off,
 		size_t count, size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct arvo_device *arvo = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
diff --git a/drivers/hid/hid-roccat-common.c b/drivers/hid/hid-roccat-common.c
index 02e28e9..8155ac5 100644
--- a/drivers/hid/hid-roccat-common.c
+++ b/drivers/hid/hid-roccat-common.c
@@ -134,8 +134,7 @@ ssize_t roccat_common2_sysfs_read(struct file *fp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct roccat_common2_device *roccat_dev = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -158,8 +157,7 @@ ssize_t roccat_common2_sysfs_write(struct file *fp, struct kobject *kobj,
 		void const *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct roccat_common2_device *roccat_dev = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index bc62ed9..02db537 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -121,8 +121,7 @@ static ssize_t isku_sysfs_read(struct file *fp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct isku_device *isku = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -144,8 +143,7 @@ static ssize_t isku_sysfs_write(struct file *fp, struct kobject *kobj,
 		void const *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct isku_device *isku = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index c292650..bf4675a 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -269,8 +269,7 @@ static int kone_get_firmware_version(struct usb_device *usb_dev, int *result)
 static ssize_t kone_sysfs_read_settings(struct file *fp, struct kobject *kobj,
 		struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count) {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct kone_device *kone = hid_get_drvdata(dev_get_drvdata(dev));
 
 	if (off >= sizeof(struct kone_settings))
@@ -294,8 +293,7 @@ static ssize_t kone_sysfs_read_settings(struct file *fp, struct kobject *kobj,
 static ssize_t kone_sysfs_write_settings(struct file *fp, struct kobject *kobj,
 		struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count) {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct kone_device *kone = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval = 0, difference, old_profile;
@@ -332,8 +330,7 @@ static BIN_ATTR(settings, 0660, kone_sysfs_read_settings,
 static ssize_t kone_sysfs_read_profilex(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr,
 		char *buf, loff_t off, size_t count) {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct kone_device *kone = hid_get_drvdata(dev_get_drvdata(dev));
 
 	if (off >= sizeof(struct kone_profile))
@@ -353,8 +350,7 @@ static ssize_t kone_sysfs_read_profilex(struct file *fp,
 static ssize_t kone_sysfs_write_profilex(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr,
 		char *buf, loff_t off, size_t count) {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct kone_device *kone = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	struct kone_profile *profile;
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 5e99fcd..09e8fc7 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -87,8 +87,7 @@ static ssize_t koneplus_sysfs_read(struct file *fp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct koneplus_device *koneplus = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -113,8 +112,7 @@ static ssize_t koneplus_sysfs_write(struct file *fp, struct kobject *kobj,
 		void const *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct koneplus_device *koneplus = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -193,8 +191,7 @@ static ssize_t koneplus_sysfs_read_profilex_settings(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	ssize_t retval;
 
@@ -212,8 +209,7 @@ static ssize_t koneplus_sysfs_read_profilex_buttons(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	ssize_t retval;
 
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 9660477..43617fb 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -128,8 +128,7 @@ static ssize_t kovaplus_sysfs_read(struct file *fp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct kovaplus_device *kovaplus = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -154,8 +153,7 @@ static ssize_t kovaplus_sysfs_write(struct file *fp, struct kobject *kobj,
 		void const *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct kovaplus_device *kovaplus = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -221,8 +219,7 @@ static ssize_t kovaplus_sysfs_read_profilex_settings(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	ssize_t retval;
 
@@ -240,8 +237,7 @@ static ssize_t kovaplus_sysfs_read_profilex_buttons(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	ssize_t retval;
 
diff --git a/drivers/hid/hid-roccat-lua.c b/drivers/hid/hid-roccat-lua.c
index 65e2e76..ac1a731 100644
--- a/drivers/hid/hid-roccat-lua.c
+++ b/drivers/hid/hid-roccat-lua.c
@@ -30,7 +30,7 @@ static ssize_t lua_sysfs_read(struct file *fp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct lua_device *lua = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -52,7 +52,7 @@ static ssize_t lua_sysfs_write(struct file *fp, struct kobject *kobj,
 		void const *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct lua_device *lua = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 47d7e74..b30aa7b 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -90,8 +90,7 @@ static ssize_t pyra_sysfs_read(struct file *fp, struct kobject *kobj,
 		char *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct pyra_device *pyra = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -116,8 +115,7 @@ static ssize_t pyra_sysfs_write(struct file *fp, struct kobject *kobj,
 		void const *buf, loff_t off, size_t count,
 		size_t real_size, uint command)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct pyra_device *pyra = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval;
@@ -191,8 +189,7 @@ static ssize_t pyra_sysfs_read_profilex_settings(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	ssize_t retval;
 
@@ -210,8 +207,7 @@ static ssize_t pyra_sysfs_read_profilex_buttons(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	ssize_t retval;
 
@@ -248,8 +244,7 @@ static ssize_t pyra_sysfs_write_settings(struct file *fp,
 		struct kobject *kobj, struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
-	struct device *dev =
-			container_of(kobj, struct device, kobj)->parent->parent;
+	struct device *dev = kobj_to_dev(kobj)->parent->parent;
 	struct pyra_device *pyra = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval = 0;
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index d821b16..5cb21dd 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1130,7 +1130,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
 				      struct kobj_attribute *kattr,
 				      char *buf, int index)
 {
-	struct device *dev = container_of(kobj->parent, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj->parent);
 	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	u8 mode;
@@ -1241,7 +1241,7 @@ static ssize_t wacom_store_unpair_remote(struct kobject *kobj,
 					 const char *buf, size_t count)
 {
 	unsigned char selector = 0;
-	struct device *dev = container_of(kobj->parent, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj->parent);
 	struct hid_device *hdev = to_hid_device(dev);
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	int err;
-- 
2.5.0

From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] hid: replace strict_strtoul() with kstrtoul()
Date: Sat, 01 Jun 2013 16:09:14 +0900
Message-ID: <000301ce5e96$ec617b80$c5247280$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55224 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab3FAHJP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Jun 2013 03:09:15 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNP0041MD7E4JB0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Sat, 01 Jun 2013 16:09:14 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Jiri Kosina' <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

The usage of strict_strtoul() is not preferred, because
strict_strtoul() is obsolete. Thus, kstrtoul() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hid/hid-magicmouse.c      |    2 +-
 drivers/hid/hid-ntrig.c           |   12 ++++++------
 drivers/hid/hid-roccat-arvo.c     |    6 +++---
 drivers/hid/hid-roccat-isku.c     |    2 +-
 drivers/hid/hid-roccat-kone.c     |    4 ++--
 drivers/hid/hid-roccat-koneplus.c |    2 +-
 drivers/hid/hid-roccat-kovaplus.c |    2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 5bc3734..a32f5a2 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -36,7 +36,7 @@ MODULE_PARM_DESC(emulate_scroll_wheel, "Emulate a scroll wheel");
 static unsigned int scroll_speed = 32;
 static int param_set_scroll_speed(const char *val, struct kernel_param *kp) {
 	unsigned long speed;
-	if (!val || strict_strtoul(val, 0, &speed) || speed > 63)
+	if (!val || kstrtoul(val, 0, &speed) || speed > 63)
 		return -EINVAL;
 	scroll_speed = speed;
 	return 0;
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index ef95102..98d1fdf 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -237,7 +237,7 @@ static ssize_t set_min_width(struct device *dev,
 
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val))
+	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	if (val > nd->sensor_physical_width)
@@ -272,7 +272,7 @@ static ssize_t set_min_height(struct device *dev,
 
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val))
+	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	if (val > nd->sensor_physical_height)
@@ -306,7 +306,7 @@ static ssize_t set_activate_slack(struct device *dev,
 
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val))
+	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	if (val > 0x7f)
@@ -341,7 +341,7 @@ static ssize_t set_activation_width(struct device *dev,
 
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val))
+	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	if (val > nd->sensor_physical_width)
@@ -377,7 +377,7 @@ static ssize_t set_activation_height(struct device *dev,
 
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val))
+	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	if (val > nd->sensor_physical_height)
@@ -411,7 +411,7 @@ static ssize_t set_deactivate_slack(struct device *dev,
 
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val))
+	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 327f9b8..071ee9e 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -59,7 +59,7 @@ static ssize_t arvo_sysfs_set_mode_key(struct device *dev,
 	unsigned long state;
 	int retval;
 
-	retval = strict_strtoul(buf, 10, &state);
+	retval = kstrtoul(buf, 10, &state);
 	if (retval)
 		return retval;
 
@@ -107,7 +107,7 @@ static ssize_t arvo_sysfs_set_key_mask(struct device *dev,
 	unsigned long key_mask;
 	int retval;
 
-	retval = strict_strtoul(buf, 10, &key_mask);
+	retval = kstrtoul(buf, 10, &key_mask);
 	if (retval)
 		return retval;
 
@@ -159,7 +159,7 @@ static ssize_t arvo_sysfs_set_actual_profile(struct device *dev,
 	unsigned long profile;
 	int retval;
 
-	retval = strict_strtoul(buf, 10, &profile);
+	retval = kstrtoul(buf, 10, &profile);
 	if (retval)
 		return retval;
 
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 8023751..5dd0ea4 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -82,7 +82,7 @@ static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
 	isku = hid_get_drvdata(dev_get_drvdata(dev));
 	usb_dev = interface_to_usbdev(to_usb_interface(dev));
 
-	retval = strict_strtoul(buf, 10, &profile);
+	retval = kstrtoul(buf, 10, &profile);
 	if (retval)
 		return retval;
 
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 7fae070..00ab287 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -456,7 +456,7 @@ static ssize_t kone_sysfs_set_tcu(struct device *dev,
 	kone = hid_get_drvdata(dev_get_drvdata(dev));
 	usb_dev = interface_to_usbdev(to_usb_interface(dev));
 
-	retval = strict_strtoul(buf, 10, &state);
+	retval = kstrtoul(buf, 10, &state);
 	if (retval)
 		return retval;
 
@@ -545,7 +545,7 @@ static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
 	kone = hid_get_drvdata(dev_get_drvdata(dev));
 	usb_dev = interface_to_usbdev(to_usb_interface(dev));
 
-	retval = strict_strtoul(buf, 10, &new_startup_profile);
+	retval = kstrtoul(buf, 10, &new_startup_profile);
 	if (retval)
 		return retval;
 
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 6a48fa3..26b9663 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -246,7 +246,7 @@ static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
 	koneplus = hid_get_drvdata(dev_get_drvdata(dev));
 	usb_dev = interface_to_usbdev(to_usb_interface(dev));
 
-	retval = strict_strtoul(buf, 10, &profile);
+	retval = kstrtoul(buf, 10, &profile);
 	if (retval)
 		return retval;
 
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index b8b3778..c2a17e4 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -282,7 +282,7 @@ static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
 	kovaplus = hid_get_drvdata(dev_get_drvdata(dev));
 	usb_dev = interface_to_usbdev(to_usb_interface(dev));
 
-	retval = strict_strtoul(buf, 10, &profile);
+	retval = kstrtoul(buf, 10, &profile);
 	if (retval)
 		return retval;
 
-- 
1.7.10.4



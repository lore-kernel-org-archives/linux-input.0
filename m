From: Stefan Achatz <stefan_achatz@web.de>
Subject: [PATCH 2/2] HID: roccat: using new sysfs_create_bin_group() in
 kone driver
Date: Fri, 12 Nov 2010 19:18:41 +0100
Message-ID: <1289585921.2629.13.camel__24967.9076405757$1289586103$gmane$org@neuromancer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:56689 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252Ab0KLSVE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 13:21:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, "Eric W. Biederman" <ebiederm@aristanetworks.com>, "Serge E. Hallyn" <serue@us.ibm.com>, Tejun Heo <tj@kernel.org>, Jiri Kosina <jkosina@suse.cz>

hid-roccat-kone now uses new group functions for creating binary
sysfs attributes.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kone.c |   53 ++++++++++++----------------------------
 1 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index f776957..43f1693 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -710,6 +710,20 @@ static struct bin_attribute kone_profile5_attr = {
 	.write = kone_sysfs_write_profile5
 };
 
+static struct attribute *kone_bin_attributes[] = {
+	&kone_settings_attr.attr,
+	&kone_profile1_attr.attr,
+	&kone_profile2_attr.attr,
+	&kone_profile3_attr.attr,
+	&kone_profile4_attr.attr,
+	&kone_profile5_attr.attr,
+	NULL
+};
+
+static struct attribute_group kone_bin_attribute_group = {
+	.attrs = kone_bin_attributes
+};
+
 static int kone_create_sysfs_attributes(struct usb_interface *intf)
 {
 	int retval;
@@ -718,42 +732,12 @@ static int kone_create_sysfs_attributes(struct usb_interface *intf)
 	if (retval)
 		goto exit_1;
 
-	retval = sysfs_create_bin_file(&intf->dev.kobj, &kone_settings_attr);
+	retval = sysfs_create_bin_group(&intf->dev.kobj, &kone_bin_attribute_group);
 	if (retval)
 		goto exit_2;
 
-	retval = sysfs_create_bin_file(&intf->dev.kobj, &kone_profile1_attr);
-	if (retval)
-		goto exit_3;
-
-	retval = sysfs_create_bin_file(&intf->dev.kobj, &kone_profile2_attr);
-	if (retval)
-		goto exit_4;
-
-	retval = sysfs_create_bin_file(&intf->dev.kobj, &kone_profile3_attr);
-	if (retval)
-		goto exit_5;
-
-	retval = sysfs_create_bin_file(&intf->dev.kobj, &kone_profile4_attr);
-	if (retval)
-		goto exit_6;
-
-	retval = sysfs_create_bin_file(&intf->dev.kobj, &kone_profile5_attr);
-	if (retval)
-		goto exit_7;
-
 	return 0;
 
-exit_7:
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile4_attr);
-exit_6:
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile3_attr);
-exit_5:
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile2_attr);
-exit_4:
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile1_attr);
-exit_3:
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_settings_attr);
 exit_2:
 	sysfs_remove_group(&intf->dev.kobj, &kone_attribute_group);
 exit_1:
@@ -762,12 +746,7 @@ exit_1:
 
 static void kone_remove_sysfs_attributes(struct usb_interface *intf)
 {
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile5_attr);
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile4_attr);
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile3_attr);
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile2_attr);
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile1_attr);
-	sysfs_remove_bin_file(&intf->dev.kobj, &kone_settings_attr);
+	sysfs_remove_group(&intf->dev.kobj, &kone_bin_attribute_group);
 	sysfs_remove_group(&intf->dev.kobj, &kone_attribute_group);
 }
 
-- 
1.7.2.3




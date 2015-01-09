From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: roccat: potential out of bounds in
 pyra_sysfs_write_settings()
Date: Fri, 9 Jan 2015 15:32:31 +0300
Message-ID: <20150109123231.GA25224@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:28604 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853AbbAIMdA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 07:33:00 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

This is a static checker fix.  We write some binary settings to the
sysfs file.  One of the settings is the "->startup_profile".  There
isn't any checking to make sure it fits into the
pyra->profile_settings[] array in the profile_activated() function.

I added a check to pyra_sysfs_write_settings() in both places because
I wasn't positive that the other callers were correct.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 1a07e07..47d7e74 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -35,6 +35,8 @@ static struct class *pyra_class;
 static void profile_activated(struct pyra_device *pyra,
 		unsigned int new_profile)
 {
+	if (new_profile >= ARRAY_SIZE(pyra->profile_settings))
+		return;
 	pyra->actual_profile = new_profile;
 	pyra->actual_cpi = pyra->profile_settings[pyra->actual_profile].y_cpi;
 }
@@ -257,9 +259,11 @@ static ssize_t pyra_sysfs_write_settings(struct file *fp,
 	if (off != 0 || count != PYRA_SIZE_SETTINGS)
 		return -EINVAL;
 
-	mutex_lock(&pyra->pyra_lock);
-
 	settings = (struct pyra_settings const *)buf;
+	if (settings->startup_profile >= ARRAY_SIZE(pyra->profile_settings))
+		return -EINVAL;
+
+	mutex_lock(&pyra->pyra_lock);
 
 	retval = pyra_set_settings(usb_dev, settings);
 	if (retval) {

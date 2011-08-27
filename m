From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 3/5] HID: roccat: Kovaplus now reports external profile
 changes via roccat device
Date: Sat, 27 Aug 2011 15:24:45 +0200
Message-ID: <1314451485.24216.74.camel@neuromancer.tessier-ashpool>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Profile changes were only reported when issued mouse internal. Now all
changes are reported.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kovaplus.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 1f8336e..112d934 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -323,6 +323,7 @@ static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
 	struct usb_device *usb_dev;
 	unsigned long profile;
 	int retval;
+	struct kovaplus_roccat_report roccat_report;
 
 	dev = dev->parent->parent;
 	kovaplus = hid_get_drvdata(dev_get_drvdata(dev));
@@ -337,10 +338,22 @@ static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
 
 	mutex_lock(&kovaplus->kovaplus_lock);
 	retval = kovaplus_set_actual_profile(usb_dev, profile);
+	if (retval) {
+		mutex_unlock(&kovaplus->kovaplus_lock);
+		return retval;
+	}
+
 	kovaplus_profile_activated(kovaplus, profile);
+
+	roccat_report.type = KOVAPLUS_MOUSE_REPORT_BUTTON_TYPE_PROFILE_1;
+	roccat_report.profile = profile + 1;
+	roccat_report.button = 0;
+	roccat_report.data1 = profile + 1;
+	roccat_report.data2 = 0;
+	roccat_report_event(kovaplus->chrdev_minor,
+			(uint8_t const *)&roccat_report);
+
 	mutex_unlock(&kovaplus->kovaplus_lock);
-	if (retval)
-		return retval;
 
 	return size;
 }
-- 
1.7.3.4

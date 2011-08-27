From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 2/5] HID: roccat: Pyra now reports external profile changes
 via roccat device
Date: Sat, 27 Aug 2011 15:24:41 +0200
Message-ID: <1314451481.24216.73.camel@neuromancer.tessier-ashpool>
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
 drivers/hid/hid-roccat-pyra.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 8140776b..df05c1b 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -298,6 +298,7 @@ static ssize_t pyra_sysfs_write_settings(struct file *fp,
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
 	int retval = 0;
 	int difference;
+	struct pyra_roccat_report roccat_report;
 
 	if (off != 0 || count != sizeof(struct pyra_settings))
 		return -EINVAL;
@@ -307,17 +308,23 @@ static ssize_t pyra_sysfs_write_settings(struct file *fp,
 	if (difference) {
 		retval = pyra_set_settings(usb_dev,
 				(struct pyra_settings const *)buf);
-		if (!retval)
-			memcpy(&pyra->settings, buf,
-					sizeof(struct pyra_settings));
-	}
-	mutex_unlock(&pyra->pyra_lock);
+		if (retval) {
+			mutex_unlock(&pyra->pyra_lock);
+			return retval;
+		}
 
-	if (retval)
-		return retval;
+		memcpy(&pyra->settings, buf,
+				sizeof(struct pyra_settings));
 
-	profile_activated(pyra, pyra->settings.startup_profile);
+		profile_activated(pyra, pyra->settings.startup_profile);
 
+		roccat_report.type = PYRA_MOUSE_EVENT_BUTTON_TYPE_PROFILE_2;
+		roccat_report.value = pyra->settings.startup_profile + 1;
+		roccat_report.key = 0;
+		roccat_report_event(pyra->chrdev_minor,
+				(uint8_t const *)&roccat_report);
+	}
+	mutex_unlock(&pyra->pyra_lock);
 	return sizeof(struct pyra_settings);
 }
 
-- 
1.7.3.4

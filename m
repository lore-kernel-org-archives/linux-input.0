From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 5/5] HID: roccat: Kone now reports external profile changes
 via roccat device
Date: Sat, 27 Aug 2011 15:24:51 +0200
Message-ID: <1314451491.24216.76.camel@neuromancer.tessier-ashpool>
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
 drivers/hid/hid-roccat-kone.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index c931d00..e2072af 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -43,6 +43,15 @@ static void kone_profile_activated(struct kone_device *kone, uint new_profile)
 	kone->actual_dpi = kone->profiles[new_profile - 1].startup_dpi;
 }
 
+static void kone_profile_report(struct kone_device *kone, uint new_profile)
+{
+	struct kone_roccat_report roccat_report;
+	roccat_report.event = kone_mouse_event_switch_profile;
+	roccat_report.value = new_profile;
+	roccat_report.key = 0;
+	roccat_report_event(kone->chrdev_minor, (uint8_t *)&roccat_report);
+}
+
 static int kone_receive(struct usb_device *usb_dev, uint usb_command,
 		void *data, uint size)
 {
@@ -289,7 +298,7 @@ static ssize_t kone_sysfs_write_settings(struct file *fp, struct kobject *kobj,
 			container_of(kobj, struct device, kobj)->parent->parent;
 	struct kone_device *kone = hid_get_drvdata(dev_get_drvdata(dev));
 	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
-	int retval = 0, difference;
+	int retval = 0, difference, old_profile;
 
 	/* I need to get my data in one piece */
 	if (off != 0 || count != sizeof(struct kone_settings))
@@ -305,9 +314,13 @@ static ssize_t kone_sysfs_write_settings(struct file *fp, struct kobject *kobj,
 			return retval;
 		}
 
+		old_profile = kone->settings.startup_profile;
 		memcpy(&kone->settings, buf, sizeof(struct kone_settings));
 
 		kone_profile_activated(kone, kone->settings.startup_profile);
+
+		if (kone->settings.startup_profile != old_profile)
+			kone_profile_report(kone, kone->settings.startup_profile);
 	}
 	mutex_unlock(&kone->kone_lock);
 
@@ -554,6 +567,7 @@ static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
 
 	/* changing the startup profile immediately activates this profile */
 	kone_profile_activated(kone, new_startup_profile);
+	kone_profile_report(kone, new_startup_profile);
 
 	mutex_unlock(&kone->kone_lock);
 	return size;
-- 
1.7.3.4

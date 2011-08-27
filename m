From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 4/5] HID: roccat: cleaned up code for Kone and fixed wrong
 initialization value
Date: Sat, 27 Aug 2011 15:24:48 +0200
Message-ID: <1314451489.24216.75.camel@neuromancer.tessier-ashpool>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Introduced function kone_profile_activated() to reduce code duplication.
This by the way fixes a wrong initialization value.
Also fixes early mutex unlocks.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kone.c |   43 +++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 7847a5b..c931d00 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -37,6 +37,12 @@
 
 static uint profile_numbers[5] = {0, 1, 2, 3, 4};
 
+static void kone_profile_activated(struct kone_device *kone, uint new_profile)
+{
+	kone->actual_profile = new_profile;
+	kone->actual_dpi = kone->profiles[new_profile - 1].startup_dpi;
+}
+
 static int kone_receive(struct usb_device *usb_dev, uint usb_command,
 		void *data, uint size)
 {
@@ -294,21 +300,16 @@ static ssize_t kone_sysfs_write_settings(struct file *fp, struct kobject *kobj,
 	if (difference) {
 		retval = kone_set_settings(usb_dev,
 				(struct kone_settings const *)buf);
-		if (!retval)
-			memcpy(&kone->settings, buf,
-					sizeof(struct kone_settings));
-	}
-	mutex_unlock(&kone->kone_lock);
+		if (retval) {
+			mutex_unlock(&kone->kone_lock);
+			return retval;
+		}
 
-	if (retval)
-		return retval;
+		memcpy(&kone->settings, buf, sizeof(struct kone_settings));
 
-	/*
-	 * If we get here, treat settings as okay and update actual values
-	 * according to startup_profile
-	 */
-	kone->actual_profile = kone->settings.startup_profile;
-	kone->actual_dpi = kone->profiles[kone->actual_profile - 1].startup_dpi;
+		kone_profile_activated(kone, kone->settings.startup_profile);
+	}
+	mutex_unlock(&kone->kone_lock);
 
 	return sizeof(struct kone_settings);
 }
@@ -501,6 +502,8 @@ static ssize_t kone_sysfs_set_tcu(struct device *dev,
 				goto exit_no_settings;
 			goto exit_unlock;
 		}
+		/* calibration resets profile */
+		kone_profile_activated(kone, kone->settings.startup_profile);
 	}
 
 	retval = size;
@@ -544,16 +547,15 @@ static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
 	kone_set_settings_checksum(&kone->settings);
 
 	retval = kone_set_settings(usb_dev, &kone->settings);
-
-	mutex_unlock(&kone->kone_lock);
-
-	if (retval)
+	if (retval) {
+		mutex_unlock(&kone->kone_lock);
 		return retval;
+	}
 
 	/* changing the startup profile immediately activates this profile */
-	kone->actual_profile = new_startup_profile;
-	kone->actual_dpi = kone->profiles[kone->actual_profile - 1].startup_dpi;
+	kone_profile_activated(kone, new_startup_profile);
 
+	mutex_unlock(&kone->kone_lock);
 	return size;
 }
 
@@ -665,8 +667,7 @@ static int kone_init_kone_device_struct(struct usb_device *usb_dev,
 	if (retval)
 		return retval;
 
-	kone->actual_profile = kone->settings.startup_profile;
-	kone->actual_dpi = kone->profiles[kone->actual_profile].startup_dpi;
+	kone_profile_activated(kone, kone->settings.startup_profile);
 
 	return 0;
 }
-- 
1.7.3.4

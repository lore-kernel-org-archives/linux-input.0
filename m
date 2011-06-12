From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH] HID: roccat: Fixed NULL pointer dereference, wrong actual
 values; added range checks
Date: Sun, 12 Jun 2011 10:02:44 +0200
Message-ID: <1307865764.5614.41.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On rare occassions raw events can be triggered before drvdata gets set up
which leads to NULL pointer dereferences. This was only observed with pyra on
2.6.39, but is fixed for all devices now to play it save.
kovaplus returned wrong actual values when profile change was initiated from host.
Added range checks for setting actual profile on all devices.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-arvo.c     |    5 ++++-
 drivers/hid/hid-roccat-kone.c     |    3 +++
 drivers/hid/hid-roccat-koneplus.c |    8 +++++++-
 drivers/hid/hid-roccat-kovaplus.c |    5 ++++-
 drivers/hid/hid-roccat-pyra.c     |    3 +++
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 6105366..093bfad 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -163,6 +163,9 @@ static ssize_t arvo_sysfs_set_actual_profile(struct device *dev,
 	if (retval)
 		return retval;
 
+	if (profile < 1 || profile > 5)
+		return -EINVAL;
+
 	temp_buf.command = ARVO_COMMAND_ACTUAL_PROFILE;
 	temp_buf.actual_profile = profile;
 
@@ -399,7 +402,7 @@ static int arvo_raw_event(struct hid_device *hdev,
 	if (size != 3)
 		return 0;
 
-	if (arvo->roccat_claimed)
+	if (arvo && arvo->roccat_claimed)
 		arvo_report_to_chrdev(arvo, data);
 
 	return 0;
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 7e29778..2b8f3a3 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -832,6 +832,9 @@ static int kone_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (size != sizeof(struct kone_mouse_event))
 		return 0;
 
+	if (kone == NULL)
+		return 0;
+
 	/*
 	 * Firmware 1.38 introduced new behaviour for tilt and special buttons.
 	 * Pressed button is reported in each movement event.
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 33ecad5..59e4777 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -431,6 +431,9 @@ static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
 	if (retval)
 		return retval;
 
+	if (profile > 4)
+		return -EINVAL;
+
 	mutex_lock(&koneplus->koneplus_lock);
 
 	retval = koneplus_set_actual_profile(usb_dev, profile);
@@ -439,7 +442,7 @@ static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
 		return retval;
 	}
 
-	koneplus->actual_profile = profile;
+	koneplus_profile_activated(koneplus, profile);
 
 	roccat_report.type = KONEPLUS_MOUSE_REPORT_BUTTON_TYPE_PROFILE;
 	roccat_report.data1 = profile + 1;
@@ -751,6 +754,9 @@ static int koneplus_raw_event(struct hid_device *hdev,
 			!= USB_INTERFACE_PROTOCOL_MOUSE)
 		return 0;
 
+	if (koneplus == NULL)
+		return 0;
+
 	koneplus_keep_values_up_to_date(koneplus, data);
 
 	if (koneplus->roccat_claimed)
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 212e792..1f8336e 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -337,7 +337,7 @@ static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
 
 	mutex_lock(&kovaplus->kovaplus_lock);
 	retval = kovaplus_set_actual_profile(usb_dev, profile);
-	kovaplus->actual_profile = profile;
+	kovaplus_profile_activated(kovaplus, profile);
 	mutex_unlock(&kovaplus->kovaplus_lock);
 	if (retval)
 		return retval;
@@ -662,6 +662,9 @@ static int kovaplus_raw_event(struct hid_device *hdev,
 			!= USB_INTERFACE_PROTOCOL_MOUSE)
 		return 0;
 
+	if (kovaplus == NULL)
+		return 0;
+
 	kovaplus_keep_values_up_to_date(kovaplus, data);
 
 	if (kovaplus->roccat_claimed)
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 75a092e..8140776b 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -637,6 +637,9 @@ static int pyra_raw_event(struct hid_device *hdev, struct hid_report *report,
 			!= USB_INTERFACE_PROTOCOL_MOUSE)
 		return 0;
 
+	if (pyra == NULL)
+		return 0;
+
 	pyra_keep_values_up_to_date(pyra, data);
 
 	if (pyra->roccat_claimed)
-- 
1.7.3.4

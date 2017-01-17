From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 17/17] HID: logitech-hidpp: retrieve the name of the gaming mice over wireless
Date: Tue, 17 Jan 2017 15:35:47 +0100
Message-ID: <20170117143547.30488-18-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdAQOgc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Jan 2017 09:36:32 -0500
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The G700 and the G900 present both a wireless receiver with almost unifying
protocol. We handle them as bypass for the mouse and keyboard nodes, but
they appear in the system as "Logitech USB Receiver".

We can do better by retrieving the name from one of the nodes, the HID++
one of the receiver. To get the valid values in the non-HID++ nodes, we
delay their probing until the HID++ node has been found. This way, we
can retrieve the shared names and overwrite the USB provided ones.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 106 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 99caec4..3412101 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -123,6 +123,17 @@ struct hidpp_battery {
 	int level;
 };
 
+struct hidpp_shared {
+	struct list_head list;
+	int count;
+	char name[128];		/* Device name */
+	char phys[64];		/* Device physical location */
+	char uniq[64];		/* Device unique identifier (serial #) */
+};
+
+static LIST_HEAD(hidpp_shared_list);
+static DEFINE_MUTEX(hidpp_shared_list_lock);
+
 struct hidpp_device {
 	struct hid_device *hid_dev;
 	struct mutex send_mutex;
@@ -144,6 +155,8 @@ struct hidpp_device {
 	unsigned long quirks;
 
 	struct hidpp_battery battery;
+
+	struct hidpp_shared *shared;
 };
 
 /* HID++ 1.0 error codes */
@@ -2849,6 +2862,78 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	hidpp->delayed_input = input;
 }
 
+static void hidpp_remove_shared_data(void *res)
+{
+	struct hidpp_device *hidpp = res;
+
+	mutex_lock(&hidpp_shared_list_lock);
+
+	if (hidpp->shared && !--hidpp->shared->count) {
+		list_del(&hidpp->shared->list);
+		kfree(hidpp->shared);
+	}
+	hidpp->shared = NULL;
+
+	mutex_unlock(&hidpp_shared_list_lock);
+}
+
+static bool hidpp_compare_device_paths(const char *hdev_a, const char *hdev_b)
+{
+	const char separator = '/';
+	int n1 = strrchr(hdev_a, separator) - hdev_a;
+	int n2 = strrchr(hdev_b, separator) - hdev_b;
+
+	if (n1 != n2 || n1 <= 0 || n2 <= 0)
+		return false;
+
+	return !strncmp(hdev_a, hdev_b, n1);
+}
+
+static int hidpp_get_shared_data(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	struct hidpp_shared *s, *shared = NULL;
+	int ret;
+
+	mutex_lock(&hidpp_shared_list_lock);
+
+	if (hidpp->device_index != 0xff) {
+		shared = kzalloc(sizeof(struct hidpp_shared), GFP_KERNEL);
+		if (!shared) {
+			mutex_unlock(&hidpp_shared_list_lock);
+			return -ENOMEM;
+		}
+		memcpy(shared->name, hdev->name, sizeof(shared->name));
+		memcpy(shared->uniq, hdev->uniq, sizeof(shared->uniq));
+		memcpy(shared->phys, hdev->phys, sizeof(shared->phys));
+		list_add_tail(&shared->list, &hidpp_shared_list);
+	} else {
+		list_for_each_entry(s, &hidpp_shared_list, list) {
+			if (hidpp_compare_device_paths(s->phys, hdev->phys))
+				shared = s;
+		}
+	}
+
+	if (!shared) {
+		mutex_unlock(&hidpp_shared_list_lock);
+		return -EPROBE_DEFER;
+	}
+
+	hidpp->shared = shared;
+	shared->count++;
+
+	mutex_unlock(&hidpp_shared_list_lock);
+
+	ret = devm_add_action_or_reset(&hidpp->hid_dev->dev,
+					hidpp_remove_shared_data, hidpp);
+	if (ret)
+		return ret;
+
+	memcpy(hdev->name, shared->name, sizeof(hdev->name));
+	memcpy(hdev->uniq, shared->uniq, sizeof(hdev->uniq));
+	return 0;
+}
+
 static DEVICE_ATTR(builtin_power_supply, 0000, NULL, NULL);
 
 static struct attribute *sysfs_attrs[] = {
@@ -2910,8 +2995,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/*
 	 * Make sure the device is HID++ capable, otherwise treat as generic HID
+	 * Special case for manually affected Unifying receiver where we want to
+	 * link the interfaces together to have a proper name instead of
+	 * "Logitech USB Receiver".
 	 */
-	if (!hidpp_validate_device(hdev))
+	if (!(id->driver_data & HIDPP_QUIRK_UNIFYING) &&
+	    !hidpp_validate_device(hdev))
 		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 
 	/*
@@ -2995,8 +3084,11 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
 
-	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
-		hidpp_unifying_init(hidpp);
+	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING) {
+		ret = hidpp_unifying_init(hidpp);
+		if (ret)
+			goto start;
+	}
 
 	connected = hidpp_is_connected(hidpp);
 	if (!(hidpp->quirks & HIDPP_QUIRK_UNIFYING)) {
@@ -3026,6 +3118,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hidpp_connect_event(hidpp);
 
+start:
 	/* Reset the HID node state */
 	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
@@ -3034,6 +3127,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
+	if ((hidpp->quirks & HIDPP_QUIRK_UNIFYING) &&
+	    id->group != HID_GROUP_LOGITECH_DJ_DEVICE) {
+		ret = hidpp_get_shared_data(hidpp);
+		if (ret)
+			goto hid_hw_start_fail;
+	}
+
 	/* Now export the actual inputs and hidraw nodes to the world */
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
-- 
2.9.3


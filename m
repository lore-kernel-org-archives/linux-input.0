From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 11/17] HID: logitech-hidpp: add a sysfs file to tell we support power_supply
Date: Tue, 17 Jan 2017 15:35:41 +0100
Message-ID: <20170117143547.30488-12-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This way, upower can add a simple udev rule to decide whether or not
it should use the internal unifying support or just the generic kernel
one.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 3ae2f41..033ef4c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2736,6 +2736,17 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	hidpp->delayed_input = input;
 }
 
+static DEVICE_ATTR(builtin_power_supply, 0000, NULL, NULL);
+
+static struct attribute *sysfs_attrs[] = {
+	&dev_attr_builtin_power_supply.attr,
+	NULL
+};
+
+static struct attribute_group ps_attribute_group = {
+	.attrs = sysfs_attrs
+};
+
 static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidpp_device *hidpp;
@@ -2777,6 +2788,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mutex_init(&hidpp->send_mutex);
 	init_waitqueue_head(&hidpp->wait);
 
+	/* indicates we are handling the battery properties in the kernel */
+	ret = sysfs_create_group(&hdev->dev.kobj, &ps_attribute_group);
+	if (ret)
+		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
+			 hdev->name);
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "%s:parse failed\n", __func__);
@@ -2856,6 +2873,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 hid_hw_start_fail:
 hid_parse_fail:
+	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
 allocate_fail:
@@ -2867,6 +2885,8 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
 		hidpp_ff_deinit(hdev);
 		hid_hw_close(hdev);
-- 
2.9.3

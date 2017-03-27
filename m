From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 19/19] HID: logitech-hidpp: add a sysfs file to tell we support power_supply
Date: Mon, 27 Mar 2017 16:59:39 +0200
Message-ID: <20170327145939.29824-20-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This way, upower can add a simple udev rule to decide whether or not
it should use the internal unifying support or just the generic kernel
one.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index eb4339e..41b3946 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2916,6 +2916,17 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
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
@@ -2960,6 +2971,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -3042,6 +3059,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 hid_hw_start_fail:
 hid_parse_fail:
+	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
 allocate_fail:
@@ -3053,6 +3071,8 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
 		hidpp_ff_deinit(hdev);
 		hid_hw_close(hdev);
-- 
2.9.3

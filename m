From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH] HID: sony: Report DS4 version info through sysfs
Date: Tue, 19 Dec 2017 11:04:43 -0800
Message-ID: <20171219190443.52950-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45683 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdLSTEs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Dec 2017 14:04:48 -0500
Received: by mail-qk0-f196.google.com with SMTP id o126so11357886qke.12
        for <linux-input@vger.kernel.org>; Tue, 19 Dec 2017 11:04:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Report DS4 firmware and hardware version through sysfs for both
USB and Bluetooth. This information is important for userspace
in particular for device specific quirks (e.g. in Bluetooth stacks).

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b9dc3ac4d4aa..432d9a47cab0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -473,6 +473,7 @@ struct motion_output_report_02 {
 #define DS4_FEATURE_REPORT_0x02_SIZE 37
 #define DS4_FEATURE_REPORT_0x05_SIZE 41
 #define DS4_FEATURE_REPORT_0x81_SIZE 7
+#define DS4_FEATURE_REPORT_0xA3_SIZE 49
 #define DS4_INPUT_REPORT_0x11_SIZE 78
 #define DS4_OUTPUT_REPORT_0x05_SIZE 32
 #define DS4_OUTPUT_REPORT_0x11_SIZE 78
@@ -544,6 +545,8 @@ struct sony_sc {
 	struct power_supply *battery;
 	struct power_supply_desc battery_desc;
 	int device_id;
+	unsigned fw_version;
+	unsigned hw_version;
 	u8 *output_report_dmabuf;
 
 #ifdef CONFIG_SONY_FF
@@ -627,6 +630,29 @@ static ssize_t ds4_store_poll_interval(struct device *dev,
 static DEVICE_ATTR(bt_poll_interval, 0644, ds4_show_poll_interval,
 		ds4_store_poll_interval);
 
+static ssize_t sony_show_firmware_version(struct device *dev,
+				struct device_attribute
+				*attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->fw_version);
+}
+
+static DEVICE_ATTR(firmware_version, 0444, sony_show_firmware_version, NULL);
+
+static ssize_t sony_show_hardware_version(struct device *dev,
+				struct device_attribute
+				*attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->hw_version);
+}
+
+static DEVICE_ATTR(hardware_version, 0444, sony_show_hardware_version, NULL);
 
 static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
@@ -1646,6 +1672,31 @@ static void dualshock4_calibration_work(struct work_struct *work)
 	spin_unlock_irqrestore(&sc->lock, flags);
 }
 
+static int dualshock4_get_version_info(struct sony_sc *sc)
+{
+	u8 *buf;
+	int ret;
+
+	buf = kmalloc(DS4_FEATURE_REPORT_0xA3_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(sc->hdev, 0xA3, buf,
+				 DS4_FEATURE_REPORT_0xA3_SIZE,
+				 HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		kfree(buf);
+		return ret;
+	}
+
+	sc->hw_version = get_unaligned_le16(&buf[35]);
+	sc->fw_version = get_unaligned_le16(&buf[41]);
+
+	kfree(buf);
+	return 0;
+}
+
 static void sixaxis_set_leds_from_id(struct sony_sc *sc)
 {
 	static const u8 sixaxis_leds[10][4] = {
@@ -2619,6 +2670,28 @@ static int sony_input_configured(struct hid_device *hdev,
 			goto err_stop;
 		}
 
+		ret = dualshock4_get_version_info(sc);
+		if (ret < 0) {
+			hid_err(sc->hdev, "Failed to get version data from Dualshock 4\n");
+			goto err_stop;
+		}
+
+		ret = device_create_file(&sc->hdev->dev, &dev_attr_firmware_version);
+		if (ret) {
+			/* Make zero for cleanup reasons of sysfs entries. */
+			sc->fw_version = 0;
+			sc->hw_version = 0;
+			hid_err(sc->hdev, "can't create sysfs firmware_version attribute err: %d\n", ret);
+			goto err_stop;
+		}
+
+		ret = device_create_file(&sc->hdev->dev, &dev_attr_hardware_version);
+		if (ret) {
+			sc->hw_version = 0;
+			hid_err(sc->hdev, "can't create sysfs hardware_version attribute err: %d\n", ret);
+			goto err_stop;
+		}
+
 		/*
 		 * The Dualshock 4 touchpad supports 2 touches and has a
 		 * resolution of 1920x942 (44.86 dots/mm).
@@ -2695,6 +2768,10 @@ static int sony_input_configured(struct hid_device *hdev,
 	 */
 	if (sc->ds4_bt_poll_interval)
 		device_remove_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);
+	if (sc->fw_version)
+		device_remove_file(&sc->hdev->dev, &dev_attr_firmware_version);
+	if (sc->hw_version)
+		device_remove_file(&sc->hdev->dev, &dev_attr_hardware_version);
 	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(sc);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
@@ -2796,6 +2873,12 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)
 		device_remove_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);
 
+	if (sc->fw_version)
+		device_remove_file(&sc->hdev->dev, &dev_attr_firmware_version);
+
+	if (sc->hw_version)
+		device_remove_file(&sc->hdev->dev, &dev_attr_hardware_version);
+
 	sony_cancel_work_sync(sc);
 
 	kfree(sc->output_report_dmabuf);
-- 
2.13.6


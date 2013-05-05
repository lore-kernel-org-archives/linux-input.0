From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 21/26] HID: wiimote: add "bboard_calib" attribute
Date: Sun,  5 May 2013 23:13:05 +0200
Message-ID: <1367788390-29835-22-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:51340 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3EEVOS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:18 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1355488bkc.30
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:17 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Balance-Boards provide 3 16bit calibration values for each of the 4
sensors. We provide these now as 192bit value via a new "bboard_calib"
sysfs attribute.
We also re-read the calibration data from the device whenever user-space
attempts to read this file. On normal Nintendo boards, this always
produces the same results, however, on some 3rd party devices these values
change until the device is fully initialized. As I have currently no idea
how long to wait until it's ready (sometimes takes up to 10s?) we provide
a simple workaround for users by reading this file.

If we, at some point, figure out how it works, we can implement it in the
kernel and provide offline data via "bboard_calib". This won't break
user-space then.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote | 15 +++++
 drivers/hid/hid-wiimote-modules.c                  | 68 +++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index e8f6b16..ed5dd56 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -42,3 +42,18 @@ Description:	While a device is initialized by the wiimote driver, we perform
 			gen10: First Wii Remote generation
 			gen20: Second Wii Remote Plus generation (builtin MP)
 			balanceboard: Wii Balance Board
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/bboard_calib
+Date:		May 2013
+KernelVersion:	3.11
+Contact:	David Herrmann <dh.herrmann@gmail.com>
+Description:	This attribute is only provided if the device was detected as a
+		balance board. It provides a single line with 3 calibration
+		values for all 4 sensors. The values are separated by colons and
+		are each 2 bytes long (encoded as 4 digit hexadecimal value).
+		First, 0kg values for all 4 sensors are written, followed by the
+		17kg values for all 4 sensors and last the 34kg values for all 4
+		sensors.
+		Calibration data is already applied by the kernel to all input
+		values but may be used by user-space to perform other
+		transformations.
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index aee1b2c..19b8b1c 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1380,6 +1380,60 @@ static void wiimod_bboard_close(struct input_dev *dev)
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 }
 
+static ssize_t wiimod_bboard_calib_show(struct device *dev,
+					struct device_attribute *attr,
+					char *out)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	int i, j, ret;
+	__u16 val;
+	__u8 buf[24], offs;
+
+	ret = wiimote_cmd_acquire(wdata);
+	if (ret)
+		return ret;
+
+	ret = wiimote_cmd_read(wdata, 0xa40024, buf, 12);
+	if (ret != 12) {
+		wiimote_cmd_release(wdata);
+		return ret < 0 ? ret : -EIO;
+	}
+	ret = wiimote_cmd_read(wdata, 0xa40024 + 12, buf + 12, 12);
+	if (ret != 12) {
+		wiimote_cmd_release(wdata);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	wiimote_cmd_release(wdata);
+
+	spin_lock_irq(&wdata->state.lock);
+	offs = 0;
+	for (i = 0; i < 3; ++i) {
+		for (j = 0; j < 4; ++j) {
+			wdata->state.calib_bboard[j][i] = buf[offs];
+			wdata->state.calib_bboard[j][i] <<= 8;
+			wdata->state.calib_bboard[j][i] |= buf[offs + 1];
+			offs += 2;
+		}
+	}
+	spin_unlock_irq(&wdata->state.lock);
+
+	ret = 0;
+	for (i = 0; i < 3; ++i) {
+		for (j = 0; j < 4; ++j) {
+			val = wdata->state.calib_bboard[j][i];
+			if (i == 2 && j == 3)
+				ret += sprintf(&out[ret], "%04x\n", val);
+			else
+				ret += sprintf(&out[ret], "%04x:", val);
+		}
+	}
+
+	return ret;
+}
+
+static DEVICE_ATTR(bboard_calib, S_IRUGO, wiimod_bboard_calib_show, NULL);
+
 static int wiimod_bboard_probe(const struct wiimod_ops *ops,
 			       struct wiimote_data *wdata)
 {
@@ -1415,6 +1469,13 @@ static int wiimod_bboard_probe(const struct wiimod_ops *ops,
 	if (!wdata->extension.input)
 		return -ENOMEM;
 
+	ret = device_create_file(&wdata->hdev->dev,
+				 &dev_attr_bboard_calib);
+	if (ret) {
+		hid_err(wdata->hdev, "cannot create sysfs attribute\n");
+		goto err_free;
+	}
+
 	input_set_drvdata(wdata->extension.input, wdata);
 	wdata->extension.input->open = wiimod_bboard_open;
 	wdata->extension.input->close = wiimod_bboard_close;
@@ -1444,10 +1505,13 @@ static int wiimod_bboard_probe(const struct wiimod_ops *ops,
 
 	ret = input_register_device(wdata->extension.input);
 	if (ret)
-		goto err_free;
+		goto err_file;
 
 	return 0;
 
+err_file:
+	device_remove_file(&wdata->hdev->dev,
+			   &dev_attr_bboard_calib);
 err_free:
 	input_free_device(wdata->extension.input);
 	wdata->extension.input = NULL;
@@ -1462,6 +1526,8 @@ static void wiimod_bboard_remove(const struct wiimod_ops *ops,
 
 	input_unregister_device(wdata->extension.input);
 	wdata->extension.input = NULL;
+	device_remove_file(&wdata->hdev->dev,
+			   &dev_attr_bboard_calib);
 }
 
 static const struct wiimod_ops wiimod_bboard = {
-- 
1.8.2.2


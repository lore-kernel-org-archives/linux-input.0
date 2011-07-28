From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 14/16] HID: wiimote: Allow userspace to control IR cam
Date: Thu, 28 Jul 2011 18:08:34 +0200
Message-ID: <1311869316-17128-15-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab1G1QJX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:23 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:22 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

This adds a new sysfs attribute to wiimotes which allows userspace to enable or
disable the IR cam and set it into the desired mode.

Disabling IR saves lots of energy on the wiimote, so it is not enabled by
default.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   10 +++
 drivers/hid/hid-wiimote.c                          |   74 ++++++++++++++++++++
 2 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index d8ccea8..4ec761d 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -24,3 +24,13 @@ Contact:	David Herrmann <dh.herrmann@googlemail.com>
 Description:	Writing 1 to this file enables accelerometer data reporting of
 		the wiimote, 0 disables it. Reading from this file returns the
 		current value.
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/ir
+Date:		July 2011
+KernelVersion:	3.2
+Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Description:	Reading this attribute returns the current status of the IR
+		cam of the wiimote. It can be one of: off, basic, extended or
+		full.
+		Writing one of these strings to the file tries to put the IR
+		cam into the desired state.
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index bca46ba..69a555a3 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -700,6 +700,75 @@ static ssize_t wiifs_accel_set(struct device *dev,
 static DEVICE_ATTR(accelerometer, S_IRUGO | S_IWUSR, wiifs_accel_show,
 							wiifs_accel_set);
 
+static ssize_t wiifs_ir_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	unsigned long flags;
+	const char *mode;
+	__u8 flag;
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	flag = wdata->state.flags & WIIPROTO_FLAGS_IR;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	switch (flag) {
+		case WIIPROTO_FLAG_IR_FULL:
+			mode = "full";
+			break;
+		case WIIPROTO_FLAG_IR_EXT:
+			mode = "extended";
+			break;
+		case WIIPROTO_FLAG_IR_BASIC:
+			mode = "basic";
+			break;
+		default:
+			mode = "off";
+			break;
+	}
+
+
+	return sprintf(buf, "%s\n", mode);
+}
+
+static ssize_t wiifs_ir_set(struct device *dev, struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	int ret;
+	__u8 mode;
+
+	if (count == 0)
+		return -EINVAL;
+
+	if (!strncasecmp("basic", buf, 5))
+		mode = WIIPROTO_FLAG_IR_BASIC;
+	else if (!strncasecmp("extended", buf, 8))
+		mode = WIIPROTO_FLAG_IR_EXT;
+	else if (!strncasecmp("full", buf, 4))
+		mode = WIIPROTO_FLAG_IR_FULL;
+	else if (!strncasecmp("off", buf, 3))
+		mode = 0;
+	else
+		return -EINVAL;
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
+	smp_rmb();
+
+	ret = wiimote_init_ir(wdata, mode);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR(ir, S_IRUGO | S_IWUSR, wiifs_ir_show, wiifs_ir_set);
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
@@ -1077,6 +1146,9 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	ret = device_create_file(&hdev->dev, &dev_attr_accelerometer);
 	if (ret)
 		goto err;
+	ret = device_create_file(&hdev->dev, &dev_attr_ir);
+	if (ret)
+		goto err;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -1118,6 +1190,7 @@ err:
 	device_remove_file(&hdev->dev, &dev_attr_led4);
 	device_remove_file(&hdev->dev, &dev_attr_rumble);
 	device_remove_file(&hdev->dev, &dev_attr_accelerometer);
+	device_remove_file(&hdev->dev, &dev_attr_ir);
 	wiimote_destroy(wdata);
 	return ret;
 }
@@ -1134,6 +1207,7 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	device_remove_file(&hdev->dev, &dev_attr_led4);
 	device_remove_file(&hdev->dev, &dev_attr_rumble);
 	device_remove_file(&hdev->dev, &dev_attr_accelerometer);
+	device_remove_file(&hdev->dev, &dev_attr_ir);
 
 	hid_hw_stop(hdev);
 	input_unregister_device(wdata->input);
-- 
1.7.6


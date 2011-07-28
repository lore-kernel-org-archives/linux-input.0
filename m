From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 06/16] HID: wiimote: Enable accelerometer on request
Date: Thu, 28 Jul 2011 18:08:26 +0200
Message-ID: <1311869316-17128-7-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab1G1QJL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:11 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:10 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

The wiimote has an internal accelerometer which can report data to the host.
Userspace may now write to a new sysfs file to make the driver enable
accelerometer reporting. This is not enabled by default to reduce power
consumption of the wiimote. Accelerometer data is reported every few
milliseconds and thus consumes much bluetooth bandwidth which costs much energy
of the wiimote.
By writing 0 to the sysfs file, accelerometer reporting is disabled again.

The wiimotes accelerometer does not need to be enabled explicitely, we only need
to set the DRM to a mode which includes accelerometer data.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |    8 +++
 drivers/hid/hid-wiimote.c                          |   57 ++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index 235dd47..d8ccea8 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -16,3 +16,11 @@ Contact:	David Herrmann <dh.herrmann@googlemail.com>
 Description:	Writing 1 to this file enables the rumble motor on the wiimote
 		and writing 0 disables it again. Reading from this file returns
 		1 if rumble is on and 0 if it is off.
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/accelerometer
+Date:		July 2011
+KernelVersion:	3.2
+Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Description:	Writing 1 to this file enables accelerometer data reporting of
+		the wiimote, 0 disables it. Reading from this file returns the
+		current value.
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index bac4410..13c27b7 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -51,6 +51,7 @@ struct wiimote_data {
 #define WIIPROTO_FLAG_LED3		0x04
 #define WIIPROTO_FLAG_LED4		0x08
 #define WIIPROTO_FLAG_RUMBLE		0x10
+#define WIIPROTO_FLAG_ACCEL		0x20
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
 
@@ -257,6 +258,20 @@ static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
+{
+	accel = !!accel;
+	if (accel == !!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
+		return;
+
+	if (accel)
+		wdata->state.flags |= WIIPROTO_FLAG_ACCEL;
+	else
+		wdata->state.flags &= ~WIIPROTO_FLAG_ACCEL;
+
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+}
+
 #define wiifs_led_show_set(num)						\
 static ssize_t wiifs_led_show_##num(struct device *dev,			\
 			struct device_attribute *attr, char *buf)	\
@@ -343,6 +358,43 @@ static ssize_t wiifs_rumble_set(struct device *dev,
 static DEVICE_ATTR(rumble, S_IRUGO | S_IWUSR, wiifs_rumble_show,
 							wiifs_rumble_set);
 
+static ssize_t wiifs_accel_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	unsigned long flags;
+	int state;
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	state = !!(wdata->state.flags & WIIPROTO_FLAG_ACCEL);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return sprintf(buf, "%d\n", state);
+}
+
+static ssize_t wiifs_accel_set(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	int tmp = simple_strtoul(buf, NULL, 10);
+	unsigned long flags;
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiiproto_req_accel(wdata, tmp);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return count;
+}
+
+static DEVICE_ATTR(accelerometer, S_IRUGO | S_IWUSR, wiifs_accel_show,
+							wiifs_accel_set);
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
@@ -516,6 +568,9 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	ret = device_create_file(&hdev->dev, &dev_attr_rumble);
 	if (ret)
 		goto err;
+	ret = device_create_file(&hdev->dev, &dev_attr_accelerometer);
+	if (ret)
+		goto err;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -556,6 +611,7 @@ err:
 	device_remove_file(&hdev->dev, &dev_attr_led3);
 	device_remove_file(&hdev->dev, &dev_attr_led4);
 	device_remove_file(&hdev->dev, &dev_attr_rumble);
+	device_remove_file(&hdev->dev, &dev_attr_accelerometer);
 	wiimote_destroy(wdata);
 	return ret;
 }
@@ -571,6 +627,7 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	device_remove_file(&hdev->dev, &dev_attr_led3);
 	device_remove_file(&hdev->dev, &dev_attr_led4);
 	device_remove_file(&hdev->dev, &dev_attr_rumble);
+	device_remove_file(&hdev->dev, &dev_attr_accelerometer);
 
 	hid_hw_stop(hdev);
 	input_unregister_device(wdata->input);
-- 
1.7.6


From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 15/16] HID: wiimote: Read wiimote battery charge level
Date: Thu, 28 Jul 2011 18:08:35 +0200
Message-ID: <1311869316-17128-16-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab1G1QJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:24 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400102fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:24 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

This adds a new sysfs file for wiimotes which returns the current battery charge
level of the device. Since this information is not sent by the wiimote
continously, we need to explicitely request it.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |    8 +++
 drivers/hid/hid-wiimote.c                          |   56 ++++++++++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index 4ec761d..ab41561 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -34,3 +34,11 @@ Description:	Reading this attribute returns the current status of the IR
 		full.
 		Writing one of these strings to the file tries to put the IR
 		cam into the desired state.
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/battery
+Date:		July 2011
+KernelVersion:	3.2
+Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Description:	Readonly attribute which returns the current battery charge
+		level. An integer between 0 and 255 is returned, 0 means empty
+		and 255 full.
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 69a555a3..64200e5 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -41,6 +41,7 @@ struct wiimote_state {
 	__u32 opt;
 
 	/* results of synchronous requests */
+	__u8 cmd_battery;
 	__u8 cmd_err;
 };
 
@@ -78,6 +79,7 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_LED = 0x11,
 	WIIPROTO_REQ_DRM = 0x12,
 	WIIPROTO_REQ_IR1 = 0x13,
+	WIIPROTO_REQ_SREQ = 0x15,
 	WIIPROTO_REQ_WMEM = 0x16,
 	WIIPROTO_REQ_RMEM = 0x17,
 	WIIPROTO_REQ_IR2 = 0x1a,
@@ -351,6 +353,17 @@ static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+static void wiiproto_req_status(struct wiimote_data *wdata)
+{
+	__u8 cmd[2];
+
+	cmd[0] = WIIPROTO_REQ_SREQ;
+	cmd[1] = 0;
+
+	wiiproto_keep_rumble(wdata, &cmd[1]);
+	wiimote_queue(wdata, cmd, sizeof(cmd));
+}
+
 static void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel)
 {
 	accel = !!accel;
@@ -700,6 +713,39 @@ static ssize_t wiifs_accel_set(struct device *dev,
 static DEVICE_ATTR(accelerometer, S_IRUGO | S_IWUSR, wiifs_accel_show,
 							wiifs_accel_set);
 
+static ssize_t wiifs_battery_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	unsigned long flags;
+	int state, ret;
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
+	smp_rmb();
+
+	ret = wiimote_cmd_acquire(wdata);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
+	wiiproto_req_status(wdata);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+	state = wdata->state.cmd_battery;
+	wiimote_cmd_release(wdata);
+
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", state);
+}
+
+static DEVICE_ATTR(battery, S_IRUGO, wiifs_battery_show, NULL);
+
 static ssize_t wiifs_ir_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
@@ -874,6 +920,11 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 
 	/* on status reports the drm is reset so we need to resend the drm */
 	wiiproto_req_drm(wdata, 0);
+
+	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_SREQ, 0)) {
+		wdata->state.cmd_battery = payload[5];
+		wiimote_cmd_complete(wdata);
+	}
 }
 
 static void handler_data(struct wiimote_data *wdata, const __u8 *payload)
@@ -1149,6 +1200,9 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	ret = device_create_file(&hdev->dev, &dev_attr_ir);
 	if (ret)
 		goto err;
+	ret = device_create_file(&hdev->dev, &dev_attr_battery);
+	if (ret)
+		goto err;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -1191,6 +1245,7 @@ err:
 	device_remove_file(&hdev->dev, &dev_attr_rumble);
 	device_remove_file(&hdev->dev, &dev_attr_accelerometer);
 	device_remove_file(&hdev->dev, &dev_attr_ir);
+	device_remove_file(&hdev->dev, &dev_attr_battery);
 	wiimote_destroy(wdata);
 	return ret;
 }
@@ -1208,6 +1263,7 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	device_remove_file(&hdev->dev, &dev_attr_rumble);
 	device_remove_file(&hdev->dev, &dev_attr_accelerometer);
 	device_remove_file(&hdev->dev, &dev_attr_ir);
+	device_remove_file(&hdev->dev, &dev_attr_battery);
 
 	hid_hw_stop(hdev);
 	input_unregister_device(wdata->input);
-- 
1.7.6


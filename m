From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 02/16] HID: wiimote: Add sysfs rumble attribute
Date: Thu, 28 Jul 2011 18:08:22 +0200
Message-ID: <1311869316-17128-3-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab1G1QJG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:06 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:05 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Add "rumble" attribute to sysfs for every wiimote to allow userspace to control
the rumble motor of a wiimote.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |    8 ++++
 drivers/hid/hid-wiimote.c                          |   42 ++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index 5d5a16e..235dd47 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -8,3 +8,11 @@ Contact:	David Herrmann <dh.herrmann@googlemail.com>
 Description:	Make it possible to set/get current led state. Reading from it
 		returns 0 if led is off and 1 if it is on. Writing 0 to it
 		disables the led, writing 1 enables it.
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/rumble
+Date:		July 2011
+KernelVersion:	3.2
+Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Description:	Writing 1 to this file enables the rumble motor on the wiimote
+		and writing 0 disables it again. Reading from this file returns
+		1 if rumble is on and 0 if it is off.
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 6fa73c7..4070060 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -277,6 +277,43 @@ wiifs_led_show_set(2);
 wiifs_led_show_set(3);
 wiifs_led_show_set(4);
 
+static ssize_t wiifs_rumble_show(struct device *dev,
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
+	state = !!(wdata->state.flags & WIIPROTO_FLAG_RUMBLE);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return sprintf(buf, "%d\n", state);
+}
+
+static ssize_t wiifs_rumble_set(struct device *dev,
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
+	wiiproto_req_rumble(wdata, tmp);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return count;
+}
+
+static DEVICE_ATTR(rumble, S_IRUGO | S_IWUSR, wiifs_rumble_show,
+							wiifs_rumble_set);
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
@@ -425,6 +462,9 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	ret = device_create_file(&hdev->dev, &dev_attr_led4);
 	if (ret)
 		goto err;
+	ret = device_create_file(&hdev->dev, &dev_attr_rumble);
+	if (ret)
+		goto err;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -464,6 +504,7 @@ err:
 	device_remove_file(&hdev->dev, &dev_attr_led2);
 	device_remove_file(&hdev->dev, &dev_attr_led3);
 	device_remove_file(&hdev->dev, &dev_attr_led4);
+	device_remove_file(&hdev->dev, &dev_attr_rumble);
 	wiimote_destroy(wdata);
 	return ret;
 }
@@ -478,6 +519,7 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	device_remove_file(&hdev->dev, &dev_attr_led2);
 	device_remove_file(&hdev->dev, &dev_attr_led3);
 	device_remove_file(&hdev->dev, &dev_attr_led4);
+	device_remove_file(&hdev->dev, &dev_attr_rumble);
 
 	hid_hw_stop(hdev);
 	input_unregister_device(wdata->input);
-- 
1.7.6


From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 14/14] HID: wiimote: Read wiimote battery charge level
Date: Mon, 29 Aug 2011 15:38:11 +0200
Message-ID: <1314625091-1405-15-git-send-email-dh.herrmann@googlemail.com>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab1H2Niv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 09:38:51 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4422164fxh.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 06:38:51 -0700 (PDT)
In-Reply-To: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

This adds a new sysfs file for wiimotes which returns the current battery charge
level of the device. Since this information is not sent by the wiimote
continously, we need to explicitely request it.

Also bump version number since the core driver is feature complete now.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |    8 ++++
 drivers/hid/hid-wiimote.c                          |   38 +++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index 5d5a16e..817aa82 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -8,3 +8,11 @@ Contact:	David Herrmann <dh.herrmann@googlemail.com>
 Description:	Make it possible to set/get current led state. Reading from it
 		returns 0 if led is off and 1 if it is on. Writing 0 to it
 		disables the led, writing 1 enables it.
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/battery
+Date:		July 2011
+KernelVersion:	3.2
+Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Description:	Readonly attribute which returns the current battery charge
+		level. An integer between 0 and 255 is returned, 0 means empty
+		and 255 full.
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 48198cb..271630c 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -20,7 +20,7 @@
 #include <linux/spinlock.h>
 #include "hid-ids.h"
 
-#define WIIMOTE_VERSION "0.1"
+#define WIIMOTE_VERSION "0.2"
 #define WIIMOTE_NAME "Nintendo Wii Remote"
 #define WIIMOTE_BUFSIZE 32
 
@@ -133,6 +133,9 @@ static __u16 wiiproto_keymap[] = {
 	BTN_MODE,	/* WIIPROTO_KEY_HOME */
 };
 
+#define dev_to_wii(pdev) hid_get_drvdata(container_of(pdev, struct hid_device, \
+									dev))
+
 /* requires the state.lock spinlock to be held */
 static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
 								__u32 opt)
@@ -638,6 +641,34 @@ static int wiimote_ff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
+static ssize_t wiifs_battery_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	unsigned long flags;
+	int state, ret;
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
 static int wiimote_input_open(struct input_dev *dev)
 {
 	struct wiimote_data *wdata = input_get_drvdata(dev);
@@ -1154,6 +1185,7 @@ err:
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
 	wiimote_leds_destroy(wdata);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_battery);
 
 	input_unregister_device(wdata->accel);
 	input_unregister_device(wdata->ir);
@@ -1206,6 +1238,10 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_input;
 	}
 
+	ret = device_create_file(&hdev->dev, &dev_attr_battery);
+	if (ret)
+		goto err_free;
+
 	ret = wiimote_leds_create(wdata);
 	if (ret)
 		goto err_free;
-- 
1.7.6.1


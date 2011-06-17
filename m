From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 12/12 v2] HID: wiimote: Add sysfs support to wiimote driver
Date: Fri, 17 Jun 2011 16:49:22 +0200
Message-ID: <1308322162-13953-12-git-send-email-dh.herrmann@googlemail.com>
References: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59269 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759263Ab1FQOub (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 10:50:31 -0400
Received: by fxm17 with SMTP id 17so1796261fxm.19
        for <linux-input@vger.kernel.org>; Fri, 17 Jun 2011 07:50:29 -0700 (PDT)
In-Reply-To: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, dh.herrmann@googlemail.com

Add sysfs files for each led of the wiimote. Writing 1 to the file
enables the led and 0 disables the led.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Document new ABI

 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   10 +++
 drivers/hid/hid-wiimote.c                          |   74 ++++++++++++++++++++
 2 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-wiimote

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
new file mode 100644
index 0000000..5d5a16e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -0,0 +1,10 @@
+What:		/sys/bus/hid/drivers/wiimote/<dev>/led1
+What:		/sys/bus/hid/drivers/wiimote/<dev>/led2
+What:		/sys/bus/hid/drivers/wiimote/<dev>/led3
+What:		/sys/bus/hid/drivers/wiimote/<dev>/led4
+Date:		July 2011
+KernelVersion:	3.1
+Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Description:	Make it possible to set/get current led state. Reading from it
+		returns 0 if led is off and 1 if it is on. Writing 0 to it
+		disables the led, writing 1 enables it.
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 7779f41..2062ea1 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -87,6 +87,9 @@ static __u16 wiiproto_keymap[] = {
 	BTN_MODE,	/* WIIPROTO_KEY_HOME */
 };
 
+#define dev_to_wii(pdev) hid_get_drvdata(container_of(pdev, struct hid_device, \
+									dev))
+
 static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
 								size_t count)
 {
@@ -203,6 +206,55 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
+#define wiifs_led_show_set(num)						\
+static ssize_t wiifs_led_show_##num(struct device *dev,			\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	struct wiimote_data *wdata = dev_to_wii(dev);			\
+	unsigned long flags;						\
+	int state;							\
+									\
+	if (!atomic_read(&wdata->ready))				\
+		return -EBUSY;						\
+									\
+	spin_lock_irqsave(&wdata->state.lock, flags);			\
+	state = !!(wdata->state.flags & WIIPROTO_FLAG_LED##num);	\
+	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
+									\
+	return sprintf(buf, "%d\n", state);				\
+}									\
+static ssize_t wiifs_led_set_##num(struct device *dev,			\
+	struct device_attribute *attr, const char *buf, size_t count)	\
+{									\
+	struct wiimote_data *wdata = dev_to_wii(dev);			\
+	int tmp = simple_strtoul(buf, NULL, 10);			\
+	unsigned long flags;						\
+	__u8 state;							\
+									\
+	if (!atomic_read(&wdata->ready))				\
+		return -EBUSY;						\
+									\
+	spin_lock_irqsave(&wdata->state.lock, flags);			\
+									\
+	state = wdata->state.flags;					\
+									\
+	if (tmp)							\
+		wiiproto_req_leds(wdata, state | WIIPROTO_FLAG_LED##num);\
+	else								\
+		wiiproto_req_leds(wdata, state & ~WIIPROTO_FLAG_LED##num);\
+									\
+	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
+									\
+	return count;							\
+}									\
+static DEVICE_ATTR(led##num, S_IRUGO | S_IWUSR, wiifs_led_show_##num,	\
+						wiifs_led_set_##num)
+
+wiifs_led_show_set(1);
+wiifs_led_show_set(2);
+wiifs_led_show_set(3);
+wiifs_led_show_set(4);
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
@@ -337,6 +389,19 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		return -ENOMEM;
 	}
 
+	ret = device_create_file(&hdev->dev, &dev_attr_led1);
+	if (ret)
+		goto err;
+	ret = device_create_file(&hdev->dev, &dev_attr_led2);
+	if (ret)
+		goto err;
+	ret = device_create_file(&hdev->dev, &dev_attr_led3);
+	if (ret)
+		goto err;
+	ret = device_create_file(&hdev->dev, &dev_attr_led4);
+	if (ret)
+		goto err;
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "HID parse failed\n");
@@ -370,6 +435,10 @@ err_stop:
 	hid_hw_stop(hdev);
 err:
 	input_free_device(wdata->input);
+	device_remove_file(&hdev->dev, &dev_attr_led1);
+	device_remove_file(&hdev->dev, &dev_attr_led2);
+	device_remove_file(&hdev->dev, &dev_attr_led3);
+	device_remove_file(&hdev->dev, &dev_attr_led4);
 	wiimote_destroy(wdata);
 	return ret;
 }
@@ -388,6 +457,11 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	 * the device data.
 	 */
 
+	device_remove_file(&hdev->dev, &dev_attr_led1);
+	device_remove_file(&hdev->dev, &dev_attr_led2);
+	device_remove_file(&hdev->dev, &dev_attr_led3);
+	device_remove_file(&hdev->dev, &dev_attr_led4);
+
 	atomic_set(&wdata->ready, 0);
 	smp_wmb();
 	cancel_work_sync(&wdata->worker);
-- 
1.7.5.2


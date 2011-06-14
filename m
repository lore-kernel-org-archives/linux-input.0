From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 12/12] HID: wiimote: Add sysfs support to wiimote driver
Date: Wed, 15 Jun 2011 01:45:57 +0200
Message-ID: <1308095157-4699-13-git-send-email-dh.herrmann@googlemail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab1FNXq3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 19:46:29 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so41764fxm.19
        for <linux-input@vger.kernel.org>; Tue, 14 Jun 2011 16:46:29 -0700 (PDT)
In-Reply-To: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Add sysfs files for each led of the wiimote. Writing 1 to the file
enables the led and 0 disables the led.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   74 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index eb86c5d..0d93d93 100644
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
@@ -193,6 +196,55 @@ static void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
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
@@ -320,6 +372,19 @@ static int wiimote_hid_probe(struct hid_device *hdev,
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
@@ -352,6 +417,10 @@ err_stop:
 	hid_hw_stop(hdev);
 err:
 	input_free_device(wdata->input);
+	device_remove_file(&hdev->dev, &dev_attr_led1);
+	device_remove_file(&hdev->dev, &dev_attr_led2);
+	device_remove_file(&hdev->dev, &dev_attr_led3);
+	device_remove_file(&hdev->dev, &dev_attr_led4);
 	kfree(wdata);
 	return ret;
 }
@@ -370,6 +439,11 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	 * the device data.
 	 */
 
+	device_remove_file(&hdev->dev, &dev_attr_led1);
+	device_remove_file(&hdev->dev, &dev_attr_led2);
+	device_remove_file(&hdev->dev, &dev_attr_led3);
+	device_remove_file(&hdev->dev, &dev_attr_led4);
+
 	atomic_set(&wdata->ready, 0);
 	cancel_work_sync(&wdata->worker);
 
-- 
1.7.5.2


From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/7] HID: wiimote: Simplify synchronization
Date: Sat, 13 Aug 2011 15:29:09 +0200
Message-ID: <1313242155-3620-2-git-send-email-dh.herrmann@googlemail.com>
References: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55308 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1HMN3e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Aug 2011 09:29:34 -0400
Received: by fxh19 with SMTP id 19so2801621fxh.19
        for <linux-input@vger.kernel.org>; Sat, 13 Aug 2011 06:29:32 -0700 (PDT)
In-Reply-To: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

The new locking scheme in HID core allows us to remove a bit of synchronization.
Since the HID layer acts synchronously we simply register input core last and
there are no synchonization issues anymore.

Also register sysfs files last to simply the code.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   77 ++++++++++++++++-----------------------------
 1 files changed, 27 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index a594383..1e9c39d 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -33,7 +33,6 @@ struct wiimote_state {
 };
 
 struct wiimote_data {
-	atomic_t ready;
 	struct hid_device *hdev;
 	struct input_dev *input;
 
@@ -200,9 +199,6 @@ static ssize_t wiifs_led_show_##num(struct device *dev,			\
 	unsigned long flags;						\
 	int state;							\
 									\
-	if (!atomic_read(&wdata->ready))				\
-		return -EBUSY;						\
-									\
 	spin_lock_irqsave(&wdata->state.lock, flags);			\
 	state = !!(wdata->state.flags & WIIPROTO_FLAG_LED##num);	\
 	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
@@ -217,9 +213,6 @@ static ssize_t wiifs_led_set_##num(struct device *dev,			\
 	unsigned long flags;						\
 	__u8 state;							\
 									\
-	if (!atomic_read(&wdata->ready))				\
-		return -EBUSY;						\
-									\
 	spin_lock_irqsave(&wdata->state.lock, flags);			\
 									\
 	state = wdata->state.flags;					\
@@ -244,13 +237,6 @@ wiifs_led_show_set(4);
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
-	struct wiimote_data *wdata = input_get_drvdata(dev);
-
-	if (!atomic_read(&wdata->ready))
-		return -EBUSY;
-	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
-	smp_rmb();
-
 	return 0;
 }
 
@@ -300,11 +286,6 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	int i;
 	unsigned long flags;
 
-	if (!atomic_read(&wdata->ready))
-		return -EBUSY;
-	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
-	smp_rmb();
-
 	if (size < 1)
 		return -EINVAL;
 
@@ -362,6 +343,15 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led1);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led2);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led3);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led4);
+
+	input_unregister_device(wdata->input);
+	hid_hw_stop(wdata->hdev);
+
+	cancel_work_sync(&wdata->worker);
 	kfree(wdata);
 }
 
@@ -377,19 +367,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		return -ENOMEM;
 	}
 
-	ret = device_create_file(&hdev->dev, &dev_attr_led1);
-	if (ret)
-		goto err;
-	ret = device_create_file(&hdev->dev, &dev_attr_led2);
-	if (ret)
-		goto err;
-	ret = device_create_file(&hdev->dev, &dev_attr_led3);
-	if (ret)
-		goto err;
-	ret = device_create_file(&hdev->dev, &dev_attr_led4);
-	if (ret)
-		goto err;
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "HID parse failed\n");
@@ -408,9 +385,19 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
-	/* smp_wmb: Write wdata->xy first before wdata->ready is set to 1 */
-	smp_wmb();
-	atomic_set(&wdata->ready, 1);
+	ret = device_create_file(&hdev->dev, &dev_attr_led1);
+	if (ret)
+		goto err_free;
+	ret = device_create_file(&hdev->dev, &dev_attr_led2);
+	if (ret)
+		goto err_free;
+	ret = device_create_file(&hdev->dev, &dev_attr_led3);
+	if (ret)
+		goto err_free;
+	ret = device_create_file(&hdev->dev, &dev_attr_led4);
+	if (ret)
+		goto err_free;
+
 	hid_info(hdev, "New device registered\n");
 
 	/* by default set led1 after device initialization */
@@ -420,15 +407,15 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 
 	return 0;
 
+err_free:
+	wiimote_destroy(wdata);
+	return ret;
+
 err_stop:
 	hid_hw_stop(hdev);
 err:
 	input_free_device(wdata->input);
-	device_remove_file(&hdev->dev, &dev_attr_led1);
-	device_remove_file(&hdev->dev, &dev_attr_led2);
-	device_remove_file(&hdev->dev, &dev_attr_led3);
-	device_remove_file(&hdev->dev, &dev_attr_led4);
-	wiimote_destroy(wdata);
+	kfree(wdata);
 	return ret;
 }
 
@@ -437,16 +424,6 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 	struct wiimote_data *wdata = hid_get_drvdata(hdev);
 
 	hid_info(hdev, "Device removed\n");
-
-	device_remove_file(&hdev->dev, &dev_attr_led1);
-	device_remove_file(&hdev->dev, &dev_attr_led2);
-	device_remove_file(&hdev->dev, &dev_attr_led3);
-	device_remove_file(&hdev->dev, &dev_attr_led4);
-
-	hid_hw_stop(hdev);
-	input_unregister_device(wdata->input);
-
-	cancel_work_sync(&wdata->worker);
 	wiimote_destroy(wdata);
 }
 
-- 
1.7.6


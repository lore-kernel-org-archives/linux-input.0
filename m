From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH V2 1/5] HID: wiimote: Simplify synchronization
Date: Wed, 17 Aug 2011 11:43:20 +0200
Message-ID: <1313574204-12664-2-git-send-email-dh.herrmann@googlemail.com>
References: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55339 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1HQJn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 05:43:56 -0400
Received: by fxh19 with SMTP id 19so525065fxh.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 02:43:54 -0700 (PDT)
In-Reply-To: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: oliver@neukum.org, jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

The new locking scheme in HID core allows us to remove a bit of synchronization.
Since the HID layer acts synchronously we simply register input core last and
there are no synchonization issues anymore.
Also register sysfs files after that to simplify the code.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Fix wiimote_destroy(): first stop worker, then stop hid hardware as
mentioned by Oliver.
Also remove atomic.h header as it is not used anymore.

 drivers/hid/hid-wiimote.c |   78 +++++++++++++++-----------------------------
 1 files changed, 27 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index a594383..8a68bf5 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -10,7 +10,6 @@
  * any later version.
  */
 
-#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
@@ -33,7 +32,6 @@ struct wiimote_state {
 };
 
 struct wiimote_data {
-	atomic_t ready;
 	struct hid_device *hdev;
 	struct input_dev *input;
 
@@ -200,9 +198,6 @@ static ssize_t wiifs_led_show_##num(struct device *dev,			\
 	unsigned long flags;						\
 	int state;							\
 									\
-	if (!atomic_read(&wdata->ready))				\
-		return -EBUSY;						\
-									\
 	spin_lock_irqsave(&wdata->state.lock, flags);			\
 	state = !!(wdata->state.flags & WIIPROTO_FLAG_LED##num);	\
 	spin_unlock_irqrestore(&wdata->state.lock, flags);		\
@@ -217,9 +212,6 @@ static ssize_t wiifs_led_set_##num(struct device *dev,			\
 	unsigned long flags;						\
 	__u8 state;							\
 									\
-	if (!atomic_read(&wdata->ready))				\
-		return -EBUSY;						\
-									\
 	spin_lock_irqsave(&wdata->state.lock, flags);			\
 									\
 	state = wdata->state.flags;					\
@@ -244,13 +236,6 @@ wiifs_led_show_set(4);
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
 
@@ -300,11 +285,6 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	int i;
 	unsigned long flags;
 
-	if (!atomic_read(&wdata->ready))
-		return -EBUSY;
-	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
-	smp_rmb();
-
 	if (size < 1)
 		return -EINVAL;
 
@@ -362,6 +342,15 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led1);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led2);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led3);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_led4);
+
+	input_unregister_device(wdata->input);
+	cancel_work_sync(&wdata->worker);
+	hid_hw_stop(wdata->hdev);
+
 	kfree(wdata);
 }
 
@@ -377,19 +366,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
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
@@ -408,9 +384,19 @@ static int wiimote_hid_probe(struct hid_device *hdev,
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
@@ -420,15 +406,15 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 
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
 
@@ -437,16 +423,6 @@ static void wiimote_hid_remove(struct hid_device *hdev)
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


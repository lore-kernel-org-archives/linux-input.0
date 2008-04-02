From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 01/37] Input: remove private member from input_dev structure
Date: Wed, 2 Apr 2008 00:41:00 -0400
Message-ID: <3797fec17193e05dee9666b990d6c84e16b188b3.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156AbYDUNSk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:18:40 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106317waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:18:40 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Everyone should be using input_{get|set}_drvdata() by now.
Alias them to dev_{get|set}_drvdata() and remove ->private.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/input-polldev.c |    6 +++---
 include/linux/input.h         |    8 ++------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 490918a..0d3ce7a 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -73,7 +73,7 @@ static void input_polled_device_work(struct work_struct *work)
 
 static int input_open_polled_device(struct input_dev *input)
 {
-	struct input_polled_dev *dev = input->private;
+	struct input_polled_dev *dev = input_get_drvdata(input);
 	int error;
 
 	error = input_polldev_start_workqueue();
@@ -91,7 +91,7 @@ static int input_open_polled_device(struct input_dev *input)
 
 static void input_close_polled_device(struct input_dev *input)
 {
-	struct input_polled_dev *dev = input->private;
+	struct input_polled_dev *dev = input_get_drvdata(input);
 
 	cancel_delayed_work_sync(&dev->work);
 	input_polldev_stop_workqueue();
@@ -151,10 +151,10 @@ int input_register_polled_device(struct input_polled_dev *dev)
 {
 	struct input_dev *input = dev->input;
 
+	input_set_drvdata(input, dev);
 	INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
 	if (!dev->poll_interval)
 		dev->poll_interval = 500;
-	input->private = dev;
 	input->open = input_open_polled_device;
 	input->close = input_close_polled_device;
 
diff --git a/include/linux/input.h b/include/linux/input.h
index cae2c35..28a094f 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1025,10 +1025,6 @@ struct ff_effect {
  * @node: used to place the device onto input_dev_list
  */
 struct input_dev {
-	/* private: */
-	void *private;	/* do not use */
-	/* public: */
-
 	const char *name;
 	const char *phys;
 	const char *uniq;
@@ -1238,12 +1234,12 @@ static inline void input_put_device(struct input_dev *dev)
 
 static inline void *input_get_drvdata(struct input_dev *dev)
 {
-	return dev->private;
+	return dev_get_drvdata(&dev->dev);
 }
 
 static inline void input_set_drvdata(struct input_dev *dev, void *data)
 {
-	dev->private = data;
+	dev_set_drvdata(&dev->dev, data);
 }
 
 int __must_check input_register_device(struct input_dev *);
-- 
1.5.5.rc2.6.gf58d



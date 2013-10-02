From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Input: move name/timer init to input_alloc_dev()
Date: Wed,  2 Oct 2013 18:27:43 +0200
Message-ID: <1380731263-20962-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:56447 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab3JBQ1a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Oct 2013 12:27:30 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so518152eek.20
        for <linux-input@vger.kernel.org>; Wed, 02 Oct 2013 09:27:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

We want to allow drivers to call input_event() at any time after the
device got allocated. This means input_event() and input_register_device()
must be allowed to run in parallel.

The only conflicting calls in input_register_device() are init_timer() and
dev_set_name(). Both can safely be moved to device allocation and we're
good to go.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/input/input.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c044699..e75d015 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1734,6 +1734,7 @@ EXPORT_SYMBOL_GPL(input_class);
  */
 struct input_dev *input_allocate_device(void)
 {
+	static atomic_t input_no = ATOMIC_INIT(0);
 	struct input_dev *dev;
 
 	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
@@ -1743,9 +1744,13 @@ struct input_dev *input_allocate_device(void)
 		device_initialize(&dev->dev);
 		mutex_init(&dev->mutex);
 		spin_lock_init(&dev->event_lock);
+		init_timer(&dev->timer);
 		INIT_LIST_HEAD(&dev->h_list);
 		INIT_LIST_HEAD(&dev->node);
 
+		dev_set_name(&dev->dev, "input%ld",
+			     (unsigned long) atomic_inc_return(&input_no) - 1);
+
 		__module_get(THIS_MODULE);
 	}
 
@@ -2019,7 +2024,6 @@ static void devm_input_device_unregister(struct device *dev, void *res)
  */
 int input_register_device(struct input_dev *dev)
 {
-	static atomic_t input_no = ATOMIC_INIT(0);
 	struct input_devres *devres = NULL;
 	struct input_handler *handler;
 	unsigned int packet_size;
@@ -2059,7 +2063,6 @@ int input_register_device(struct input_dev *dev)
 	 * If delay and period are pre-set by the driver, then autorepeating
 	 * is handled by the driver itself and we don't do it in input.c.
 	 */
-	init_timer(&dev->timer);
 	if (!dev->rep[REP_DELAY] && !dev->rep[REP_PERIOD]) {
 		dev->timer.data = (long) dev;
 		dev->timer.function = input_repeat_key;
@@ -2073,9 +2076,6 @@ int input_register_device(struct input_dev *dev)
 	if (!dev->setkeycode)
 		dev->setkeycode = input_default_setkeycode;
 
-	dev_set_name(&dev->dev, "input%ld",
-		     (unsigned long) atomic_inc_return(&input_no) - 1);
-
 	error = device_add(&dev->dev);
 	if (error)
 		goto err_free_vals;
-- 
1.8.4


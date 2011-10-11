From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] Input: force feedback - potential integer wrap in
 input_ff_create()
Date: Wed, 12 Oct 2011 00:19:49 +0300
Message-ID: <20111011211949.GB30887@longonot.mountain>
References: <20111009162524.GA14049@elgon.mountain>
 <20111010050852.GA18794@core.coreip.homeip.net>
 <20111010204830.GV30887@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:40430 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab1JKVWn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 17:22:43 -0400
Content-Disposition: inline
In-Reply-To: <20111010204830.GV30887@longonot.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

The problem here is that max_effects can wrap on 32 bits systems.
We'd allocate a smaller amount of data than sizeof(struct ff_device).
The call to kcalloc() on the next line would fail but it would write
the NULL return outside of the memory we just allocated causing data
corruption.

The call path is that uinput_setup_device() get ->ff_effects_max from
the user and sets the value in the ->private_data struct.  From there
it is:
-> uinput_ioctl_handler()
   -> uinput_create_device()
      -> input_ff_create(dev, udev->ff_effects_max);

I've also changed ff_effects_max so it's an unsigned int instead of
a signed int as a cleanup.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
V2: made max_effects unsigned

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 3367f76..3051c84 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(input_ff_event);
  * Once ff device is created you need to setup its upload, erase,
  * playback and other handlers before registering input device
  */
-int input_ff_create(struct input_dev *dev, int max_effects)
+int input_ff_create(struct input_dev *dev, unsigned int max_effects)
 {
 	struct ff_device *ff;
 	int i;
@@ -319,6 +319,10 @@ int input_ff_create(struct input_dev *dev, int max_effects)
 		return -EINVAL;
 	}
 
+	if (sizeof(struct ff_device) + max_effects * sizeof(struct file *) <
+			max_effects)
+		return -EINVAL;
+
 	ff = kzalloc(sizeof(struct ff_device) +
 		     max_effects * sizeof(struct file *), GFP_KERNEL);
 	if (!ff)
diff --git a/include/linux/input.h b/include/linux/input.h
index 57add32..6d5eddb 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1610,7 +1610,7 @@ struct ff_device {
 	struct file *effect_owners[];
 };
 
-int input_ff_create(struct input_dev *dev, int max_effects);
+int input_ff_create(struct input_dev *dev, unsigned int max_effects);
 void input_ff_destroy(struct input_dev *dev);
 
 int input_ff_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
diff --git a/include/linux/uinput.h b/include/linux/uinput.h
index d28c726..2aa2881 100644
--- a/include/linux/uinput.h
+++ b/include/linux/uinput.h
@@ -68,7 +68,7 @@ struct uinput_device {
 	unsigned char		head;
 	unsigned char		tail;
 	struct input_event	buff[UINPUT_BUFFER_SIZE];
-	int			ff_effects_max;
+	unsigned int		ff_effects_max;
 
 	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
 	wait_queue_head_t	requests_waitq;

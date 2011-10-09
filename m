From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: force feedback - potential integer wrap in
 input_ff_create()
Date: Sun, 9 Oct 2011 19:25:24 +0300
Message-ID: <20111009162524.GA14049@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:22720 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1JIQZf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Oct 2011 12:25:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Smatch complains about max_effects because it's an int and we cap the
maximum size, but we don't check for negative.  A negative value here
could make "ff" smaller than sizeof(struct ff_device) and lead to
memory corruption.

I think max_effects can come from ->ff_effects_max in
uinput_setup_device() and that comes from the user so potentially
it could be negative.  The call path is that uinput_setup_device()
sets the value in the ->private_data struct.  From there it is:
-> uinput_ioctl_handler()
   -> uinput_create_device()
      -> input_ff_create(dev, udev->ff_effects_max);

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 3367f76..12422ed 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -319,6 +319,12 @@ int input_ff_create(struct input_dev *dev, int max_effects)
 		return -EINVAL;
 	}
 
+	if (max_effects < 0)
+		return -EINVAL;
+	if (sizeof(struct ff_device) + max_effects * sizeof(struct file *) <
+			max_effects)
+		return -EINVAL;
+
 	ff = kzalloc(sizeof(struct ff_device) +
 		     max_effects * sizeof(struct file *), GFP_KERNEL);
 	if (!ff)

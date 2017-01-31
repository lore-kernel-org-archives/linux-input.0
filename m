From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: refuse to register absolute devices without absinfo
Date: Tue, 31 Jan 2017 15:15:15 -0800
Message-ID: <20170131231515.GA37218@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36746 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdAaXPn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 18:15:43 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org

If device is supposed to send absolute events (i.e. EV_ABS bit is set in
dev->evbit) but dev->absinfo is not allocated, then the driver has done
something wrong, and we should not register such device. Otherwise we'll
crash later, when driver tries to send absolute event.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index f0d2d45a68e3..4617f2db9e36 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2095,6 +2095,12 @@ int input_register_device(struct input_dev *dev)
 	const char *path;
 	int error;
 
+	if (test_bit(EV_ABS, dev->evbit) && !dev->absinfo) {
+		dev_err(&dev->dev,
+			"Absolute device without dev->absinfo, refusing to register\n");
+		return -EINVAL;
+	}
+
 	if (dev->devres_managed) {
 		devres = devres_alloc(devm_input_device_unregister,
 				      sizeof(struct input_devres), GFP_KERNEL);
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry

From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input-polldev:Check poll_interval range while registering input device
Date: Thu, 16 Jul 2015 10:57:13 -0700
Message-ID: <1437069433-76366-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34757 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065AbbGPR6H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 13:58:07 -0400
Received: by pacan13 with SMTP id an13so46657602pac.1
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 10:58:06 -0700 (PDT)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com

Added check for poll_interval range in input_register_polled_device
function similar to input_polldev_set_poll function.

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 drivers/input/input-polldev.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 3664f81..0e88a9e 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -309,6 +309,12 @@ int input_register_polled_device(struct input_polled_dev *dev)
 
 	input_set_drvdata(input, dev);
 	INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
+
+	if (dev->poll_interval > dev->poll_interval_max ||
+			dev->poll_interval < dev->poll_interval_min) {
+		pr_err("Poll interval Range incorrect\n");
+		return -EINVAL;
+	}
 
 	if (!dev->poll_interval)
 		dev->poll_interval = 500;
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus


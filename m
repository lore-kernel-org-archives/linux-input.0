From: anshul.g@samsung.com
Subject: [PATCH] Input: Add check for grabbed device before flushing the device
Date: Tue, 30 Dec 2014 11:17:50 +0530
Message-ID: <1419918470-14940-1-git-send-email-anshul.g@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30326 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbaL3Fsh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Dec 2014 00:48:37 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NHD000KPS4Z1950@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 30 Dec 2014 14:48:35 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com, p.shailesh@samsung.com

From: Anshul Garg <anshul.g@samsung.com>

If input device is grabbed then client which grabbed the device should only
flush the device and for other clients error should be returned.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/evdev.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index fd325ec..70df398 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -248,6 +248,8 @@ static int evdev_flush(struct file *file, fl_owner_t id)
 
 	if (!evdev->exist || client->revoked)
 		retval = -ENODEV;
+	else if (evdev->grab != client)
+		retval = -EINVAL;
 	else
 		retval = input_flush_device(&evdev->handle, file);
 
-- 
1.7.9.5


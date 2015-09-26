From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Input: serio - fix blocking of parport
Date: Sat, 26 Sep 2015 18:53:21 +0530
Message-ID: <1443273801-8822-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35184 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbbIZNX3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Sep 2015 09:23:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, stable@vger.kernel.org

If parkbd_allocate_serio() fails to allocate memory we are releasing the
parport but we missed unregistering the device. As a result this device
with exclusive access to that parport remains registered. And no other
device will be able to use that parport even though this driver has
failed to load.

Cc: <stable@vger.kernel.org> # 2.6.32+
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

Faced this problem while creating the patch series for input to use
parallel port device model.

 drivers/input/serio/parkbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
index 26b4593..1e8cd6f 100644
--- a/drivers/input/serio/parkbd.c
+++ b/drivers/input/serio/parkbd.c
@@ -194,6 +194,7 @@ static int __init parkbd_init(void)
 	parkbd_port = parkbd_allocate_serio();
 	if (!parkbd_port) {
 		parport_release(parkbd_dev);
+		parport_unregister_device(parkbd_dev);
 		return -ENOMEM;
 	}
 
-- 
1.9.1


From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 25/35] Input: touchscreen: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:15:34 +0900
Message-ID: <005401ce8cfc$f70d1500$e5273f00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55060 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991Ab3G3IPg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 04:15:36 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ00FCDPLYDFS0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Tue, 30 Jul 2013 17:15:34 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/joystick/as5011.c       |    2 +-
 drivers/input/joystick/maplecontrol.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 121cd63..13eba2a 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -234,7 +234,7 @@ static int as5011_probe(struct i2c_client *client,
 	int irq;
 	int error;
 
-	plat_data = client->dev.platform_data;
+	plat_data = dev_get_platdata(&client->dev);
 	if (!plat_data)
 		return -EINVAL;
 
diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 59c10ec..8aa6e4c 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -61,7 +61,7 @@ static void dc_pad_callback(struct mapleq *mq)
 
 static int dc_pad_open(struct input_dev *dev)
 {
-	struct dc_pad *pad = dev->dev.platform_data;
+	struct dc_pad *pad = dev_get_platdata(&dev->dev);
 
 	maple_getcond_callback(pad->mdev, dc_pad_callback, HZ/20,
 		MAPLE_FUNC_CONTROLLER);
@@ -71,7 +71,7 @@ static int dc_pad_open(struct input_dev *dev)
 
 static void dc_pad_close(struct input_dev *dev)
 {
-	struct dc_pad *pad = dev->dev.platform_data;
+	struct dc_pad *pad = dev_get_platdata(&dev->dev);
 
 	maple_getcond_callback(pad->mdev, dc_pad_callback, 0,
 		MAPLE_FUNC_CONTROLLER);
-- 
1.7.10.4



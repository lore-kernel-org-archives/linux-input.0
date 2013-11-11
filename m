From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] Input: mpu3050 - add missing i2c_set_clientdata() in mpu3050_probe()
Date: Mon, 11 Nov 2013 14:18:54 +0800
Message-ID: <CAPgLHd-ujkwTBn=hUH6SxfhHpYHyGqvrkcyuRTFkXmWtqE2Zjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:40319 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3KKGSz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 01:18:55 -0500
Received: by mail-bk0-f49.google.com with SMTP id w14so1845272bkz.22
        for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 22:18:54 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, wfp5p@virginia.edu, broonie@opensource.wolfsonmicro.com, javier@dowhile0.org, rmk+kernel@arm.linux.org.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing i2c_set_clientdata() in mpu3050_probe(), otherwise
calling i2c_get_clientdata() in mpu3050_remove() returns NULL.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/misc/mpu3050.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index dce0d95..6983ffb 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -383,6 +383,7 @@ static int mpu3050_probe(struct i2c_client *client,
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, MPU3050_AUTO_DELAY);
+	i2c_set_clientdata(client, sensor);
 
 	return 0;
 


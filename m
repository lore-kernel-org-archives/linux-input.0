From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] Input: as5011 - fix error return code in as5011_probe()
Date: Fri, 23 Aug 2013 10:54:55 +0800
Message-ID: <CAPgLHd_zTAT7hGkcNCBCzKE5TiXfCYzCysbCDANX2vBDyrpH8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:40122 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab3HWCy4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Aug 2013 22:54:56 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so31230bkg.8
        for <linux-input@vger.kernel.org>; Thu, 22 Aug 2013 19:54:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, wfp5p@virginia.edu, broonie@opensource.wolfsonmicro.com, shubhrajyoti@ti.com, javier@dowhile0.org
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/joystick/as5011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 121cd63..262ebe2 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -288,6 +288,7 @@ static int as5011_probe(struct i2c_client *client,
 	if (irq < 0) {
 		dev_err(&client->dev,
 			"Failed to get irq number for button gpio\n");
+		error = irq;
 		goto err_free_button_gpio;
 	}
 


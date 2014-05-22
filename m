From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 3/3] Input: mcs5000_ts: fix incorrect input device name
Date: Thu, 22 May 2014 09:02:52 +0900
Message-ID: <537D3EAC.3080300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14623 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbaEVACx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 20:02:53 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5Y005I184SQVC0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Thu, 22 May 2014 09:02:52 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

This patch fix a typo error in MELFAS MCS-5000 controller driver.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/mcs5000_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 647e36f..97a005d 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -208,7 +208,7 @@ static int mcs5000_ts_probe(struct i2c_client *client,
 	data->input_dev = input_dev;
 	data->platform_data = dev_get_platdata(&client->dev);

-	input_dev->name = "MELPAS MCS-5000 Touchscreen";
+	input_dev->name = "MELFAS MCS-5000 Touchscreen";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;

-- 
1.7.9.5

From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 2/3] Input: mms114: fix incorrect input device name
Date: Thu, 22 May 2014 09:02:42 +0900
Message-ID: <537D3EA2.8020206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51728 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbaEVACp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 20:02:45 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5Y0005984KX5C0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Thu, 22 May 2014 09:02:44 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

This patch fix a typo error in mms114 touchscreen driver.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/mms114.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 9d83413..372bbf7 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -456,7 +456,7 @@ static int mms114_probe(struct i2c_client *client,
 	data->input_dev = input_dev;
 	data->pdata = pdata;

-	input_dev->name = "MELPAS MMS114 Touchscreen";
+	input_dev->name = "MELFAS MMS114 Touchscreen";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 	input_dev->open = mms114_input_open;
-- 
1.7.9.5

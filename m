From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 1/3] Input: mcs_touchkey: fix incorrect input device name
Date: Thu, 22 May 2014 09:02:32 +0900
Message-ID: <537D3E98.7090802@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51687 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbaEVACe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 20:02:34 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5Y0045D849Y7B0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Thu, 22 May 2014 09:02:33 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

This patch fix a typo error in MELFAS 5000/5080 controller driver.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/keyboard/mcs_touchkey.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 1da8e0b..375b05c 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -147,7 +147,7 @@ static int mcs_touchkey_probe(struct i2c_client *client,
 	}
 	dev_info(&client->dev, "Firmware version: %d\n", fw_ver);

-	input_dev->name = "MELPAS MCS Touchkey";
+	input_dev->name = "MELFAS MCS Touchkey";
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 	input_dev->evbit[0] = BIT_MASK(EV_KEY);
-- 
1.7.9.5

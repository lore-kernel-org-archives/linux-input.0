From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input-mpr121: Use common error handling code in
 mpr_touchkey_interrupt()
Date: Thu, 26 Oct 2017 21:23:56 +0200
Message-ID: <38f2360b-5f45-b6e6-4e7d-a9cc1a43939a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:53524 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932174AbdJZTYw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Oct 2017 15:24:52 -0400
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>, Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Oct 2017 21:16:53 +0200

Add a jump target so that an error message can be better reused
in an if branch of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/mpr121_touchkey.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 884a74d8a7ed..af840a842246 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -129,14 +129,13 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 	int reg;
 
 	reg = i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_1_ADDR);
-	if (reg < 0) {
-		dev_err(&client->dev, "i2c read error [%d]\n", reg);
-		goto out;
-	}
+	if (reg < 0)
+		goto report_read_failure;
 
 	reg <<= 8;
 	reg |= i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_0_ADDR);
 	if (reg < 0) {
+report_read_failure:
 		dev_err(&client->dev, "i2c read error [%d]\n", reg);
 		goto out;
 	}
-- 
2.14.3


From: Sangwon Jee <jeesw@melfas.com>
Subject: Input: melfas_mip4 - add product ID reporting
Date: Tue,  1 Nov 2016 17:53:12 +0900
Message-ID: <1477990392-7606-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:18434 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168054AbcKAIxR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Nov 2016 04:53:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

Add reporting product ID through input_id.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 0f2230a..f160390 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1477,6 +1477,7 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	input->id.bustype = BUS_I2C;
 	input->id.vendor = 0x13c5;
+	input->id.product = ts->product_id;
 
 	input->open = mip4_input_open;
 	input->close = mip4_input_close;
@@ -1614,6 +1615,6 @@ static struct i2c_driver mip4_driver = {
 module_i2c_driver(mip4_driver);
 
 MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
-MODULE_VERSION("2016.10.24");
+MODULE_VERSION("2016.10.31");
 MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
 MODULE_LICENSE("GPL");
-- 
1.9.1


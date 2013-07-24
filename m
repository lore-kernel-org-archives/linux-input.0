From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] Input: egalax_ts - Provide a .remove function
Date: Wed, 24 Jul 2013 17:46:09 -0300
Message-ID: <1374698769-25664-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:18175
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab3GXUqW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jul 2013 16:46:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: shawn.guo@linaro.org, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Provide a .remove function so that we can unregister the input device.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/touchscreen/egalax_ts.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index ef5fcb0..e46be61 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -234,6 +234,16 @@ static int egalax_ts_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int egalax_ts_remove(struct i2c_client *client)
+{
+	struct egalax_ts *ts = i2c_get_clientdata(client);
+
+	input_unregister_device(ts->input_dev);
+	kfree(ts);
+
+	return 0;
+}
+
 static const struct i2c_device_id egalax_ts_id[] = {
 	{ "egalax_ts", 0 },
 	{ }
@@ -277,6 +287,7 @@ static struct i2c_driver egalax_ts_driver = {
 	},
 	.id_table	= egalax_ts_id,
 	.probe		= egalax_ts_probe,
+	.remove		= egalax_ts_remove,
 };
 
 module_i2c_driver(egalax_ts_driver);
-- 
1.8.1.2



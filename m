From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: edt-ft5x06: Delete an error message for a failed
 memory allocation in edt_ft5x06_ts_probe()
Date: Sun, 21 Jan 2018 20:19:00 +0100
Message-ID: <45f8a6c2-423b-5bc1-6512-c5b954c5620b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Andi Shyti <andi@etezian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>, Martin Kepplinger <martink@posteo.de>, Rob Herring <robh@kernel.org>, Simon Budig <simon.budig@kernelconcepts.de>, =?UTF-8?Q?Stefan_Sch=c3=b6fegger?= <stefan.schoefegger@ginzinger.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 20:10:03 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/edt-ft5x06.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index c53a3d7239e7..9d2799c90150 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -978,10 +978,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
 
 	tsdata = devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
-	if (!tsdata) {
-		dev_err(&client->dev, "failed to allocate driver data.\n");
+	if (!tsdata)
 		return -ENOMEM;
-	}
 
 	chip_data = of_device_get_match_data(&client->dev);
 	if (!chip_data)
-- 
2.16.0

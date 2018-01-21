From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: egalax_ts: Delete an error message for a failed
 memory allocation in egalax_ts_probe()
Date: Sun, 21 Jan 2018 19:50:21 +0100
Message-ID: <99b5c583-e215-82eb-701c-6796b605fb92@users.sourceforge.net>
References: <52f0c32d-2cf9-bef3-4fb3-4120c5b758c4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52f0c32d-2cf9-bef3-4fb3-4120c5b758c4@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 19:34:38 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/egalax_ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 752ae9cf4514..29ec1166626d 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -172,10 +172,8 @@ static int egalax_ts_probe(struct i2c_client *client,
 	int error;
 
 	ts = devm_kzalloc(&client->dev, sizeof(struct egalax_ts), GFP_KERNEL);
-	if (!ts) {
-		dev_err(&client->dev, "Failed to allocate memory\n");
+	if (!ts)
 		return -ENOMEM;
-	}
 
 	input_dev = devm_input_allocate_device(&client->dev);
 	if (!input_dev) {
-- 
2.16.0

From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: egalax_ts: Improve a size determination in
 egalax_ts_probe()
Date: Sun, 21 Jan 2018 19:51:23 +0100
Message-ID: <9010bf32-e058-d29d-8ea2-acb43f200175@users.sourceforge.net>
References: <52f0c32d-2cf9-bef3-4fb3-4120c5b758c4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <52f0c32d-2cf9-bef3-4fb3-4120c5b758c4@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 19:40:30 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/egalax_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 29ec1166626d..da8b46ee2c1c 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -171,7 +171,7 @@ static int egalax_ts_probe(struct i2c_client *client,
 	struct input_dev *input_dev;
 	int error;
 
-	ts = devm_kzalloc(&client->dev, sizeof(struct egalax_ts), GFP_KERNEL);
+	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
-- 
2.16.0


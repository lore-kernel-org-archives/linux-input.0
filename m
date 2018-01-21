From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: eeti_ts: Delete an error message for a failed memory
 allocation in eeti_ts_probe()
Date: Sun, 21 Jan 2018 20:05:14 +0100
Message-ID: <c1bb1997-5430-1173-1d54-b63bc72af156@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 20:00:03 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/eeti_ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 2facad75eb6d..337f171e0f86 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -161,10 +161,8 @@ static int eeti_ts_probe(struct i2c_client *client,
 	 */
 
 	eeti = devm_kzalloc(dev, sizeof(*eeti), GFP_KERNEL);
-	if (!eeti) {
-		dev_err(dev, "failed to allocate driver data\n");
+	if (!eeti)
 		return -ENOMEM;
-	}
 
 	input = devm_input_allocate_device(dev);
 	if (!input) {
-- 
2.16.0

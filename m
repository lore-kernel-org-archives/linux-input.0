From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: auo-pixcir-ts: Delete an error message for a
 failed memory allocation in auo_pixcir_parse_dt()
Date: Sun, 21 Jan 2018 22:15:16 +0100
Message-ID: <4f101927-97fe-1d8d-2bd7-4d9c3e2de8c5@users.sourceforge.net>
References: <df18b548-f95e-e315-9e77-f379af7909e8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <df18b548-f95e-e315-9e77-f379af7909e8@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 22:02:32 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/auo-pixcir-ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 6592fc5d48b4..398e27c48a51 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -487,10 +487,8 @@ static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOENT);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(dev, "failed to allocate platform data\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	pdata->gpio_int = of_get_gpio(np, 0);
 	if (!gpio_is_valid(pdata->gpio_int)) {
-- 
2.16.0

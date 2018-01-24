From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: arc_ps2: Delete an error message for a failed
 memory allocation in arc_ps2_probe()
Date: Wed, 24 Jan 2018 18:39:10 +0100
Message-ID: <dff3cfe5-c994-1ee1-5b9e-fde79fd3cfd9@users.sourceforge.net>
References: <f3c837b2-7be1-11fe-ba2c-1792590125d2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3c837b2-7be1-11fe-ba2c-1792590125d2@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 18:17:32 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/serio/arc_ps2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 99e57a418753..9860b1c1e67a 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -197,10 +197,8 @@ static int arc_ps2_probe(struct platform_device *pdev)
 
 	arc_ps2 = devm_kzalloc(&pdev->dev, sizeof(struct arc_ps2_data),
 				GFP_KERNEL);
-	if (!arc_ps2) {
-		dev_err(&pdev->dev, "out of memory\n");
+	if (!arc_ps2)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	arc_ps2->addr = devm_ioremap_resource(&pdev->dev, res);
-- 
2.16.1

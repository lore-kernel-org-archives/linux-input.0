From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: sh_keysc: Delete an error message for a failed memory
 allocation in sh_keysc_probe()
Date: Thu, 25 Jan 2018 22:06:01 +0100
Message-ID: <28d7c2df-81ed-95b3-ba9d-bf6c8aa00197@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 22:02:46 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/sh_keysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index 7abf03b4cc9c..e214d47724f8 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -191,7 +191,6 @@ static int sh_keysc_probe(struct platform_device *pdev)
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		error = -ENOMEM;
 		goto err0;
 	}
-- 
2.16.1
